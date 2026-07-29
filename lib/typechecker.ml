open Ast

module StringMap = Map.Make(String)

type var_state = Live | Consumed

type env = {
  funcs: fn_decl StringMap.t;
  vars: (typ * bool * var_state) StringMap.t;
  globals: typ StringMap.t;
  enums: enum_decl StringMap.t;
  structs: struct_decl StringMap.t;
  imports: string list StringMap.t;
  ret_typ: typ option;
  current_role: string;
}

let empty_env = {
  funcs = StringMap.empty;
  vars = StringMap.empty;
  globals = StringMap.empty;
  enums = StringMap.empty;
  structs = StringMap.empty;
  imports = StringMap.empty;
  ret_typ = None;
  current_role = "Main";
}

exception TypeError of string

let is_int_type = function
  | TBase TU8 | TBase TU16 | TBase TU32 | TBase TU64
  | TBase TI8 | TBase TI16 | TBase TI32 | TBase TI64 -> true
  | TRole (TBase TU8, _) | TRole (TBase TU16, _) | TRole (TBase TU32, _) | TRole (TBase TU64, _)
  | TRole (TBase TI8, _) | TRole (TBase TI16, _) | TRole (TBase TI32, _) | TRole (TBase TI64, _) -> true
  | _ -> false

let is_bool_type = function
  | TBase TBool -> true
  | TRole (TBase TBool, _) -> true
  | _ -> false

let is_str_type = function
  | TBase TStr -> true
  | TRole (TBase TStr, _) -> true
  | _ -> false

let rec is_printable t =
  match t with
  | TBase _ -> true
  | TArray _ -> true
  | TResult _ -> true
  | TRole (inner, _) -> is_printable inner

let rec types_compatible expected actual =
  if expected = actual then true
  else match expected, actual with
  | TResult (e1, e2), TResult (a1, a2) ->
      let c1 = (a1 = TBase (TCustom "_") || types_compatible e1 a1) in
      let c2 = (a2 = TBase (TCustom "_") || types_compatible e2 a2) in
      c1 && c2
  | TRole (t_exp, r_exp), TRole (t_act, r_act) ->
      if r_exp = r_act then types_compatible t_exp t_act else false
  | _, _ -> false

let is_integer_type = function
  | TU8 | TU16 | TU32 | TU64 | TI8 | TI16 | TI32 | TI64 -> true
  | _ -> false

let rec check_expr env e expected_typ_opt =
  match e with
  | ELit (LInt (_, t_opt)) -> 
      (match t_opt with
      | Some t -> TBase t, env
      | None ->
          (match expected_typ_opt with
          | Some (TBase t) when is_integer_type t -> TBase t, env
          | _ -> TBase TI32, env))
  | ELit (LBool _) -> TBase TBool, env
  | ELit (LStr _) -> TBase TStr, env
  | EVar name ->
      (match StringMap.find_opt name env.vars with
      | Some (_, _, Consumed) -> raise (TypeError ("Variable " ^ name ^ " has already been consumed"))
      | Some (t, is_mut, Live) ->
          let new_vars = match t with
            | TRole _ -> StringMap.add name (t, is_mut, Consumed) env.vars
            | _ -> env.vars
          in
          t, { env with vars = new_vars }
      | None ->
          (match StringMap.find_opt name env.globals with
          | Some t ->
              let global_role = match t with | TRole (_, r) -> r | _ -> "Main" in
              if global_role <> env.current_role then raise (TypeError ("Cannot access global " ^ name ^ " from role " ^ env.current_role));
              t, env
          | None -> raise (TypeError ("Undefined variable: " ^ name))))
  | ECall (name, args) ->
      (match StringMap.find_opt name env.funcs with
      | Some f ->
        if List.length args <> List.length f.params then raise (TypeError ("Arity mismatch for " ^ name));
        let env_after_args = List.fold_left2 (fun env_acc (p : Ast.param) arg ->
            let t_arg, env_next = check_expr env_acc arg (Some p.typ) in
            if not (types_compatible p.typ t_arg) then raise (TypeError ("Argument type mismatch in call to " ^ name));
            env_next
          ) env f.params args in
          let f_role = Option.value f.role ~default:"Main" in
          let base_ret = Option.value f.ret_typ ~default:(TBase TUnit) in
          let final_ret = if f_role = env.current_role then base_ret else TRole (base_ret, f_role) in
          final_ret, env_after_args
      | None -> raise (TypeError ("Undefined function: " ^ name)))
  | EPathCall (path, args) ->
      let prefix = List.hd path in
      if StringMap.mem prefix env.enums then (
        if List.length path <> 2 then raise (TypeError "Invalid enum variant path");
        let enum_name = prefix in
        let variant_name = List.nth path 1 in
        let enum_decl = StringMap.find enum_name env.enums in
        if not (List.exists (fun (m: Ast.enum_member) -> m.name = variant_name) enum_decl.members) then
          raise (TypeError ("Enum variant not found: " ^ variant_name));
        TBase (TCustom enum_name), env
      ) else
      let resolved_path =
        match StringMap.find_opt prefix env.imports with
        | Some actual_module -> actual_module @ (List.tl path)
        | None -> path
      in
      if resolved_path = ["std"; "io"; "println"] || resolved_path = ["std"; "io"; "print"] then (
        if List.length args <> 1 then raise (TypeError ("print/println expects 1 argument"));
        let arg_t, env_next = check_expr env (List.hd args) None in
        if not (is_printable arg_t) then
          raise (TypeError "print/println argument must be printable");
        TBase TUnit, env_next
      ) else if resolved_path = ["std"; "hw"; "bind_interrupt"] then (
        if List.length args <> 2 then raise (TypeError ("bind_interrupt expects 2 arguments"));
        let t_irq, env_next = check_expr env (List.hd args) None in
        if not (is_int_type t_irq) then raise (TypeError "IRQ number must be an integer");
        let handler_arg = List.nth args 1 in
        (match handler_arg with
         | EVar name ->
             (match StringMap.find_opt name env_next.funcs with
              | Some fn ->
                  let expected_role = "ISR" in
                  if Option.value fn.role ~default:"Main" <> expected_role then
                    raise (TypeError ("Interrupt handler must have role " ^ expected_role));
                  if List.length fn.params <> 0 then
                    raise (TypeError "Interrupt handler must not take parameters");
                  TBase TUnit, env_next
              | None -> raise (TypeError ("Interrupt handler must be a function: " ^ name)))
         | _ -> raise (TypeError "Interrupt handler must be a function reference by name"))
      ) else
        raise (TypeError ("Undefined path call: " ^ String.concat "::" resolved_path))
  | EBinOp (e1, op, e2) ->
      let expected_e1 = match op with
        | Add | Sub | Mul | Div | Shl | Shr | BitAnd | BitOr -> expected_typ_opt
        | Eq | Neq | Lt | Gt | Lte | Gte -> None
      in
      let t1, env1 = check_expr env e1 expected_e1 in
      let t2, env2 = check_expr env1 e2 (Some t1) in
      if not (types_compatible t1 t2) then raise (TypeError "Binary operator operands must have compatible types");
      (match op with
      | Add | Sub | Mul | Div | Shl | Shr | BitAnd | BitOr ->
          if is_int_type t1 then t1, env2
          else raise (TypeError "Arithmetic/Bitwise operators require integer types")
      | Eq | Neq ->
          TBase TBool, env2
      | Lt | Gt | Lte | Gte ->
          if is_int_type t1 then TBase TBool, env2
          else raise (TypeError "Comparison operators require integer types"))
  | EOk (e, _) ->
      let t, env1 = check_expr env e None in
      TResult (t, TBase (TCustom "_")), env1
  | EErr (e, _) ->
      let t, env1 = check_expr env e None in
      TResult (TBase (TCustom "_"), t), env1
  | EIf (cond, thn, els) ->
      let t_cond, env1 = check_expr env cond (Some (TBase TBool)) in
      if not (is_bool_type t_cond) then raise (TypeError "if condition must be bool");
      let env_thn, t_thn = check_block env1 thn in
      (match els with
      | Some e_block ->
          let _env_els, t_els = check_block env1 e_block in
          if not (types_compatible (Option.value t_thn ~default:(TBase TUnit)) (Option.value t_els ~default:(TBase TUnit))) then 
            raise (TypeError "if and else branches must have same return type");
          Option.value t_thn ~default:(TBase TU8), env_thn
      | None ->
          if t_thn <> None then raise (TypeError "if without else cannot return a value");
          Option.value t_thn ~default:(TBase TUnit), env_thn)
  | EStruct (name, fields, _) ->
      (match StringMap.find_opt name env.structs with
      | Some s_decl ->
          if List.length fields <> List.length s_decl.fields then
            raise (TypeError ("Struct " ^ name ^ " field count mismatch"));
          let env_final = List.fold_left (fun env_acc (f_decl : Ast.field) ->
            match List.assoc_opt f_decl.name fields with
            | Some e ->
                let t_e, env_next = check_expr env_acc e None in
                if not (types_compatible f_decl.typ t_e) then raise (TypeError ("Struct " ^ name ^ " field " ^ f_decl.name ^ " type mismatch"));
                env_next
            | None -> raise (TypeError ("Struct " ^ name ^ " missing field " ^ f_decl.name))
          ) env s_decl.fields in
          TBase (TCustom name), env_final
      | None -> raise (TypeError ("Undeclared struct: " ^ name)))
  | EField (e, field_name) ->
      let t_e, env1 = check_expr env e None in
      let base = match t_e with TRole (b, _) -> b | _ -> t_e in
      (match base with
      | TBase (TCustom name) ->
          (match StringMap.find_opt name env1.structs with
          | Some s_decl ->
              (match List.find_opt (fun (f : Ast.field) -> f.name = field_name) s_decl.fields with
              | Some f -> f.typ, env1
              | None -> raise (TypeError ("Field " ^ field_name ^ " not found in struct " ^ name)))
          | None -> raise (TypeError ("Unknown struct type for field access")))
      | _ -> raise (TypeError "Field access on non-struct type"))
  | EMatch (e, arms) ->
      let t_e, env1 = check_expr env e None in
      let arm_results = List.map (fun (pat, e_arm) ->
        let env_arm = match pat with
          | PIdent id -> { env1 with vars = StringMap.add id (t_e, false, Live) env1.vars }
          | PVariant ("Ok", Some [PIdent id]) ->
              (match t_e with
              | TResult (t1, _) -> { env1 with vars = StringMap.add id (t1, false, Live) env1.vars }
              | _ -> env1)
          | PVariant ("Err", Some [PIdent id]) ->
              (match t_e with
              | TResult (_, t2) -> { env1 with vars = StringMap.add id (t2, false, Live) env1.vars }
              | _ -> env1)
          | _ -> env1
        in
        check_expr env_arm e_arm None
      ) arms in
      let first_t, first_env = List.hd arm_results in
      List.iter (fun (t, _) -> if not (types_compatible t first_t) then raise (TypeError "Match arms have different types")) arm_results;
      first_t, first_env
  | ECast (e, t) ->
      let t_e, env1 = check_expr env e None in
      if not (is_int_type t_e || is_bool_type t_e) || not (is_int_type t || is_bool_type t) then
        raise (TypeError "Can only cast between numeric/boolean types");
      t, env1
  | EArray elems ->
      if elems = [] then raise (TypeError "Empty arrays not supported without explicit type annotation");
      let (t_first, env_first) = check_expr env (List.hd elems) None in
      let env_final = List.fold_left (fun env_acc elem ->
        let t_elem, env_next = check_expr env_acc elem None in
        if not (types_compatible t_first t_elem) then raise (TypeError "Array elements must have the same type");
        env_next
      ) env_first (List.tl elems) in
      TArray t_first, env_final
  | EIndex (arr, i) ->
      let t_arr, env2 = check_expr env arr None in
      let t_i, env3 = check_expr env2 i None in
      if not (is_int_type t_i) then raise (TypeError "Array index must be an integer");
      let base_arr_t = match t_arr with | TRole (inner, _) -> inner | _ -> t_arr in
      (match base_arr_t with
      | TArray t_elem -> t_elem, env3
      | _ -> raise (TypeError "Cannot index non-array type"))
  | ETransfer (e, role) ->
      let t_e, env1 = check_expr env e None in
      let base_t = match t_e with
        | TRole (inner, _) -> inner
        | _ -> t_e
      in
      (TRole (base_t, role), env1)
  | EDup (_, e) -> check_expr env e None

and check_stmt env stmt =
  match stmt with
  | SDecl { kind; name; typ; init } ->
      let t_init, env1 = check_expr env init typ in
      (match typ with
      | Some t -> if not (types_compatible t t_init) then raise (TypeError ("Type mismatch in declaration for " ^ name))
      | None -> ());
      let t_final = Option.value typ ~default:t_init in
      if kind = VConst then (
         (match init with
         | ELit _ -> ()
         | _ -> raise (TypeError ("const " ^ name ^ " must be initialized with a constant literal")))
      );
      let is_mut = (kind = VVar) in
      { env1 with vars = StringMap.add name (t_final, is_mut, Live) env1.vars }
  | SAssign (lhs, e) ->
      (match lhs with
      | EVar name ->
          (match StringMap.find_opt name env.vars with
          | Some (var_t, true, Live) ->
              let t_e, env1 = check_expr env e (Some var_t) in
              if not (types_compatible var_t t_e) then raise (TypeError ("Type mismatch in assignment to " ^ name));
              { env1 with vars = StringMap.add name (t_e, true, Live) env1.vars }
          | Some (_, false, _) -> raise (TypeError ("Cannot reassign immutable variable " ^ name))
          | Some (_, _, Consumed) -> raise (TypeError ("Cannot reassign consumed variable " ^ name))
          | None ->
              (match StringMap.find_opt name env.globals with
              | Some t_var ->
                  let t_e, env1 = check_expr env e (Some t_var) in
                  let global_role = match t_var with | TRole (_, r) -> r | _ -> "Main" in
                  if global_role <> env1.current_role then raise (TypeError ("Cannot access global " ^ name ^ " from role " ^ env1.current_role));
                  if not (types_compatible t_var t_e) then raise (TypeError "Assignment type mismatch");
                  env1
              | None -> raise (TypeError ("Undefined variable in assignment: " ^ name))))
      | EIndex (arr, i) ->
          let t_arr, env_arr = check_expr env arr None in
          let t_i, env_i = check_expr env_arr i None in
          if not (is_int_type t_i) then raise (TypeError "Array index must be an integer");
          let base_arr_t = match t_arr with | TRole (inner, _) -> inner | _ -> t_arr in
          (match base_arr_t with
          | TArray t_elem ->
              let t_e, env_final = check_expr env_i e (Some t_elem) in
              if not (types_compatible t_elem t_e) then raise (TypeError "Array assignment type mismatch");
              (match arr with
              | EVar name ->
                  (match StringMap.find_opt name env_final.vars with
                  | Some (_, is_mut, _) ->
                      if not is_mut then raise (TypeError ("Cannot mutate immutable array: " ^ name))
                  | None -> ())
              | _ -> ());
              env_final
          | _ -> raise (TypeError "Cannot index assign non-array type"))
      | _ -> raise (TypeError "Invalid left-hand side in assignment"))
  | SExpr e ->
      let _, env1 = check_expr env e None in
      env1
  | SWhile (cond, b) ->
      let t_cond, env1 = check_expr env cond None in
      if not (is_bool_type t_cond) then raise (TypeError "while condition must be bool");
      let env2, _ = check_block env1 b in
      env2
  | SFor (id, e, b) ->
      let _t_e, env1 = check_expr env e None in
      let env_for = { env1 with vars = StringMap.add id (TBase TU8, false, Live) env1.vars } in
      let env2, _ = check_block env_for b in
      env2
  | SReturn e_opt ->
      StringMap.iter (fun name (t, _, state) ->
        match t with
        | TRole _ when state = Live -> 
            raise (TypeError ("Cannot return early with unconsumed linear resource: " ^ name))
        | _ -> ()
      ) env.vars;
      (match e_opt, env.ret_typ with
      | Some e, Some expected_t ->
          let t_e, env1 = check_expr env e (Some expected_t) in
          if not (types_compatible expected_t t_e) then raise (TypeError "Return type mismatch");
          env1
      | None, Some expected_t ->
          if not (types_compatible expected_t (TBase TUnit) || expected_t = TBase TU8) then raise (TypeError "Return expects a value");
          env
      | Some _, None -> raise (TypeError "Cannot return a value from a unit function")
      | None, None -> env)
  | SDrop x ->
      if not (StringMap.mem x env.vars) then raise (TypeError ("Cannot drop undefined variable: " ^ x));
      env

and check_block env block =
  let env_final = List.fold_left check_stmt env block.stmts in
  match block.ret_expr with
  | Some e ->
      let t_e, env_ret = check_expr env_final e None in
      env_ret, Some t_e
  | None ->
      env_final, None

let check_fn_decl env (fn: Ast.fn_decl) =
  let initial_vars = List.fold_left (fun acc (p: Ast.param) ->
    StringMap.add p.name (p.typ, false, Live) acc
  ) StringMap.empty fn.params in
  let role_str = Option.value fn.role ~default:"Main" in
  let local_env = { env with vars = initial_vars; ret_typ = fn.ret_typ; current_role = role_str } in
  (match fn.body with
   | Some b -> let _ = check_block local_env b in ()
   | None -> if not fn.is_extern then raise (TypeError ("Function " ^ fn.name ^ " must have a body")));
  { env with funcs = StringMap.add fn.name fn env.funcs }

let rec eval_const (env_iota: Int64.t option) (e: Ast.expr) : Int64.t =
  match e with
  | ELit (LInt (v, _)) -> v
  | EVar "iota" -> 
      (match env_iota with
      | Some v -> v
      | None -> raise (TypeError "iota is only available inside enum declarations"))
  | EBinOp (e1, op, e2) ->
      let v1 = eval_const env_iota e1 in
      let v2 = eval_const env_iota e2 in
      (match op with
      | Add -> Int64.add v1 v2
      | Sub -> Int64.sub v1 v2
      | Mul -> Int64.mul v1 v2
      | Div -> Int64.div v1 v2
      | Shl -> Int64.shift_left v1 (Int64.to_int v2)
      | Shr -> Int64.shift_right_logical v1 (Int64.to_int v2)
      | BitAnd -> Int64.logand v1 v2
      | BitOr -> Int64.logor v1 v2
      | _ -> raise (TypeError "Operator not supported in const evaluation"))
  | ECast (e, _) -> eval_const env_iota e
  | _ -> raise (TypeError "Expression is not a compile-time constant")

let check_item env item =
  match item with
  | IFn f -> check_fn_decl env f
  | IEnum e ->
      let iota_env = { env with vars = StringMap.add "iota" (TBase TU64, false, Live) env.vars } in
      let _, _ = check_expr iota_env e.iota_expr (Some (TBase TU64)) in
      let current_iota = ref 0L in
      List.iter (fun (m: Ast.enum_member) ->
        let computed = match m.override with
        | Some (IotaOverride, exp_val) ->
            let _, _ = check_expr iota_env exp_val (Some (TBase TU64)) in
            current_iota := eval_const (Some !current_iota) exp_val;
            eval_const (Some !current_iota) e.iota_expr
        | Some (ValueOverride, exp_val) ->
            let _, _ = check_expr iota_env exp_val (Some (TBase e.base_typ)) in
            eval_const (Some !current_iota) exp_val
        | None ->
            eval_const (Some !current_iota) e.iota_expr
        in
        m.computed_val := Some computed;
        current_iota := Int64.add !current_iota 1L
      ) e.members;
      { env with enums = StringMap.add e.name e env.enums }
  | IStruct s ->
      { env with structs = StringMap.add s.name s env.structs }
  | IGlobal { name; typ = expected_t; init } ->
      let t_init, _ = check_expr env init None in
      if not (types_compatible expected_t t_init) then raise (TypeError ("Type mismatch in global " ^ name));
      { env with globals = StringMap.add name expected_t env.globals }

let check_program prog =
  let env_with_imports = List.fold_left (fun e (imp : import_decl) ->
    let prefix = match imp.alias with
      | Some a -> a
      | None -> List.hd (List.rev imp.path)
    in
    { e with imports = StringMap.add prefix imp.path e.imports }
  ) empty_env prog.Ast.imports in
  let env = List.fold_left check_item env_with_imports prog.items in
  env
