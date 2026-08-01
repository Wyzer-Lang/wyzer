open Ast

module StringMap = Map.Make(String)
module StringSet = Set.Make(String)

type var_state = Live | Consumed

type env = {
  funcs: fn_decl StringMap.t;
  vars: (typ * bool * var_state) StringMap.t;
  globals: typ StringMap.t;
  enums: enum_decl StringMap.t;
  structs: struct_decl StringMap.t;
  generic_items: (string list * item) StringMap.t;
  imports: string list StringMap.t;
  ret_typ: typ option;
  current_role: string;
  active_targs: typ list option;
  roles: unit StringMap.t;
  trace: (string * typ) list;
  traits: trait_decl StringMap.t;
  impls: impl_decl list;
  modules: env StringMap.t;
  project_root: string;
}

let empty_env = {
  funcs = StringMap.empty;
  vars = StringMap.empty;
  globals = StringMap.empty;
  enums = StringMap.empty;
  structs = StringMap.empty;
  generic_items = StringMap.empty;
  imports = StringMap.empty;
  ret_typ = None;
  current_role = "Global";
  active_targs = None;
  roles = StringMap.add "Compiler" () (StringMap.add "Main" () (StringMap.add "Global" () StringMap.empty));
  trace = [];
  traits = StringMap.empty;
  impls = [];
  modules = StringMap.empty;
  project_root = Sys.getcwd ();
}

exception TypeError of string

let rec add_role_if_missing t r =
  match t with
  | TRole _ -> t
  | TResult (t1, t2) -> TRole (TResult (add_role_if_missing t1 r, add_role_if_missing t2 r), r)
  | TArray inner -> TRole (TArray inner, r)
  | _ -> TRole (t, r)

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

let rec substitute_typ subst t =
  match t with
  | TBase (TCustom id) ->
      (match StringMap.find_opt id subst with
      | Some t' -> t'
      | None -> t)
  | TBase (TGenericApp (targs, inner)) -> 
      let new_inner_t = substitute_typ subst (TBase inner) in
      let new_inner = match new_inner_t with TBase b -> b | _ -> inner in
      TBase (TGenericApp (List.map (substitute_typ subst) targs, new_inner))
  | TBase _ -> t
  | TResult (t1, t2) -> TResult (substitute_typ subst t1, substitute_typ subst t2)
  | TRole (inner, r) -> TRole (substitute_typ subst inner, r)
  | TArray inner -> TArray (substitute_typ subst inner)

let rec types_compatible expected actual =
  if expected = actual then true
  else match expected, actual with
  | TResult (e1, e2), TResult (a1, a2) ->
      let c1 = (a1 = TBase (TCustom "_") || types_compatible e1 a1) in
      let c2 = (a2 = TBase (TCustom "_") || types_compatible e2 a2) in
      c1 && c2
  | TRole (t_exp, r_exp), TRole (t_act, r_act) ->
      if r_exp = r_act || r_act = "Poly" || r_exp = "Poly" then types_compatible t_exp t_act else false
  | TRole (t_exp, _), t_act ->
      types_compatible t_exp t_act
  | t_exp, TRole (t_act, _) ->
      types_compatible t_exp t_act
  | TBase (TGenericApp (targs1, inner1)), TBase (TGenericApp (targs2, inner2)) ->
      inner1 = inner2 && List.length targs1 = List.length targs2 && List.for_all2 types_compatible targs1 targs2
  | _, _ -> false

let is_integer_type = function
  | TU8 | TU16 | TU32 | TU64 | TI8 | TI16 | TI32 | TI64 -> true
  | _ -> false

let parse_format_string (s: string) : string * (Ast.expr * string) list =
  let len = String.length s in
  let rec parse_lit i acc_lit =
    if i >= len then (Buffer.contents acc_lit, i)
    else if s.[i] = '{' then (Buffer.contents acc_lit, i + 1)
    else (Buffer.add_char acc_lit s.[i]; parse_lit (i + 1) acc_lit)
  in
  let rec parse_expr i acc_expr =
    if i >= len then raise (TypeError "Unterminated { in format string")
    else if s.[i] = '}' then (Buffer.contents acc_expr, i + 1)
    else (Buffer.add_char acc_expr s.[i]; parse_expr (i + 1) acc_expr)
  in
  let rec parse_all i =
    if i >= len then ("", [])
    else
      let lit_buf = Buffer.create 16 in
      let (lit, next_i) = parse_lit i lit_buf in
      if next_i >= len then (lit, [])
      else
        let expr_buf = Buffer.create 16 in
        let (expr_str, next_i2) = parse_expr next_i expr_buf in
        let e = Parser.standalone_expr Lexer.read (Lexing.from_string expr_str) in
        let (next_lit, rest) = parse_all next_i2 in
        (lit, (e, next_lit) :: rest)
  in
  parse_all 0

module ExprId = struct
  type t = Ast.expr
  let equal (a: Ast.expr) (b: Ast.expr) = a == b
  let hash (a: Ast.expr) = Hashtbl.hash a
end
module ExprMap = Hashtbl.Make(ExprId)
let typed_ast_map : Ast.typ ExprMap.t = ExprMap.create 1024

let check_match_exhaustiveness env typ arms =
  let base_t = match typ with TRole (t, _) -> t | _ -> typ in
  match base_t with
  | TBase (TCustom enum_name) ->
      (match StringMap.find_opt enum_name env.enums with
      | Some enum_decl ->
          let initial_set =
            List.fold_left (fun acc (m : Ast.enum_member) -> StringSet.add m.name acc) StringSet.empty enum_decl.members
          in
          let remaining = List.fold_left (fun set (pat, _) ->
            let process_pat set p =
              match p with
              | PWildcard | PIdent _ -> StringSet.empty
              | PVariant (v, _) -> StringSet.remove v set
              | PLit _ -> set
            in
            process_pat set pat
          ) initial_set arms in
          if not (StringSet.is_empty remaining) then
            raise (TypeError ("Non-exhaustive pattern matching for enum " ^ enum_name ^ ": missing variant(s) " ^ String.concat ", " (StringSet.elements remaining)))
      | None -> ())
  | TResult _ ->
      let initial_set = StringSet.of_list ["Ok"; "Err"] in
      let remaining = List.fold_left (fun set (pat, _) ->
        let process_pat set p =
          match p with
          | PWildcard | PIdent _ -> StringSet.empty
          | PVariant (v, _) -> StringSet.remove v set
          | PLit _ -> set
        in
        process_pat set pat
      ) initial_set arms in
      if not (StringSet.is_empty remaining) then
        raise (TypeError ("Non-exhaustive pattern matching for Result: missing variant(s) " ^ String.concat ", " (StringSet.elements remaining)))
  | TBase TBool ->
      let initial_set = StringSet.of_list ["true"; "false"] in
      let remaining = List.fold_left (fun set (pat, _) ->
        let process_pat set p =
          match p with
          | PWildcard | PIdent _ -> StringSet.empty
          | PLit (LBool b) -> StringSet.remove (string_of_bool b) set
          | _ -> set
        in
        process_pat set pat
      ) initial_set arms in
      if not (StringSet.is_empty remaining) then
        raise (TypeError ("Non-exhaustive pattern matching for bool: missing value(s) " ^ String.concat ", " (StringSet.elements remaining)))
  | _ ->
      let has_catch_all = List.exists (fun (pat, _) ->
        match pat with
        | PWildcard | PIdent _ -> true
        | _ -> false
      ) arms in
      if not has_catch_all then
        raise (TypeError ("Non-exhaustive pattern matching on non-enum type: requires a wildcard pattern '_' or identifier pattern"))

let rec check_expr_impl env e expected_typ_opt =
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
          let var_role = match t with | TRole (_, r) -> r | _ -> "Main" in
          if var_role <> "Global" && var_role <> env.current_role && env.current_role <> "Poly" then
            raise (TypeError (Printf.sprintf "Cannot access variable %s belonging to role %s from role %s" name var_role env.current_role));
          let new_vars = match t with
            | TRole _ -> StringMap.add name (t, is_mut, Consumed) env.vars
            | _ -> env.vars
          in
          t, { env with vars = new_vars }
      | None ->
          (match StringMap.find_opt name env.globals with
          | Some t ->
              let var_role = match t with | TRole (_, r) -> r | _ -> "Global" in
              if var_role <> "Global" && var_role <> env.current_role then
                raise (TypeError (Printf.sprintf "Cannot access global %s belonging to role %s from role %s" name var_role env.current_role));
              t, env
          | None -> raise (TypeError ("Undefined variable: " ^ name))))
  | EPathVar path ->
      let resolved_path =
        match StringMap.find_opt (List.hd path) env.imports with
        | Some mod_path -> mod_path @ List.tl path
        | None -> path
      in
      (match resolved_path with
      | [enum_name; variant_name] ->
          (match StringMap.find_opt enum_name env.enums with
          | Some enum_decl ->
              if List.exists (fun (m : Ast.enum_member) -> m.name = variant_name) enum_decl.members then
                TBase (TCustom enum_name), env
              else
                raise (TypeError ("Enum " ^ enum_name ^ " does not have variant " ^ variant_name))
          | None ->
              if resolved_path = ["std"; "io"; "stdin"] || resolved_path = ["std"; "io"; "stdout"] || resolved_path = ["std"; "io"; "stderr"] then
                TBase (TCustom "Stream"), env
              else
                raise (TypeError ("Unknown path variable: " ^ String.concat "::" path)))
      | _ ->
          if resolved_path = ["std"; "io"; "stdin"] || resolved_path = ["std"; "io"; "stdout"] || resolved_path = ["std"; "io"; "stderr"] then
            TBase (TCustom "Stream"), env
          else
            raise (TypeError ("Unknown path variable: " ^ String.concat "::" path)))
  | ECall (name, args) ->
      let targs_opt = env.active_targs in
      let env_clean = { env with active_targs = None } in
      (match targs_opt with
      | Some targs ->
          (match StringMap.find_opt name env_clean.generic_items with
          | Some (params, IFn f) ->
              if List.length args <> List.length f.params then raise (TypeError ("Arity mismatch for " ^ name));
              if List.length targs <> List.length params then raise (TypeError ("Generic arity mismatch for " ^ name));
              let subst = List.fold_left2 (fun acc p t -> StringMap.add p t acc) StringMap.empty params targs in
              let env_after_args = List.fold_left2 (fun current_env (p: Ast.param) arg_expr ->
                let p_typ = substitute_typ subst p.typ in
                let t_arg, next_env = check_expr current_env arg_expr (Some p_typ) in
                if not (types_compatible p_typ t_arg) then
                  raise (TypeError ("Type mismatch in function argument " ^ p.name));
                next_env
              ) env_clean f.params args in
              let base_ret = match f.ret_typ with
                | Some rt -> substitute_typ subst rt
                | None -> TBase TUnit
              in
              let f_role = Option.value f.role ~default:env_clean.current_role in
              if f_role <> env_clean.current_role && f_role <> "global" then (
                let ret_with_role = TRole (base_ret, f_role) in
                ret_with_role, env_after_args
              ) else
                let final_ret = if f_role = env_clean.current_role then base_ret else TRole (base_ret, f_role) in
                final_ret, env_after_args
          | _ -> raise (TypeError ("Undefined generic function: " ^ name)))
      | None ->
          (match StringMap.find_opt name env_clean.funcs with
          | Some f ->
              if List.length args <> List.length f.params then raise (TypeError ("Arity mismatch for " ^ name));
              let env_after_args = List.fold_left2 (fun current_env (p: Ast.param) arg_expr ->
                let t_arg, next_env = check_expr current_env arg_expr (Some p.typ) in
                if not (types_compatible p.typ t_arg) then
                  raise (TypeError ("Type mismatch in function argument " ^ p.name));
                next_env
              ) env_clean f.params args in
              let base_ret = match f.ret_typ with
                | Some rt -> rt
                | None -> TBase TUnit
              in
              let f_role = Option.value f.role ~default:env_clean.current_role in
              if f_role <> env_clean.current_role && f_role <> "global" then (
                let ret_with_role = TRole (base_ret, f_role) in
                ret_with_role, env_after_args
              ) else
                let final_ret = if f_role = env_clean.current_role then base_ret else TRole (base_ret, f_role) in
                final_ret, env_after_args
          | None -> raise (TypeError ("Undefined function: " ^ name))))
  | EMethodCall (obj, method_name, args, resolved_name_ref) ->
      let t_obj, _ = check_expr env obj None in
      let rec find_method impls =
        match impls with
        | [] -> raise (TypeError ("No method " ^ method_name ^ " found for type " ^ Ast.show_typ t_obj))
        | impl :: rest ->
            if types_compatible impl.for_typ t_obj then
              match List.find_opt (fun (m: Ast.fn_decl) -> m.name = method_name) impl.methods with
              | Some m -> (impl, m)
              | None -> find_method rest
            else find_method rest
      in
      let (impl, _) = find_method env.impls in
      let mangled_name = impl.trait_name ^ "_" ^ (Ast.show_typ impl.for_typ |> String.map (function ' ' | '(' | ')' -> '_' | c -> c)) ^ "_" ^ method_name in
      resolved_name_ref := Some mangled_name;
      check_expr env (ECall (mangled_name, obj :: args)) expected_typ_opt
  | EPathCall (path, args) ->
      let prefix = List.hd path in
      if StringMap.mem prefix env.enums then (
        if List.length path <> 2 then raise (TypeError "Invalid enum variant path");
        let enum_name = prefix in
        let variant_name = List.nth path 1 in
        let enum_decl = StringMap.find enum_name env.enums in
        let variant_opt = List.find_opt (fun (m: Ast.enum_member) -> m.name = variant_name) enum_decl.members in
        (match variant_opt with
        | None -> raise (TypeError ("Enum variant not found: " ^ variant_name))
        | Some v ->
            if List.length args <> List.length v.payload then
              raise (TypeError ("Enum variant " ^ enum_name ^ "::" ^ variant_name ^ " expects different number of arguments"));
            let env_after_args = List.fold_left2 (fun env_acc arg payload_t ->
              let arg_t, env_next = check_expr env_acc arg (Some payload_t) in
              if not (types_compatible payload_t arg_t) then
                raise (TypeError ("Type mismatch in enum payload for " ^ enum_name ^ "::" ^ variant_name));
              env_next
            ) env args v.payload in
            TBase (TCustom enum_name), env_after_args)
      ) else
      let resolved_path =
        match StringMap.find_opt prefix env.imports with
        | Some actual_module -> actual_module @ (List.tl path)
        | None -> path
      in
      let rec resolve_module current_env p =
        match p with
        | [] -> current_env
        | "bundle" :: rest -> resolve_module current_env rest
        | mod_name :: rest ->
            match StringMap.find_opt mod_name current_env.modules with
            | Some sub_env -> resolve_module sub_env rest
            | None -> raise (TypeError ("Module not found: " ^ mod_name))
      in
      if List.length resolved_path > 0 && List.hd resolved_path = "std" then (
        if resolved_path = ["std"; "io"; "println"] || resolved_path = ["std"; "io"; "print"] || resolved_path = ["std"; "io"; "eprintln"] || resolved_path = ["std"; "io"; "eprint"] then (
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
          raise (TypeError ("Undefined std path call: " ^ String.concat "::" resolved_path))
      ) else (
        let module_path = List.rev (List.tl (List.rev resolved_path)) in
        let func_name = List.hd (List.rev resolved_path) in
        let target_env = resolve_module env module_path in
        match StringMap.find_opt func_name target_env.funcs with
        | Some fn ->
            let temp_name = String.concat "::" resolved_path in
            let env_with_fn = { env with funcs = StringMap.add temp_name fn env.funcs } in
            check_expr env_with_fn (ECall (temp_name, args)) expected_typ_opt
        | None -> raise (TypeError ("Function not found in module: " ^ func_name))
      )
  | EUnOp (Not, e) ->
      let t, env1 = check_expr env e (Some (TBase TBool)) in
      if t = TBase TBool then TBase TBool, env1
      else raise (TypeError "Logical NOT requires a boolean type")
  | EUnOp (Neg, e) ->
      let t, env1 = check_expr env e expected_typ_opt in
      if is_int_type t then t, env1
      else raise (TypeError "Negation requires an integer type")
  | EBinOp (e1, op, e2) ->
      let expected_e1 = match op with
        | Add | Sub | Mul | Div | Shl | Shr | BitAnd | BitOr -> expected_typ_opt
        | Eq | Neq | Lt | Gt | Lte | Gte | And | Or -> None
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
          else raise (TypeError "Comparison operators require integer types")
      | And | Or ->
          if t1 = TBase TBool && t2 = TBase TBool then TBase TBool, env2
          else raise (TypeError "Logical operators require boolean types"))
  | EFormatStr (s_ref, parsed_ref) ->
      if !parsed_ref = [] then (
        let (first_lit, rest) = parse_format_string !s_ref in
        s_ref := first_lit;
        parsed_ref := rest;
        (* Check all expressions in the format string *)
        let env_acc = ref env in
        List.iter (fun (e_inner, _) ->
          let (_, env_new) = check_expr !env_acc e_inner None in
          env_acc := env_new
        ) rest;
        (* For now, we type format strings as TStr *)
        TBase TStr, !env_acc
      ) else
        TBase TStr, env
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
      let len_old = List.length env1.trace in
      let rec drop n lst = if n <= 0 then lst else match lst with [] -> [] | _::t -> drop (n - 1) t in
      let trace_thn = drop len_old env_thn.trace in
      (match els with
      | Some e_block ->
          let env_els, t_els = check_block env1 e_block in
          let trace_els = drop len_old env_els.trace in
          if trace_thn <> trace_els then
            raise (TypeError "Asymmetric choreography: 'if' and 'else' branches must have identical transfer footprints");
          if not (types_compatible (Option.value t_thn ~default:(TBase TUnit)) (Option.value t_els ~default:(TBase TUnit))) then 
            raise (TypeError "if and else branches must have same return type");
          Option.value t_thn ~default:(TBase TUnit), { env_els with vars = env_thn.vars }
      | None ->
          if trace_thn <> [] then
            raise (TypeError "Asymmetric choreography: 'if' without 'else' cannot contain 'transfer' operations");
          if t_thn <> None then raise (TypeError "if without else cannot return a value");
          Option.value t_thn ~default:(TBase TUnit), env_thn)
  | EStruct (name, fields, _) ->
      let targs_opt = env.active_targs in
      let env_clean = { env with active_targs = None } in
      (match targs_opt with
      | Some targs ->
          (match StringMap.find_opt name env_clean.generic_items with
          | Some (params, IStruct s_decl) ->
              if List.length targs <> List.length params then raise (TypeError ("Generic arity mismatch for struct " ^ name));
              let subst = List.fold_left2 (fun acc p t -> StringMap.add p t acc) StringMap.empty params targs in
              if List.length fields <> List.length s_decl.fields then
                raise (TypeError ("Arity mismatch for struct " ^ name));
              let env_final = List.fold_left (fun current_env (f_name, f_expr) ->
                match List.find_opt (fun (f : Ast.field) -> f.name = f_name) s_decl.fields with
                | Some f_decl ->
                    let f_typ = substitute_typ subst f_decl.typ in
                    let t_expr, env_next = check_expr current_env f_expr (Some f_typ) in
                    if not (types_compatible f_typ t_expr) then (
                      print_endline ("Expected: " ^ show_typ f_typ ^ " but got: " ^ show_typ t_expr);
                      raise (TypeError ("Type mismatch in field " ^ f_name))
                    );
                    env_next
                | None -> raise (TypeError ("Struct " ^ name ^ " missing field " ^ f_name))
              ) env_clean fields in
              TBase (TGenericApp (targs, TCustom name)), env_final
          | _ -> raise (TypeError ("Undeclared generic struct: " ^ name)))
      | None ->
          (match StringMap.find_opt name env_clean.structs with
          | Some s_decl ->
              if List.length fields <> List.length s_decl.fields then
                raise (TypeError ("Arity mismatch for struct " ^ name));
              let env_final = List.fold_left (fun current_env (f_name, f_expr) ->
                match List.find_opt (fun (f : Ast.field) -> f.name = f_name) s_decl.fields with
                | Some f_decl ->
                    let t_expr, env_next = check_expr current_env f_expr (Some f_decl.typ) in
                    if not (types_compatible f_decl.typ t_expr) then
                      raise (TypeError ("Type mismatch in field " ^ f_name));
                    env_next
                | None -> raise (TypeError ("Struct " ^ name ^ " missing field " ^ f_name))
              ) env_clean fields in
              TBase (TCustom name), env_final
          | None -> raise (TypeError ("Undeclared struct: " ^ name))))
  | EField (e, field_name) ->
      let t_e, env1 = check_expr env e None in
      let base = match t_e with TRole (inner, _) -> inner | _ -> t_e in
      (match base with
      | TBase (TGenericApp (targs, TCustom name)) ->
          (match StringMap.find_opt name env1.generic_items with
          | Some (params, IStruct s_decl) ->
              let subst = List.fold_left2 (fun acc p t -> StringMap.add p t acc) StringMap.empty params targs in
              (match List.find_opt (fun (f : Ast.field) -> f.name = field_name) s_decl.fields with
              | Some f_decl -> substitute_typ subst f_decl.typ, env1
              | None -> raise (TypeError ("Unknown field " ^ field_name ^ " on struct " ^ name)))
          | _ -> raise (TypeError ("Unknown generic struct: " ^ name)))
      | TBase (TCustom name) ->
          (match StringMap.find_opt name env1.structs with
          | Some s_decl ->
              (match List.find_opt (fun (f : Ast.field) -> f.name = field_name) s_decl.fields with
              | Some f_decl -> f_decl.typ, env1
              | None -> raise (TypeError ("Unknown field " ^ field_name ^ " on struct " ^ name)))
          | None -> raise (TypeError ("Unknown struct: " ^ name)))
      | _ -> raise (TypeError "Field access on non-struct type"))
  | EMatch (e, arms) ->
      let t_e, env1 = check_expr env e None in
      check_match_exhaustiveness env1 t_e arms;
      let arm_results = List.map (fun (pat, e_arm) ->
        let rec bind_pat env pat typ =
          match pat with
          | PWildcard -> env
          | PLit l ->
              let lit_t = match l with
              | LInt (_, t) -> TBase (Option.value t ~default:TU32)
              | LBool _ -> TBase TBool
              | LStr _ -> TBase TStr
              in
              if not (types_compatible typ lit_t) then raise (TypeError "Pattern literal type mismatch");
              env
          | PIdent id -> { env with vars = StringMap.add id (add_role_if_missing typ env.current_role, false, Live) env.vars }
          | PVariant (variant_name, Some pat_list) ->
              let base_t = match typ with TRole (t, _) -> t | _ -> typ in
              (match base_t with
              | TBase (TCustom enum_name) ->
                  (match StringMap.find_opt enum_name env.enums with
                  | Some enum_decl ->
                      (match List.find_opt (fun (m: Ast.enum_member) -> m.name = variant_name) enum_decl.members with
                      | Some variant ->
                          if List.length pat_list <> List.length variant.payload then
                            raise (TypeError ("Pattern payload length mismatch for variant " ^ variant_name));
                          List.fold_left2 bind_pat env pat_list variant.payload
                      | None -> raise (TypeError ("Variant " ^ variant_name ^ " not found in enum " ^ enum_name)))
                  | None -> env)
              | TResult (t1, t2) ->
                  if variant_name = "Ok" && List.length pat_list = 1 then bind_pat env (List.hd pat_list) t1
                  else if variant_name = "Err" && List.length pat_list = 1 then bind_pat env (List.hd pat_list) t2
                  else raise (TypeError "Result pattern length mismatch")
              | _ -> raise (TypeError ("Pattern matching with variants is only supported for Enums and Results. Got: " ^ Ast.show_typ typ)))
          | PVariant (variant_name, None) ->
              let base_t = match typ with TRole (t, _) -> t | _ -> typ in
              (match base_t with
              | TBase (TCustom enum_name) ->
                  (match StringMap.find_opt enum_name env.enums with
                  | Some enum_decl ->
                      (match List.find_opt (fun (m: Ast.enum_member) -> m.name = variant_name) enum_decl.members with
                      | Some variant ->
                          if variant.payload <> [] then
                            raise (TypeError ("Variant " ^ variant_name ^ " expects a payload"));
                          env
                      | None -> raise (TypeError ("Variant " ^ variant_name ^ " not found in enum " ^ enum_name)))
                  | None -> env)
              | TResult _ ->
                  raise (TypeError "Result variants (Ok/Err) expect a payload")
              | _ -> raise (TypeError ("Pattern matching with variants is only supported for Enums and Results. Got: " ^ Ast.show_typ typ)))
        in
        let env_arm = bind_pat env1 pat t_e in
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
  | EGenericApp (targs, e) ->
      let env_with_targs = { env with active_targs = Some targs } in
      let t_inner, env_next = check_expr env_with_targs e expected_typ_opt in
      t_inner, { env_next with active_targs = env.active_targs }
  | EArray elems ->
      let expected_elem_t = match expected_typ_opt with
        | Some (TArray t) -> Some t
        | Some (TRole (TArray t, _)) -> Some t
        | _ -> None
      in
      if elems = [] then (
        match expected_elem_t with
        | Some t -> TArray t, env
        | None -> raise (TypeError "Empty array requires type annotation (e.g. let arr: [u32] = [])")
      ) else (
        let t_first, env_first = check_expr env (List.hd elems) expected_elem_t in
        let env_final = List.fold_left (fun env_acc elem ->
          let t_elem, env_next = check_expr env_acc elem (Some t_first) in
          if not (types_compatible t_first t_elem) then raise (TypeError "Array elements must have the same type");
          env_next
        ) env_first (List.tl elems) in
        TArray t_first, env_final
      )
  | EIndex (arr, i) ->
      let t_arr, env2 = check_expr env arr None in
      let t_i, env3 = check_expr env2 i None in
      if not (is_int_type t_i) then raise (TypeError "Array index must be an integer");
      let base_arr_t = match t_arr with | TRole (inner, _) -> inner | _ -> t_arr in
      (match base_arr_t with
      | TArray t_elem -> t_elem, env3
      | _ -> raise (TypeError "Cannot index non-array type"))
  | ETransfer (e, role) ->
      if not (StringMap.mem role env.roles) then raise (TypeError ("Undeclared role in transfer: " ^ role));
      let t_e, env1 = check_expr env e None in
      let base_t = match t_e with
        | TRole (inner, _) -> inner
        | _ -> t_e
      in
      let env_with_trace = { env1 with trace = env1.trace @ [(role, base_t)] } in
      if role = "Compiler" then
        (base_t, env_with_trace)
      else
        (TRole (base_t, role), env_with_trace)
  | EDup (_, e) -> check_expr env e None
  | ETyped (inner, t) ->
      let _, env' = check_expr env inner (Some t) in
      (t, env')
  | ENetSend (_, inner) ->
      let _, env' = check_expr env inner None in
      (TBase TUnit, env')
  | ENetRecv _ ->
      (* EPP handles types dynamically, just return Unit here to satisfy exhaustiveness *)
      (TBase TUnit, env)
  | ESizeOf _t ->
      (TBase TU32, env)
  | ETypeOf inner ->
      let _, env' = check_expr env inner None in
      (TBase TStr, env')
  | EComptime inner ->
      check_expr env inner expected_typ_opt

and check_expr env e expected_typ_opt =
  let (t, env') = check_expr_impl env e expected_typ_opt in
  ExprMap.replace typed_ast_map e t;
  (t, env')

and check_stmt env stmt =
  match stmt with
  | SDecl { kind; name; typ; init } ->
      let t_init, env1 = check_expr env init typ in
      let typ_with_role = match typ with
        | Some t -> Some (add_role_if_missing t env1.current_role)
        | None -> None
      in
      (match typ_with_role with
      | Some t -> if not (types_compatible t t_init) then raise (TypeError ("Type mismatch in declaration for " ^ name))
      | None -> ());
      let t_final = Option.value typ_with_role ~default:t_init in
      let t_final = add_role_if_missing t_final env1.current_role in
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
                  let global_role = match t_var with | TRole (_, r) -> r | _ -> "Global" in
                  if global_role <> "Global" && global_role <> env1.current_role then raise (TypeError ("Cannot access global " ^ name ^ " from role " ^ env1.current_role));
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
      let env1 = match e_opt, env.ret_typ with
      | Some e, Some expected_t ->
          let t_e, env_next = check_expr env e (Some expected_t) in
          let expected_t = add_role_if_missing expected_t env.current_role in
          if not (types_compatible expected_t t_e) then raise (TypeError "Return type mismatch");
          env_next
      | None, None -> env
      | Some _, None -> raise (TypeError "Cannot return a value from a unit function")
      | None, Some _ -> raise (TypeError "Function must return a value")
      in
      StringMap.iter (fun name (t, _, state) ->
        match t with
        | TRole _ when state = Live -> 
            raise (TypeError ("Cannot return early with unconsumed linear resource: " ^ name))
        | _ -> ()
      ) env1.vars;
      env1
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
  let role_str = Option.value fn.role ~default:"Poly" in
  let initial_vars = List.fold_left (fun acc (p: Ast.param) ->
    let p_typ_with_role = add_role_if_missing p.typ role_str in
    StringMap.add p.name (p_typ_with_role, false, Live) acc
  ) StringMap.empty fn.params in
  let local_env = { env with vars = initial_vars; ret_typ = fn.ret_typ; current_role = role_str } in
  (match fn.body with
   | Some b -> 
       let env_final, _ = check_block local_env b in
       StringMap.iter (fun name (t, _, state) ->
         match t with
         | TRole _ when state = Live -> 
             raise (TypeError ("Function " ^ fn.name ^ " ends with unconsumed linear resource: " ^ name))
         | _ -> ()
       ) env_final.vars
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

let rec check_item env item =
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
  | IGlobal { is_pub = _; name; typ = expected_t; init } ->
      let t_init, _ = check_expr env init None in
      if not (types_compatible expected_t t_init) then raise (TypeError ("Type mismatch in global " ^ name));
      { env with globals = StringMap.add name expected_t env.globals }
  | IGeneric (params, i) ->
      let name = match i with
      | IFn f -> f.name
      | IStruct s -> s.name
      | IEnum e -> e.name
      | IGlobal g -> g.name
      | _ -> raise (TypeError "Generics only supported on functions, structs, enums, globals")
      in
      { env with generic_items = StringMap.add name (params, i) env.generic_items }
  | IRole r ->
      List.iter (fun (k, e) ->
        let _, _ = check_expr env e None in
        match e with
        | ELit _ -> ()
        | _ -> raise (TypeError ("Role property " ^ k ^ " must be a constant literal"))
      ) r.properties;
      { env with roles = StringMap.add r.name () env.roles }
  | ITrait t ->
      { env with traits = StringMap.add t.name t env.traits }
  | IImpl i ->
      let _ = match StringMap.find_opt i.trait_name env.traits with
      | Some _ -> ()
      | None -> raise (TypeError ("Undefined trait: " ^ i.trait_name))
      in
      let env_with_impl = { env with impls = i :: env.impls } in
      List.fold_left (fun e (m: fn_decl) ->
        let mangled_name = i.trait_name ^ "_" ^ (Ast.show_typ i.for_typ |> String.map (function ' ' | '(' | ')' -> '_' | c -> c)) ^ "_" ^ m.name in
        let mangled_m = { m with name = mangled_name } in
        check_fn_decl e mangled_m
      ) env_with_impl i.methods
  | IMod m ->
      let mod_path = Filename.concat env.project_root (m.name ^ ".wyz") in
      if not (Sys.file_exists mod_path) then
        raise (TypeError ("Module file not found: " ^ mod_path));
      let inx = open_in mod_path in
      let lexbuf = Lexing.from_channel inx in
      lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = mod_path };
      let prog = try Parser.program Lexer.read lexbuf with
        | _ -> close_in inx; raise (TypeError ("Failed to parse module " ^ m.name))
      in
      close_in inx;
      let mod_env = check_program_inner { empty_env with project_root = env.project_root } prog in
      { env with modules = StringMap.add m.name mod_env env.modules }

and check_program_inner env prog =
  let env_with_imports = List.fold_left (fun e (imp : import_decl) ->
    let prefix = match imp.alias with
      | Some a -> a
      | None -> List.hd (List.rev imp.path)
    in
    let e1 = { e with imports = StringMap.add prefix imp.path e.imports } in
    match imp.path with
    | "bundle" :: rest ->
        let mod_name = List.hd rest in
        if StringMap.mem mod_name e1.modules then e1 else (
          let mod_path = Filename.concat e1.project_root (mod_name ^ ".wyz") in
          if Sys.file_exists mod_path then
            let inx = open_in mod_path in
            let lexbuf = Lexing.from_channel inx in
            lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = mod_path };
            let parsed_prog = try Parser.program Lexer.read lexbuf with
              | _ -> close_in inx; raise (TypeError ("Failed to parse imported module " ^ mod_name))
            in
            close_in inx;
            let mod_env = check_program_inner { empty_env with project_root = e1.project_root } parsed_prog in
            { e1 with modules = StringMap.add mod_name mod_env e1.modules }
          else e1
        )
    | _ -> e1
  ) env prog.Ast.imports in
  List.fold_left check_item env_with_imports prog.items

let check_program project_root prog =
  check_program_inner { empty_env with project_root = project_root } prog
