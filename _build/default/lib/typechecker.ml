open Ast

module StringMap = Map.Make(String)

type env = {
  vars: (typ * bool) StringMap.t; (* Type and whether it is mutable *)
  funcs: fn_decl StringMap.t;
  enums: enum_decl StringMap.t;
  structs: struct_decl StringMap.t;
  imports: string list StringMap.t;
}

let empty_env = {
  vars = StringMap.empty;
  funcs = StringMap.empty;
  enums = StringMap.empty;
  structs = StringMap.empty;
  imports = StringMap.empty;
}

exception TypeError of string

let is_int_type = function
  | TBase TU8 | TBase TU16 | TBase TU32 | TBase TU64
  | TBase TI8 | TBase TI16 | TBase TI32 | TBase TI64 -> true
  | _ -> false

let is_bool_type = function
  | TBase TBool -> true
  | _ -> false

let rec types_compatible expected actual =
  if expected = actual then true
  else match expected, actual with
  | TResult (e1, e2), TResult (a1, a2) ->
      let c1 = (a1 = TBase (TCustom "_") || types_compatible e1 a1) in
      let c2 = (a2 = TBase (TCustom "_") || types_compatible e2 a2) in
      c1 && c2
  | _, _ -> false

let rec check_expr env e =
  match e with
  | ELit (LInt (_, t)) -> TBase t
  | ELit (LBool _) -> TBase TBool
  | ELit (LStr _) -> TBase TStr
  | EVar name ->
      (match StringMap.find_opt name env.vars with
      | Some (t, _) -> t
      | None -> raise (TypeError ("Undefined variable: " ^ name)))
  | ECall (name, args) ->
      (match StringMap.find_opt name env.funcs with
      | Some f ->
        if List.length args <> List.length f.params then raise (TypeError ("Arity mismatch for " ^ name));
        List.iter2 (fun (p : Ast.param) arg ->
            let t_arg = check_expr env arg in
            if not (types_compatible p.typ t_arg) then raise (TypeError ("Argument type mismatch in call to " ^ name))
          ) f.params args;
          f.ret_typ
      | None -> raise (TypeError ("Undefined function: " ^ name)))
  | EPathCall (path, args) ->
      let prefix = List.hd path in
      let resolved_path =
        match StringMap.find_opt prefix env.imports with
        | Some actual_module -> actual_module @ (List.tl path)
        | None -> path (* Assume it's an absolute path to a root library *)
      in
      (* For Milestone 0, just stub std::io::println *)
      if resolved_path = ["std"; "io"; "println"] || resolved_path = ["std"; "io"; "print"] then (
        if List.length args <> 1 then raise (TypeError ("print/println expects 1 argument"));
        let arg_t = check_expr env (List.hd args) in
        if not (is_bool_type arg_t || is_int_type arg_t || arg_t = TBase TStr) then
          raise (TypeError "print/println argument must be printable");
        TBase TU8 (* Returning a dummy type for unit *)
      ) else
        raise (TypeError ("Undefined path call: " ^ String.concat "::" resolved_path))
  | EBinOp (e1, op, e2) ->
      let t1 = check_expr env e1 in
      let t2 = check_expr env e2 in
      if t1 <> t2 then raise (TypeError "Binary operator operands must have same type");
      (match op with
      | Add | Sub | Mul | Div | Shl | Shr | BitAnd | BitOr ->
          if is_int_type t1 then t1
          else raise (TypeError "Arithmetic/Bitwise operators require integer types")
      | Eq | Neq ->
          TBase TBool
      | Lt | Gt | Lte | Gte ->
          if is_int_type t1 then TBase TBool
          else raise (TypeError "Comparison operators require integer types"))
  | EOk (e, _) ->
      let t = check_expr env e in
      TResult (t, TBase (TCustom "_"))
  | EErr (e, _) ->
      let t = check_expr env e in
      TResult (TBase (TCustom "_"), t)
  | EIf (cond, thn, els) ->
      let t_cond = check_expr env cond in
      if t_cond <> TBase TBool then raise (TypeError "if condition must be bool");
      let _, t_thn = check_block env thn in
      (match els with
      | Some e_block ->
          let _, t_els = check_block env e_block in
          if t_thn <> t_els then raise (TypeError "if and else branches must have same return type");
          Option.value t_thn ~default:(TBase TU8)
      | None ->
          if t_thn <> None then raise (TypeError "if without else cannot return a value");
          Option.value t_thn ~default:(TBase TUnit))
  | EStruct (name, fields, _) ->
      (match StringMap.find_opt name env.structs with
      | Some s_decl ->
          if List.length fields <> List.length s_decl.fields then
            raise (TypeError ("Struct " ^ name ^ " field count mismatch"));
          List.iter (fun (f_decl : Ast.field) ->
            match List.assoc_opt f_decl.name fields with
            | Some e ->
                let t_e = check_expr env e in
                if t_e <> f_decl.typ then raise (TypeError ("Struct " ^ name ^ " field " ^ f_decl.name ^ " type mismatch"))
            | None -> raise (TypeError ("Struct " ^ name ^ " missing field " ^ f_decl.name))
          ) s_decl.fields;
          TBase (TCustom name)
      | None -> raise (TypeError ("Undeclared struct: " ^ name)))
  | EField (e, field_name) ->
      let t_e = check_expr env e in
      (match t_e with
      | TBase (TCustom name) ->
          (match StringMap.find_opt name env.structs with
          | Some s_decl ->
              (match List.find_opt (fun (f : Ast.field) -> f.name = field_name) s_decl.fields with
              | Some f -> f.typ
              | None -> raise (TypeError ("Field " ^ field_name ^ " not found in struct " ^ name)))
          | None -> raise (TypeError ("Unknown struct type for field access")))
      | _ -> raise (TypeError "Field access on non-struct type"))
  | EMatch (e, arms) ->
      let t_e = check_expr env e in
      let arm_types = List.map (fun (pat, e_arm) ->
        let env_arm = match pat with
          | PIdent id -> { env with vars = StringMap.add id (t_e, false) env.vars }
          | PVariant ("Ok", Some [PIdent id]) ->
              (match t_e with
              | TResult (t1, _) -> { env with vars = StringMap.add id (t1, false) env.vars }
              | _ -> env)
          | PVariant ("Err", Some [PIdent id]) ->
              (match t_e with
              | TResult (_, t2) -> { env with vars = StringMap.add id (t2, false) env.vars }
              | _ -> env)
          | _ -> env
        in
        check_expr env_arm e_arm
      ) arms in
      let first_t = List.hd arm_types in
      List.iter (fun t -> if t <> first_t then raise (TypeError "Match arms have different types")) arm_types;
      first_t
  | EDup (_, e) -> check_expr env e

and check_stmt env stmt =
  match stmt with
  | SDecl { kind; name; typ; init } ->
      let t_init = check_expr env init in
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
      { env with vars = StringMap.add name (t_final, is_mut) env.vars }
  | SAssign (name, e) ->
      let t_e = check_expr env e in
      (match StringMap.find_opt name env.vars with
      | Some (t_var, is_mut) ->
          if not is_mut then raise (TypeError ("Cannot assign to immutable variable: " ^ name));
          if not (types_compatible t_var t_e) then raise (TypeError "Assignment type mismatch");
          env
      | None -> raise (TypeError ("Undeclared variable: " ^ name)))
  | SExpr e ->
      ignore (check_expr env e);
      env
  | SWhile (cond, b) ->
      let t_cond = check_expr env cond in
      if t_cond <> TBase TBool then raise (TypeError "while condition must be bool");
      let _, _ = check_block env b in
      env
  | SFor (id, e, b) ->
      let _t_e = check_expr env e in
      let env_for = { env with vars = StringMap.add id (TBase TU8, false) env.vars } in
      let _, _ = check_block env_for b in
      env
  | SDrop x ->
      (* Just verify x exists in environment for sanity *)
      if not (StringMap.mem x env.vars) then raise (TypeError ("Cannot drop undefined variable: " ^ x));
      env

and check_block env block =
  let env_final = List.fold_left check_stmt env block.stmts in
  let ret_typ = Option.map (check_expr env_final) block.ret_expr in
  env_final, ret_typ

let check_item env item =
  match item with
  | IFn f ->
      (* Add params to env *)
      let env_with_params = List.fold_left (fun e (p: Ast.param) ->
        { e with vars = StringMap.add p.name (p.typ, false) e.vars }
      ) env f.params in
      let _, ret_typ = check_block env_with_params f.body in
      let _ = Option.value ret_typ ~default:(TBase TU8) in
      (* For now we use TU8 as a dummy unit type if none provided, but we should compare correctly *)
      (* if actual_ret_typ <> f.ret_typ then raise (TypeError ("Function " ^ f.name ^ " return type mismatch")); *)
      { env with funcs = StringMap.add f.name f env.funcs }
  | IEnum e ->
      { env with enums = StringMap.add e.name e env.enums }
  | IStruct s ->
      { env with structs = StringMap.add s.name s env.structs }

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
