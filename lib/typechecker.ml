open Ast

module StringMap = Map.Make(String)
module StringSet = Set.Make(String)

type var_state = Live | Consumed

type env = {
  funcs: fn_decl StringMap.t;
  vars: (typ * bool * var_state * Ast.span * bool ref) StringMap.t;
  globals: typ StringMap.t;
  enums: enum_decl StringMap.t;
  structs: struct_decl StringMap.t;
  generic_items: (string list * item) StringMap.t;
  imports: (string list * Ast.span * bool ref) StringMap.t;
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
  match t.item with
  | TRole _ -> t
  | TResult (t1, t2) -> { item = TRole ({ item = TResult (add_role_if_missing t1 r, add_role_if_missing t2 r); span = dummy_span }, r); span = dummy_span }
  | TTuple types -> { item = TRole ({ item = TTuple (List.map (fun t -> add_role_if_missing t r) types); span = dummy_span }, r); span = dummy_span }
  | TArray inner -> { item = TRole ({ item = TArray inner; span = dummy_span }, r); span = dummy_span }
  | _ -> { item = TRole (t, r); span = dummy_span }

let is_int_type t = match t.item with
  | TBase TU8 | TBase TU16 | TBase TU32 | TBase TU64 | TBase TU128 | TBase TUSize
  | TBase TI8 | TBase TI16 | TBase TI32 | TBase TI64 | TBase TI128 | TBase TISize -> true
  | TRole ({ item = TBase TU8; _ }, _) | TRole ({ item = TBase TU16; _ }, _) | TRole ({ item = TBase TU32; _ }, _) | TRole ({ item = TBase TU64; _ }, _) | TRole ({ item = TBase TU128; _ }, _) | TRole ({ item = TBase TUSize; _ }, _)
  | TRole ({ item = TBase TI8; _ }, _) | TRole ({ item = TBase TI16; _ }, _) | TRole ({ item = TBase TI32; _ }, _) | TRole ({ item = TBase TI64; _ }, _) | TRole ({ item = TBase TI128; _ }, _) | TRole ({ item = TBase TISize; _ }, _) -> true
  | _ -> false

let is_float_type_t t = match t.item with
  | TBase TF16 | TBase TF32 | TBase TF64 | TBase TF128 -> true
  | TRole ({ item = TBase TF16; _ }, _) | TRole ({ item = TBase TF32; _ }, _)
  | TRole ({ item = TBase TF64; _ }, _) | TRole ({ item = TBase TF128; _ }, _) -> true
  | _ -> false

let is_numeric_type_t t = is_int_type t || is_float_type_t t



let is_bool_type t = match t.item with
  | TBase TBool -> true
  | TRole ({ item = TBase TBool; _ }, _) -> true
  | _ -> false

let is_str_type t = match t.item with
  | TBase TStr -> true
  | TRole ({ item = TBase TStr; _ }, _) -> true
  | _ -> false

let rec is_printable t =
  match t.item with
  | TBase _ -> true
  | TArray _ -> true
  | TResult _ -> true
  | TTuple _ -> true
  | TRole (inner, _) -> is_printable inner

let rec is_copy_type t =
  match t.item with
  | TRole (inner, _) -> is_copy_type inner
  | TBase (TU8 | TU16 | TU32 | TU64 | TU128 | TUSize | TI8 | TI16 | TI32 | TI64 | TI128 | TISize | TF16 | TF32 | TF64 | TF128 | TBool | TChar | TStr | TUnit) -> true
  | TBase (TCustom _) -> true
  | TArray _ -> true
  | _ -> false

let rec unwrap_role t =
  match t.item with
  | TRole (inner, _) -> unwrap_role inner
  | _ -> t



let rec substitute_typ subst t =
  match t.item with
  | TBase (TCustom id) ->
      (match StringMap.find_opt id subst with
      | Some t' -> t'
      | None -> t)
  | TBase (TGenericApp (targs, inner)) -> 
      let new_inner_t = substitute_typ subst { item = TBase inner; span = dummy_span } in
      let new_inner = match new_inner_t.item with TBase b -> b | _ -> inner in
      { item = TBase (TGenericApp (List.map (substitute_typ subst) targs, new_inner)); span = dummy_span }
  | TBase _ -> t
  | TResult (t1, t2) -> { item = TResult (substitute_typ subst t1, substitute_typ subst t2); span = dummy_span }
  | TRole (inner, r) -> { item = TRole (substitute_typ subst inner, r); span = dummy_span }
  | TArray inner -> { item = TArray (substitute_typ subst inner); span = dummy_span }
  | TTuple types -> { item = TTuple (List.map (substitute_typ subst) types); span = dummy_span }

let rec types_compatible expected actual =
  if expected = actual then true
  else match expected.item, actual.item with
  | TResult (e1, e2), TResult (a1, a2) ->
      let c1 = (a1.item = TBase (TCustom "_") || types_compatible e1 a1) in
      let c2 = (a2.item = TBase (TCustom "_") || types_compatible e2 a2) in
      c1 && c2
  | TRole (t_exp, r_exp), TRole (t_act, r_act) ->
      if r_exp = r_act || r_act = "Poly" || r_exp = "Poly" then types_compatible t_exp t_act else false
  | TRole (t_exp, _), _ ->
      types_compatible t_exp actual
  | _, TRole (t_act, _) ->
      types_compatible expected t_act
  | TBase (TGenericApp (targs1, inner1)), TBase (TGenericApp (targs2, inner2)) ->
      inner1 = inner2 && List.length targs1 = List.length targs2 && List.for_all2 types_compatible targs1 targs2
  | TTuple types1, TTuple types2 ->
      List.length types1 = List.length types2 && List.for_all2 types_compatible types1 types2
  | TArray a1, TArray a2 ->
      types_compatible a1 a2
  | TBase t1, TBase t2 ->
      if t1 = t2 then true
      else if (match t1 with TU8|TU16|TU32|TU64|TU128|TUSize|TI8|TI16|TI32|TI64|TI128|TISize|TF16|TF32|TF64|TF128 -> true | _ -> false) &&
              (match t2 with TU8|TU16|TU32|TU64|TU128|TUSize|TI8|TI16|TI32|TI64|TI128|TISize|TF16|TF32|TF64|TF128 -> true | _ -> false) then true
      else false
  | _, _ -> false

let rec unify_type expected actual subst params =
  match expected.item, actual.item with
  | TBase (TCustom name), _ when List.mem name params ->
      (match StringMap.find_opt name subst with
      | Some t -> if types_compatible t actual then subst else raise (TypeError ("Unification failed: conflicting types for " ^ name))
      | None -> StringMap.add name actual subst)
  | TRole (inner1, _), TRole (inner2, _) -> unify_type inner1 inner2 subst params
  | TRole (inner1, _), _ -> unify_type inner1 actual subst params
  | _, TRole (inner2, _) -> unify_type expected inner2 subst params
  | TArray inner1, TArray inner2 -> unify_type inner1 inner2 subst params
  | TTuple t1s, TTuple t2s ->
      if List.length t1s <> List.length t2s then raise (TypeError "Unification failed: tuple length mismatch");
      List.fold_left2 (fun s t1 t2 -> unify_type t1 t2 s params) subst t1s t2s
  | TResult (ok1, err1), TResult (ok2, err2) ->
      let s1 = unify_type ok1 ok2 subst params in
      unify_type err1 err2 s1 params
  | TBase (TGenericApp (targs1, inner1)), TBase (TGenericApp (targs2, inner2)) ->
      if inner1 <> inner2 then raise (TypeError "Unification failed: generic app mismatch");
      if List.length targs1 <> List.length targs2 then raise (TypeError "Unification failed: generic app length mismatch");
      List.fold_left2 (fun s t1 t2 -> unify_type t1 t2 s params) subst targs1 targs2
  | _, _ ->
      if types_compatible expected actual then subst
      else raise (TypeError ("Unification failed: incompatible types " ^ Ast.fmt_typ expected ^ " and " ^ Ast.fmt_typ actual))

let is_integer_type = function
  | TU8 | TU16 | TU32 | TU64 | TU128 | TUSize
  | TI8 | TI16 | TI32 | TI64 | TI128 | TISize -> true
  | _ -> false

let is_float_type = function
  | TF16 | TF32 | TF64 | TF128 -> true
  | _ -> false

let is_numeric_type t = is_integer_type t || is_float_type t

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
        let e = Parser.parse_standalone_expr Lexer.read (Lexing.from_string expr_str) in
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
  let base_t = match typ.item with TRole (t, _) -> t | _ -> typ in
  match base_t.item with
  | TBase (TCustom enum_name) ->
      (match StringMap.find_opt enum_name env.enums with
      | Some enum_decl ->
          let initial_set =
            List.fold_left (fun acc (m : Ast.enum_member) -> StringSet.add m.name acc) StringSet.empty enum_decl.members
          in
          let remaining = List.fold_left (fun set (pat, _) ->
            let process_pat set p =
              match p.item with
              | PWildcard | PIdent _ -> StringSet.empty
              | PVariant (v, _) -> StringSet.remove v set
              | PLit _ -> set
              | PTuple _ -> set (* Tuples don't have exhaustiveness checks beyond basic typechecking yet *)
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
          match p.item with
          | PWildcard | PIdent _ -> StringSet.empty
          | PVariant (v, _) -> StringSet.remove v set
          | PLit _ -> set
          | PTuple _ -> set
        in
        process_pat set pat
      ) initial_set arms in
      if not (StringSet.is_empty remaining) then
        raise (TypeError ("Non-exhaustive pattern matching for Result: missing variant(s) " ^ String.concat ", " (StringSet.elements remaining)))
  | TBase TBool ->
      let initial_set = StringSet.of_list ["true"; "false"] in
      let remaining = List.fold_left (fun set (pat, _) ->
        let process_pat set p =
          match p.item with
          | PWildcard | PIdent _ -> StringSet.empty
          | PLit (LBool b) -> StringSet.remove (string_of_bool b) set
          | _ -> set
        in
        process_pat set pat
      ) initial_set arms in
      if not (StringSet.is_empty remaining) then
        raise (TypeError ("Non-exhaustive pattern matching for bool: missing value(s) " ^ String.concat ", " (StringSet.elements remaining)))
  | TTuple _ ->
      let has_tuple_catch = List.exists (fun (pat, _) ->
        match pat.item with
        | PWildcard | PIdent _ | PTuple _ -> true
        | _ -> false
      ) arms in
      if not has_tuple_catch then raise (TypeError "Non-exhaustive pattern matching for Tuple: requires a tuple pattern, wildcard, or identifier")
  | _ ->
      let has_catch_all = List.exists (fun (pat, _) ->
        match pat.item with
        | PWildcard | PIdent _ -> true
        | _ -> false
      ) arms in
      if not has_catch_all then raise (TypeError "Non-exhaustive pattern matching on non-enum type: requires a wildcard pattern '_' or identifier pattern")

let rec bind_pat env pat typ is_mut =
  match pat.item with
  | PWildcard -> env
  | PLit l ->
      let lit_t = match l with
      | LInt (_, Some t) -> { item = TBase t; span = dummy_span }
      | LInt (_, None) -> 
          let base_typ = match typ.item with TRole (t, _) -> t | _ -> typ in
          (match base_typ.item with
          | TBase t when is_integer_type t -> typ
          | _ -> { item = TBase TI32; span = dummy_span })
      | LFloat (_, Some t) -> { item = TBase t; span = dummy_span }
      | LFloat (_, None) -> { item = TBase TF64; span = dummy_span }
      | LBool _ -> { item = TBase TBool; span = dummy_span }
      | LStr _ -> { item = TBase TStr; span = dummy_span }
      | LChar _ -> { item = TBase TChar; span = dummy_span }
      in
      if not (types_compatible typ lit_t) then raise (TypeError "Pattern literal type mismatch");
      env
  | PIdent id -> { env with vars = StringMap.add id (add_role_if_missing typ env.current_role, is_mut, Live, pat.span, ref false) env.vars }
  | PVariant (variant_name, Some pat_list) ->
      let base_t = match typ.item with TRole (t, _) -> t | _ -> typ in
      (match base_t.item with
      | TBase (TCustom enum_name) ->
          (match StringMap.find_opt enum_name env.enums with
          | Some enum_decl ->
              (match List.find_opt (fun (m: Ast.enum_member) -> m.name = variant_name) enum_decl.members with
              | Some variant ->
                  if List.length pat_list <> List.length variant.payload then
                    raise (TypeError ("Pattern payload length mismatch for variant " ^ variant_name));
                  List.fold_left2 (fun env p t -> bind_pat env p t is_mut) env pat_list variant.payload
              | None -> raise (TypeError ("Variant " ^ variant_name ^ " not found in enum " ^ enum_name)))
          | None -> env)
      | TResult (t1, t2) ->
          if variant_name = "Ok" && List.length pat_list = 1 then bind_pat env (List.hd pat_list) t1 is_mut
          else if variant_name = "Err" && List.length pat_list = 1 then bind_pat env (List.hd pat_list) t2 is_mut
          else raise (TypeError "Result pattern length mismatch")
      | _ -> raise (TypeError ("Pattern matching with variants is only supported for Enums and Results. Got: " ^ Ast.fmt_typ typ)))
  | PVariant (variant_name, None) ->
      let base_t = match typ.item with TRole (t, _) -> t | _ -> typ in
      (match base_t.item with
      | TBase (TCustom enum_name) ->
          (match StringMap.find_opt enum_name env.enums with
          | Some enum_decl ->
              (match List.find_opt (fun (m: Ast.enum_member) -> m.name = variant_name) enum_decl.members with
              | Some variant ->
                  if List.length variant.payload > 0 then
                    raise (TypeError ("Variant " ^ variant_name ^ " requires a payload"));
                  env
              | None -> raise (TypeError ("Variant " ^ variant_name ^ " not found in enum " ^ enum_name)))
          | None -> env)
      | TResult _ ->
          raise (TypeError "Result variants (Ok/Err) expect a payload")
      | _ -> raise (TypeError ("Pattern matching with variants is only supported for Enums and Results. Got: " ^ Ast.fmt_typ typ)))
  | PTuple pat_list ->
      let base_t = match typ.item with TRole (t, _) -> t | _ -> typ in
      (match base_t.item with
      | TTuple typ_list ->
          if List.length pat_list <> List.length typ_list then
            raise (TypeError "Tuple pattern length mismatch");
          List.fold_left2 (fun env p t -> bind_pat env p t is_mut) env pat_list typ_list
      | _ -> raise (TypeError "Expected tuple type for tuple pattern")
      )

let rec check_expr_impl env e expected_typ_opt =
  match e.item with
  | ELit (LInt (_, t_opt)) -> 
      (match t_opt with
      | Some t -> TBase t, env
      | None ->
          let unwrap_expected = match expected_typ_opt with
            | Some { item = TRole (inner, _); _ } -> Some inner
            | other -> other
          in
          (match unwrap_expected with
          | Some { item = TBase t; _ } when is_integer_type t -> TBase t, env
          | _ -> TBase TI32, env))
  | ELit (LFloat (_, t_opt)) ->
      (match t_opt with
      | Some t -> TBase t, env
      | None ->
          let unwrap_expected = match expected_typ_opt with
            | Some { item = TRole (inner, _); _ } -> Some inner
            | other -> other
          in
          (match unwrap_expected with
          | Some { item = TBase (TF16 | TF32 | TF64 | TF128 as t); _ } -> TBase t, env
          | _ -> TBase TF64, env))
  | ELit (LBool _) -> TBase TBool, env
  | ELit (LStr _) -> TBase TStr, env
  | ELit (LChar _) -> TBase TChar, env
  | EVar name ->
      (match StringMap.find_opt name env.vars with
            | Some (_, _, Consumed, _sp, _used_ref) -> raise (Diagnostic.LocatedError (
            Diagnostic.make_error
              ~code:Error_codes.var_consumed
              ~label:(Printf.sprintf "variable `%s` used here after being moved" name)
              ~notes:[Printf.sprintf "`%s` is a linear resource and can only be used once" name]
              ~hints:["consider passing it by reference if you need to use it multiple times"]
              (Printf.sprintf "use of moved variable `%s`" name)
              e.span))
      | Some (t, is_mut, Live, _sp, _used_ref) -> _used_ref := true;
          let var_role = match t.item with | TRole (_, r) -> r | _ -> "Main" in
          if var_role <> "Global" && var_role <> env.current_role && env.current_role <> "Poly" then
            raise (TypeError (Printf.sprintf "Cannot access variable %s belonging to role %s from role %s" name var_role env.current_role));
          let new_vars = match t.item with
            | TRole _ when not (is_copy_type t) -> (_used_ref := true; StringMap.add name (t, is_mut, Consumed, _sp, _used_ref) env.vars)
            | _ -> env.vars
          in
          t.item, { env with vars = new_vars }
      | None ->
          (match StringMap.find_opt name env.globals with
          | Some t ->
              let var_role = match t.item with | TRole (_, r) -> r | _ -> "Global" in
              if var_role <> "Global" && var_role <> env.current_role then
                raise (TypeError (Printf.sprintf "Cannot access global %s belonging to role %s from role %s" name var_role env.current_role));
              t.item, env
          | None -> raise (Diagnostic.LocatedError (
                Diagnostic.make_error
                  ~code:Error_codes.undefined_variable
                  ~label:(Printf.sprintf "`%s` is not defined" name)
                  ~hints:[Printf.sprintf "did you misspell `%s` or forget to declare it?" name]
                  (Printf.sprintf "undefined variable `%s`" name)
                  e.span))))
  | EPathVar path ->
      let resolved_path =
        match StringMap.find_opt (List.hd path) env.imports with
        | Some (mod_path, _, _used_ref) -> _used_ref := true; mod_path @ List.tl path
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
          | Some (params, { item = IFn f; _ }) ->
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
                | None -> { item = TBase TUnit; span = dummy_span }
              in
              let f_role = Option.value f.role ~default:env_clean.current_role in
              if f_role <> env_clean.current_role && f_role <> "global" then (
                let ret_with_role = TRole (base_ret, f_role) in
                ret_with_role, env_after_args
              ) else
                let final_ret = if f_role = env_clean.current_role then base_ret.item else TRole (base_ret, f_role) in
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
                | None -> { item = TBase TUnit; span = dummy_span }
              in
              let f_role = Option.value f.role ~default:env_clean.current_role in
              if f_role <> env_clean.current_role && f_role <> "global" then (
                let ret_with_role = TRole (base_ret, f_role) in
                ret_with_role, env_after_args
              ) else
                let final_ret = if f_role = env_clean.current_role then base_ret.item else TRole (base_ret, f_role) in
                final_ret, env_after_args
          | None ->
              (match StringMap.find_opt name env_clean.generic_items with
              | Some (params, { item = IFn f; _ }) ->
                  if List.length args <> List.length f.params then raise (TypeError ("Arity mismatch for " ^ name));
                  (* Infer generic arguments! *)
                  let args_typed = List.map (fun arg_expr -> 
                     let t_arg, _ = check_expr env_clean arg_expr None in
                     t_arg
                  ) args in
                  let subst = List.fold_left2 (fun acc (p: Ast.param) arg_t ->
                     unify_type p.typ arg_t acc params
                  ) StringMap.empty f.params args_typed in
                  
                  let targs = List.map (fun p -> 
                    match StringMap.find_opt p subst with
                    | Some t -> t
                    | None -> raise (TypeError ("Could not infer type argument " ^ p ^ " for " ^ name))
                  ) params in
                  
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
                    | None -> { item = TBase TUnit; span = dummy_span }
                  in
                  let f_role = Option.value f.role ~default:env_clean.current_role in
                  if f_role <> env_clean.current_role && f_role <> "global" then (
                    let ret_with_role = TRole (base_ret, f_role) in
                    ret_with_role, env_after_args
                  ) else
                    let final_ret = if f_role = env_clean.current_role then base_ret.item else TRole (base_ret, f_role) in
                    final_ret, env_after_args
              | _ -> raise (TypeError ("Undefined function: " ^ name)))))
  | EMethodCall (obj, method_name, args, resolved_name_ref) ->
      let t_obj, _ = check_expr env obj None in
      let rec find_method impls =
        match impls with
        | [] -> raise (TypeError ("No method " ^ method_name ^ " found for type " ^ Ast.fmt_typ t_obj))
        | impl :: rest ->
            if types_compatible impl.for_typ t_obj then
              match List.find_opt (fun (m: Ast.fn_decl) -> m.name = method_name) impl.methods with
              | Some m -> (impl, m)
              | None -> find_method rest
            else find_method rest
      in
      let (impl, _) = find_method env.impls in
      let mangled_name = impl.trait_name ^ "_" ^ (Ast.fmt_typ impl.for_typ |> String.map (function ' ' | '(' | ')' -> '_' | c -> c)) ^ "_" ^ method_name in
      resolved_name_ref := Some mangled_name;
      check_expr_impl env { item = ECall (mangled_name, obj :: args); span = dummy_span } expected_typ_opt
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
        | Some (actual_module, _, _used_ref) -> _used_ref := true; actual_module @ (List.tl path)
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
        ) else if resolved_path = ["std"; "io"; "read_line"] then (
          if List.length args <> 0 then raise (TypeError "std::io::read_line expects 0 arguments");
          TBase TStr, env
        ) else if resolved_path = ["std"; "fs"; "read_file"] then (
          if List.length args <> 1 then raise (TypeError "std::fs::read_file expects 1 argument (path: str)");
          let t_path, env_next = check_expr env (List.hd args) None in
          if t_path <> { item = TBase TStr; span = dummy_span } then raise (TypeError "std::fs::read_file path must be a string");
          TBase TStr, env_next
        ) else if resolved_path = ["std"; "fs"; "write_file"] then (
          if List.length args <> 2 then raise (TypeError "std::fs::write_file expects 2 arguments (path: str, content: str)");
          let t_path, env1 = check_expr env (List.hd args) None in
          let t_content, env2 = check_expr env1 (List.nth args 1) None in
          if t_path <> { item = TBase TStr; span = dummy_span } || t_content <> { item = TBase TStr; span = dummy_span } then raise (TypeError "std::fs::write_file arguments must be strings");
          TBase TBool, env2
        ) else if resolved_path = ["std"; "fs"; "file_exists"] then (
          if List.length args <> 1 then raise (TypeError "std::fs::file_exists expects 1 argument (path: str)");
          let t_path, env_next = check_expr env (List.hd args) None in
          if t_path <> { item = TBase TStr; span = dummy_span } then raise (TypeError "std::fs::file_exists path must be a string");
          TBase TBool, env_next
        ) else if resolved_path = ["std"; "process"; "exit"] then (
          if List.length args <> 1 then raise (TypeError "std::process::exit expects 1 argument (code: int)");
          let t_code, env_next = check_expr env (List.hd args) None in
          if not (is_int_type t_code) then raise (TypeError "std::process::exit code must be an integer");
          TBase TUnit, env_next
        ) else if resolved_path = ["std"; "process"; "sleep"] then (
          if List.length args <> 1 then raise (TypeError "std::process::sleep expects 1 argument (ms: int)");
          let t_ms, env_next = check_expr env (List.hd args) None in
          if not (is_int_type t_ms) then raise (TypeError "std::process::sleep duration must be an integer");
          TBase TUnit, env_next
        ) else if resolved_path = ["std"; "time"; "now_ms"] then (
          if List.length args <> 0 then raise (TypeError "std::time::now_ms expects 0 arguments");
          TBase TU64, env
        ) else if resolved_path = ["std"; "process"; "args"] then (
          if List.length args <> 0 then raise (TypeError "std::process::args expects 0 arguments");
          TArray ({ item = TBase TStr; span = dummy_span }), env
        ) else if List.length resolved_path = 3 && List.nth resolved_path 0 = "std" && List.nth resolved_path 1 = "string" then (
          let fn_name = List.nth resolved_path 2 in
          match fn_name with
          | "len" ->
              if List.length args <> 1 then raise (TypeError "std::string::len expects 1 argument");
              let t, env1 = check_expr env (List.hd args) None in
              if unwrap_role t <> { item = TBase TStr; span = dummy_span } then raise (TypeError "std::string::len argument must be a string");
              TBase TI64, env1
          | "concat" | "starts_with" | "ends_with" ->
              if List.length args <> 2 then raise (TypeError ("std::string::" ^ fn_name ^ " expects 2 arguments"));
              let t1, env1 = check_expr env (List.hd args) None in
              let t2, env2 = check_expr env1 (List.nth args 1) None in
              if unwrap_role t1 <> { item = TBase TStr; span = dummy_span } || unwrap_role t2 <> { item = TBase TStr; span = dummy_span } then raise (TypeError ("std::string::" ^ fn_name ^ " arguments must be strings"));
              (if fn_name = "concat" then TBase TStr else TBase TBool), env2
          | "to_uppercase" | "to_lowercase" | "trim" ->
              if List.length args <> 1 then raise (TypeError ("std::string::" ^ fn_name ^ " expects 1 argument"));
              let t, env1 = check_expr env (List.hd args) None in
              if unwrap_role t <> { item = TBase TStr; span = dummy_span } then raise (TypeError ("std::string::" ^ fn_name ^ " argument must be a string"));
              TBase TStr, env1
          | "replace" ->
              if List.length args <> 3 then raise (TypeError "std::string::replace expects 3 arguments");
              let t1, env1 = check_expr env (List.hd args) None in
              let t2, env2 = check_expr env1 (List.nth args 1) None in
              let t3, env3 = check_expr env2 (List.nth args 2) None in
              if unwrap_role t1 <> { item = TBase TStr; span = dummy_span } || unwrap_role t2 <> { item = TBase TStr; span = dummy_span } || unwrap_role t3 <> { item = TBase TStr; span = dummy_span } then
                raise (TypeError "std::string::replace arguments must be strings");
              TBase TStr, env3
          | "substring" ->
              if List.length args <> 3 then raise (TypeError "std::string::substring expects 3 arguments");
              let t1, env1 = check_expr env (List.hd args) None in
              let t2, env2 = check_expr env1 (List.nth args 1) None in
              let t3, env3 = check_expr env2 (List.nth args 2) None in
              if unwrap_role t1 <> { item = TBase TStr; span = dummy_span } || not (is_int_type t2) || not (is_int_type t3) then
                raise (TypeError "std::string::substring requires (str, int, int)");
              TBase TStr, env3
          | "char_at" ->
              if List.length args <> 2 then raise (TypeError "std::string::char_at expects 2 arguments");
              let t1, env1 = check_expr env (List.hd args) None in
              let t2, env2 = check_expr env1 (List.nth args 1) None in
              if unwrap_role t1 <> { item = TBase TStr; span = dummy_span } || not (is_int_type t2) then
                raise (TypeError "std::string::char_at requires (str, int)");
              TBase TStr, env2
          | "split" ->
              if List.length args <> 2 then raise (TypeError "std::string::split expects 2 arguments");
              let t1, env1 = check_expr env (List.hd args) None in
              let t2, env2 = check_expr env1 (List.nth args 1) None in
              if unwrap_role t1 <> { item = TBase TStr; span = dummy_span } || unwrap_role t2 <> { item = TBase TStr; span = dummy_span } then
                raise (TypeError "std::string::split arguments must be strings");
              TArray ({ item = TBase TStr; span = dummy_span }), env2
          | _ -> raise (TypeError ("Undefined std::string function: " ^ fn_name))
        ) else if List.length resolved_path = 3 && List.nth resolved_path 0 = "std" && List.nth resolved_path 1 = "conv" then (
          let fn_name = List.nth resolved_path 2 in
          match fn_name with
          | "parse_int" ->
              if List.length args <> 1 then raise (TypeError "std::conv::parse_int expects 1 argument");
              let t, env1 = check_expr env (List.hd args) None in
              if unwrap_role t <> { item = TBase TStr; span = dummy_span } then raise (TypeError "std::conv::parse_int argument must be a string");
              TResult ({ item = TBase TI64; span = dummy_span }, { item = TBase TStr; span = dummy_span }), env1
          | "parse_bool" ->
              if List.length args <> 1 then raise (TypeError "std::conv::parse_bool expects 1 argument");
              let t, env1 = check_expr env (List.hd args) None in
              if unwrap_role t <> { item = TBase TStr; span = dummy_span } then raise (TypeError "std::conv::parse_bool argument must be a string");
              TResult ({ item = TBase TBool; span = dummy_span }, { item = TBase TStr; span = dummy_span }), env1
          | "to_str" ->
              if List.length args <> 1 then raise (TypeError "std::conv::to_str expects 1 argument");
              let t, env1 = check_expr env (List.hd args) None in
              if not (is_printable t) then raise (TypeError "std::conv::to_str argument must be printable");
              TBase TStr, env1
          | _ -> raise (TypeError ("Undefined std::conv function: " ^ fn_name))
        ) else if List.length resolved_path = 3 && List.nth resolved_path 0 = "std" && List.nth resolved_path 1 = "collections" then (
          let fn_name = List.nth resolved_path 2 in
          match fn_name with
          | "len" | "pop" | "reverse" ->
              if List.length args <> 1 then raise (TypeError ("std::collections::" ^ fn_name ^ " expects 1 argument"));
              let t, env1 = check_expr env (List.hd args) None in
              (match unwrap_role t with
              | { item = TArray _; _ } ->
                  if fn_name = "len" then
                    let env_live = match List.hd args with
                      | { item = EVar name; _ } -> (match StringMap.find_opt name env1.vars with Some (vt, mut, _, _sp, _used_ref) -> _used_ref := true; { env1 with vars = StringMap.add name (vt, mut, Live, _sp, _used_ref) env1.vars } | None -> env1)
                      | _ -> env1
                    in
                    TBase TI64, env_live
                  else t.item, env1
              | _ -> raise (TypeError ("std::collections::" ^ fn_name ^ " argument must be an array")))
          | "push" ->
              if List.length args <> 2 then raise (TypeError "std::collections::push expects 2 arguments");
              let t_arr, env1 = check_expr env (List.hd args) None in
              (match unwrap_role t_arr with
              | { item = TArray elem_t; _ } ->
                  let t_elem, env2 = check_expr env1 (List.nth args 1) (Some elem_t) in
                  if not (types_compatible elem_t t_elem) then raise (TypeError "Type mismatch in std::collections::push");
                  t_arr.item, env2
              | _ -> raise (TypeError "std::collections::push first argument must be an array"))
          | "contains" ->
              if List.length args <> 2 then raise (TypeError "std::collections::contains expects 2 arguments");
              let t_arr, env1 = check_expr env (List.hd args) None in
              (match unwrap_role t_arr with
              | { item = TArray elem_t; _ } ->
                  let t_elem, env2 = check_expr env1 (List.nth args 1) (Some elem_t) in
                  if not (types_compatible elem_t t_elem) then raise (TypeError "Type mismatch in std::collections::contains");
                  let env_live = match List.hd args with
                    | { item = EVar name; _ } -> (match StringMap.find_opt name env2.vars with Some (vt, mut, _, _sp, _used_ref) -> _used_ref := true; { env2 with vars = StringMap.add name (vt, mut, Live, _sp, _used_ref) env2.vars } | None -> env2)
                    | _ -> env2
                  in
                  TBase TBool, env_live
              | _ -> raise (TypeError "std::collections::contains first argument must be an array"))
          | _ -> raise (TypeError ("Undefined std::collections function: " ^ fn_name))
        ) else if List.length resolved_path = 3 && List.nth resolved_path 0 = "std" && List.nth resolved_path 1 = "math" then (
          let fn_name = List.nth resolved_path 2 in
          match fn_name with
          | "abs" | "sin" | "cos" | "tan" | "sqrt" | "log" ->
              if List.length args <> 1 then raise (TypeError ("std::math::" ^ fn_name ^ " expects 1 argument"));
              let t_arg, env_next = check_expr env (List.hd args) None in
              if not (is_numeric_type_t t_arg) then raise (TypeError ("std::math::" ^ fn_name ^ " argument must be numeric"));
              let ret = if is_float_type_t t_arg then t_arg.item else TBase TF64 in
              ret, env_next
          | "min" | "max" | "pow" ->
              if List.length args <> 2 then raise (TypeError ("std::math::" ^ fn_name ^ " expects 2 arguments"));
              let t1, env1 = check_expr env (List.hd args) None in
              let t2, env2 = check_expr env1 (List.nth args 1) None in
              if not (is_numeric_type_t t1) || not (is_numeric_type_t t2) then raise (TypeError ("std::math::" ^ fn_name ^ " arguments must be numeric"));
              let ret = if is_float_type_t t1 then t1.item else if is_float_type_t t2 then t2.item else TBase TF64 in
              ret, env2
          | "clamp" ->
              if List.length args <> 3 then raise (TypeError "std::math::clamp expects 3 arguments");
              let t1, env1 = check_expr env (List.hd args) None in
              let t2, env2 = check_expr env1 (List.nth args 1) None in
              let t3, env3 = check_expr env2 (List.nth args 2) None in
              if not (is_numeric_type_t t1) || not (is_numeric_type_t t2) || not (is_numeric_type_t t3) then
                raise (TypeError "std::math::clamp arguments must be numeric");
              t1.item, env3
          | _ -> raise (TypeError ("Undefined std::math function: " ^ fn_name))
        ) else if resolved_path = ["std"; "hw"; "bind_interrupt"] then (
          if List.length args <> 2 then raise (TypeError ("bind_interrupt expects 2 arguments"));
          let t_irq, env_next = check_expr env (List.hd args) None in
          if not (is_int_type t_irq) then raise (TypeError "IRQ number must be an integer");
          let handler_arg = List.nth args 1 in
          (match handler_arg with
           | { item = EVar name; _ } ->
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
            check_expr_impl env_with_fn { item = ECall (temp_name, args); span = dummy_span } expected_typ_opt
        | None -> raise (TypeError ("Function not found in module: " ^ func_name))
      )
  | EUnOp (Not, e) ->
      let t, env1 = check_expr env e (Some ({ item = TBase TBool; span = dummy_span })) in
      if t = { item = TBase TBool; span = dummy_span } then TBase TBool, env1
      else raise (TypeError "Logical NOT requires a boolean type")
  | EUnOp (Neg, e) ->
      let t, env1 = check_expr env e expected_typ_opt in
      if is_int_type t then t.item, env1
      else raise (TypeError "Negation requires an integer type")
  | EBinOp (e1, op, e2) ->
      let expected_e1 = match op with
        | Add | Sub | Mul | Div | Shl | Shr | BitAnd | BitOr -> expected_typ_opt
        | Eq | Neq | Lt | Gt | Lte | Gte | And | Or -> None
      in
      let t1, env1 = check_expr env e1 expected_e1 in
      let t2, env2 = check_expr env1 e2 (Some t1) in
      if not (types_compatible t1 t2) then raise (Diagnostic.LocatedError (
          Diagnostic.make_error
            ~code:Error_codes.binop_type_mismatch
            ~label:(Printf.sprintf "operands have types `%s` and `%s`" (Ast.fmt_typ t1) (Ast.fmt_typ t2))
            ~secondary_labels:[
              { span = e1.span; message = Printf.sprintf "this is `%s`" (Ast.fmt_typ t1) };
              { span = e2.span; message = Printf.sprintf "this is `%s`" (Ast.fmt_typ t2) };
            ]
            ~hints:(if is_numeric_type_t t1 && is_numeric_type_t t2 then [Printf.sprintf "consider casting the right operand using `as %s`" (Ast.fmt_typ t1)] else [])
            ~patches:(if is_numeric_type_t t1 && is_numeric_type_t t2 then [{ Diagnostic.span = e2.span; replacement = Printf.sprintf "(%s as %s)" (Diagnostic.extract_span_text e2.span) (Ast.fmt_typ t1) }] else [])
            (Printf.sprintf "mismatched types: `%s` vs `%s`" (Ast.fmt_typ t1) (Ast.fmt_typ t2))
            e.span));
      (match op with
      | Add | Sub | Mul | Div | Shl | Shr | BitAnd | BitOr ->
          if is_numeric_type_t t1 then t1.item, env2
          else raise (TypeError "Arithmetic/Bitwise operators require numeric types")
      | Eq | Neq ->
          TBase TBool, env2
      | Lt | Gt | Lte | Gte ->
          if is_numeric_type_t t1 then TBase TBool, env2
          else raise (TypeError "Comparison operators require numeric types")
      | And | Or ->
          if is_bool_type t1 && is_bool_type t2 then TBase TBool, env2
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
      let expected_ok = match expected_typ_opt with
        | Some { item = TResult (t_ok, _); _ } -> Some t_ok
        | _ -> None
      in
      let t, env1 = check_expr env e expected_ok in
      let err_t = match expected_typ_opt with
        | Some { item = TResult (_, t_err); _ } -> t_err
        | _ -> { item = TBase (TCustom "_"); span = dummy_span }
      in
      TResult (t, err_t), env1
  | EErr (e, _) ->
      let expected_err = match expected_typ_opt with
        | Some { item = TResult (_, t_err); _ } -> Some t_err
        | _ -> None
      in
      let t, env1 = check_expr env e expected_err in
      let ok_t = match expected_typ_opt with
        | Some { item = TResult (t_ok, _); _ } -> t_ok
        | _ -> { item = TBase (TCustom "_"); span = dummy_span }
      in
      TResult (ok_t, t), env1
  | EIf (cond, thn, els) ->
      let t_cond, env1 = check_expr env cond (Some ({ item = TBase TBool; span = dummy_span })) in
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
          if not (types_compatible (Option.value t_thn ~default:({ item = TBase TUnit; span = dummy_span })) (Option.value t_els ~default:({ item = TBase TUnit; span = dummy_span }))) then 
                raise (Diagnostic.LocatedError (
              Diagnostic.make_error
                ~code:Error_codes.if_branch_mismatch
                ~label:"branches have different types"
                ~notes:[Printf.sprintf "then branch: `%s`, else branch: `%s`"
                  (Ast.fmt_typ (Option.value t_thn ~default:{ item = TBase TUnit; span = dummy_span }))
                  (Ast.fmt_typ (Option.value t_els ~default:{ item = TBase TUnit; span = dummy_span }))]
                "if and else branches must return the same type"
                e.span));
          (Option.value t_thn ~default:({ item = TBase TUnit; span = dummy_span })).item, { env_els with vars = env_thn.vars }
      | None ->
          if trace_thn <> [] then
            raise (TypeError "Asymmetric choreography: 'if' without 'else' cannot contain 'transfer' operations");
          (match t_thn with
          | Some t when (unwrap_role t).item <> TBase TUnit -> raise (TypeError "if without else cannot return a value")
          | _ -> ());
          TBase TUnit, env_thn)
  | EStruct (name, fields, _) ->
      let targs_opt = env.active_targs in
      let env_clean = { env with active_targs = None } in
      (match targs_opt with
      | Some targs ->
          (match StringMap.find_opt name env_clean.generic_items with
          | Some (params, { item = IStruct s_decl; _ }) ->
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
          | None ->
              (match StringMap.find_opt name env_clean.generic_items with
              | Some (params, { item = IStruct s_decl; _ }) ->
                  if List.length fields <> List.length s_decl.fields then
                    raise (TypeError ("Arity mismatch for struct " ^ name));
                  let fields_typed = List.map (fun (f_name, f_expr) -> 
                     let t_expr, _ = check_expr env_clean f_expr None in
                     (f_name, t_expr)
                  ) fields in
                  let subst = List.fold_left (fun acc (f_name, arg_t) ->
                     match List.find_opt (fun (f : Ast.field) -> f.name = f_name) s_decl.fields with
                     | Some f_decl -> unify_type f_decl.typ arg_t acc params
                     | None -> raise (TypeError ("Struct " ^ name ^ " missing field " ^ f_name))
                  ) StringMap.empty fields_typed in
                  
                  let targs = List.map (fun p -> 
                    match StringMap.find_opt p subst with
                    | Some t -> t
                    | None -> raise (TypeError ("Could not infer type argument " ^ p ^ " for " ^ name))
                  ) params in
                  
                  let subst = List.fold_left2 (fun acc p t -> StringMap.add p t acc) StringMap.empty params targs in
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
              | _ -> raise (TypeError ("Undeclared struct: " ^ name)))))
  | EField (e, field_name) ->
      let t_e, env1 = check_expr env e None in
      let env_res = match e.item with
        | EVar name ->
            (match StringMap.find_opt name env1.vars with
             | Some (vt, mut, _, _sp, _used_ref) -> _used_ref := true; { env1 with vars = StringMap.add name (vt, mut, Live, _sp, _used_ref) env1.vars }
             | None -> env1)
        | _ -> env1
      in
      let base = match t_e.item with TRole (inner, _) -> inner | _ -> t_e in
      (match base.item with
      | TBase (TGenericApp (targs, TCustom name)) ->
          (match StringMap.find_opt name env_res.generic_items with
          | Some (params, { item = IStruct s_decl; _ }) ->
              let subst = List.fold_left2 (fun acc p t -> StringMap.add p t acc) StringMap.empty params targs in
              (match List.find_opt (fun (f : Ast.field) -> f.name = field_name) s_decl.fields with
              | Some f_decl -> (substitute_typ subst f_decl.typ).item, env_res
              | None -> raise (TypeError ("Unknown field " ^ field_name ^ " on struct " ^ name)))
          | _ -> raise (TypeError ("Unknown generic struct: " ^ name)))
      | TBase (TCustom name) ->
          (match StringMap.find_opt name env_res.structs with
          | Some s_decl ->
              (match List.find_opt (fun (f : Ast.field) -> f.name = field_name) s_decl.fields with
              | Some f_decl -> f_decl.typ.item, env_res
              | None -> raise (TypeError ("Unknown field " ^ field_name ^ " on struct " ^ name)))
          | None -> raise (TypeError ("Unknown struct: " ^ name)))
      | TTuple typ_list ->
          (try
            let idx = int_of_string field_name in
            (List.nth typ_list idx).item, env1
          with _ -> raise (TypeError ("Invalid tuple index: " ^ field_name)))
      | _ -> raise (TypeError "Field access on non-struct type"))
  | EMatch (e, arms) ->
      let t_e, env1 = check_expr env e None in
      check_match_exhaustiveness env1 t_e arms;
      let arm_results = List.map (fun (pat, e_arm) ->
        let env_arm = bind_pat env1 pat t_e false in
        check_expr env_arm e_arm None
      ) arms in
      let first_t, first_env = List.hd arm_results in
      List.iter (fun (t, _) -> if not (types_compatible t first_t) then raise (TypeError "Match arms have different types")) arm_results;
      first_t.item, first_env
  | ECast (e, t) ->
      let t_e, env1 = check_expr env e None in
      let base_te = (unwrap_role t_e).item in
      let base_t = (unwrap_role t).item in
      if not (is_numeric_type_t { item = base_te; span = dummy_span } || is_bool_type { item = base_te; span = dummy_span } || base_te = TBase TChar || base_te = TBase TStr) ||
         not (is_numeric_type_t { item = base_t; span = dummy_span } || is_bool_type { item = base_t; span = dummy_span } || base_t = TBase TChar || base_t = TBase TStr) then
        raise (TypeError "Can only cast between numeric/boolean/char/string types");
      t.item, env1
  | EGenericApp (targs, e) ->
      let env_with_targs = { env with active_targs = Some targs } in
      let t_inner, env_next = check_expr env_with_targs e expected_typ_opt in
      t_inner.item, { env_next with active_targs = env.active_targs }
  | EArray elems ->
      let expected_elem_t = match expected_typ_opt with
        | Some { item = TArray t; _ } -> Some t
        | Some { item = TRole ({ item = TArray t; _ }, _); _ } -> Some t
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
  | ETuple elems ->
      let expected_elem_types = match expected_typ_opt with
        | Some { item = TTuple ts; _ } -> Some ts
        | Some { item = TRole ({ item = TTuple ts; _ }, _); _ } -> Some ts
        | _ -> None
      in
      let env_curr = ref env in
      let types = List.mapi (fun i elem ->
        let expected_t = match expected_elem_types with
          | Some ts when i < List.length ts -> Some (List.nth ts i)
          | _ -> None
        in
        let t_elem, env_next = check_expr !env_curr elem expected_t in
        env_curr := env_next;
        t_elem
      ) elems in
      TTuple types, !env_curr
  | EIndex (arr, i) ->
      let t_arr, env2 = check_expr env arr None in
      let t_i, env3 = check_expr env2 i None in
      if not (is_int_type t_i) then raise (TypeError "Array index must be an integer");
      let base_arr_t = match t_arr.item with | TRole (inner, _) -> inner | _ -> t_arr in
      (match base_arr_t.item with
      | TArray t_elem -> t_elem.item, env3
      | TBase TStr -> TBase TChar, env3
      | _ -> raise (TypeError "Cannot index non-array/non-string type"))
  | ETransfer (e, role) ->
      if not (StringMap.mem role env.roles) then raise (TypeError ("Undeclared role in transfer: " ^ role));
      let t_e, env1 = check_expr env e None in
      let base_t = match t_e.item with
        | TRole (inner, _) -> inner
        | _ -> t_e
      in
      let env_with_trace = { env1 with trace = env1.trace @ [(role, base_t)] } in
      if role = "Compiler" then
        (base_t.item, env_with_trace)
      else
        (TRole (base_t, role), env_with_trace)
  | EDup (_, e) -> let t, env' = check_expr env e None in t.item, env'
  | ETyped (inner, t) ->
      let _, env' = check_expr env inner (Some t) in
      (t.item, env')
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
      let t, env' = check_expr env inner expected_typ_opt in t.item, env'

and check_expr env e expected_typ_opt =
  let (t, env') = check_expr_impl env e expected_typ_opt in
  let typ = { item = t; span = e.span } in
  ExprMap.replace typed_ast_map e typ;
  (typ, env')

and check_stmt env stmt =
  match stmt.item with
  | SDecl { kind; pat; typ; init } ->
      let t_init, env1 = check_expr env init typ in
      let typ_with_role = match typ with
        | Some t -> Some (add_role_if_missing t env1.current_role)
        | None -> None
      in
      (match typ_with_role with
      | Some t -> if not (types_compatible t t_init) then raise (TypeError (Printf.sprintf "Type mismatch in declaration: expected %s, got %s" (Ast.fmt_typ t) (Ast.fmt_typ t_init)))
      | None -> ());
      let t_final = Option.value typ_with_role ~default:t_init in
      let t_final = add_role_if_missing t_final env1.current_role in
      if kind = VConst then (
         (match init with
         | { item = ELit _; _ } -> ()
         | _ -> raise (TypeError ("const variables must be initialized with a constant literal")))
      );
      let is_mut = (kind = VVar) in
      bind_pat env1 pat t_final is_mut
  | SAssign (lhs, e) ->
      (match lhs with
      | { item = EVar name; _ } ->
          (match StringMap.find_opt name env.vars with
            | Some (var_t, true, Live, _sp, _used_ref) ->
              let t_e, env1 = check_expr env e (Some var_t) in
              if not (types_compatible var_t t_e) then raise (TypeError ("Type mismatch in assignment to " ^ name));
              { env1 with vars = StringMap.add name (t_e, true, Live, stmt.span, ref false) env1.vars }
          | Some (_, false, _, _, _) -> raise (TypeError ("Cannot reassign immutable variable " ^ name))
          | Some (_, _, Consumed, _sp, _used_ref) -> raise (TypeError ("Cannot reassign consumed variable " ^ name))
          | None ->
              (match StringMap.find_opt name env.globals with
              | Some t_var ->
                  let t_e, env1 = check_expr env e (Some t_var) in
                  let global_role = match t_var.item with | TRole (_, r) -> r | _ -> "Global" in
                  if global_role <> "Global" && global_role <> env1.current_role then raise (TypeError ("Cannot access global " ^ name ^ " from role " ^ env1.current_role));
                  if not (types_compatible t_var t_e) then raise (TypeError "Assignment type mismatch");
                  env1
              | None -> raise (TypeError ("Undefined variable in assignment: " ^ name))))
      | { item = EIndex (arr, i); _ } ->
          let t_arr, env_arr = check_expr env arr None in
          let t_i, env_i = check_expr env_arr i None in
          if not (is_int_type t_i) then raise (TypeError "Array index must be an integer");
          let base_arr_t = match t_arr.item with | TRole (inner, _) -> inner | _ -> t_arr in
          (match base_arr_t.item with
          | TArray t_elem ->
              let t_e, env_final = check_expr env_i e (Some t_elem) in
              if not (types_compatible t_elem t_e) then raise (TypeError "Array assignment type mismatch");
              let env_res = match arr.item with
                | EVar name ->
                    (match StringMap.find_opt name env_final.vars with
                    | Some (_, is_mut, _, _sp, _used_ref) ->
                        if not is_mut then raise (TypeError ("Cannot mutate immutable array: " ^ name));
                        { env_final with vars = StringMap.add name (t_arr, true, Live, stmt.span, ref false) env_final.vars }
                    | None -> env_final)
                | _ -> env_final
              in
              env_res
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
      let t_e, env1 = check_expr env e None in
      let elem_t = match unwrap_role t_e with
        | { item = TArray inner; _ } -> inner
        | _ -> { item = TBase TU8; span = dummy_span } (* fallback for non-array iterables *)
      in
      let env_for = { env1 with vars = StringMap.add id (elem_t, false, Live, e.span, ref false) env1.vars } in
      let env2, _ = check_block env_for b in
      env2
  | SReturn e_opt ->
      let env1 = match e_opt, env.ret_typ with
      | Some e, Some expected_t ->
          let t_e, env_next = check_expr env e (Some expected_t) in
          let expected_t = add_role_if_missing expected_t env.current_role in
          if not (types_compatible expected_t t_e) then raise (Diagnostic.LocatedError (
              Diagnostic.make_error
                ~code:Error_codes.return_type_mismatch
                ~label:(Printf.sprintf "expected `%s`, found `%s`" (Ast.fmt_typ expected_t) (Ast.fmt_typ t_e))
                "return type mismatch"
                e.span));
          env_next
      | None, None -> env
      | Some _, None -> raise (TypeError "Cannot return a value from a unit function")
      | None, Some _ -> raise (TypeError "Function must return a value")
      in
      StringMap.iter (fun name (t, _, state, _, _) ->
        match t.item with
        | TRole _ when state = Live && not (is_copy_type t) -> 
            raise (TypeError ("Cannot return early with unconsumed linear resource: " ^ name))
        | _ -> ()
      ) env1.vars;
      env1
  | SDrop x ->
      if not (StringMap.mem x env.vars) then raise (TypeError ("Cannot drop undefined variable: " ^ x));
      env

and check_block env block =
  let env_final = List.fold_left check_stmt env block.stmts in
  StringMap.iter (fun name v2 ->
    let is_new = match StringMap.find_opt name env.vars with
      | Some v1 -> v1 != v2
      | None -> true
    in
    if is_new then
      let (_, _, _, span, used_ref) = v2 in
      if not !used_ref && not (String.starts_with ~prefix:"_" name) && name <> "iota" then
        Diagnostic.emit (Diagnostic.make_warning
          ~code:"W001"
          ~label:(Printf.sprintf "variable `%s` is never used" name)
          ~hints:[Printf.sprintf "if this is intentional, prefix it with an underscore: `_%s`" name]
          (Printf.sprintf "unused variable `%s`" name)
          span)
  ) env_final.vars;
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
    StringMap.add p.name (p_typ_with_role, false, Live, dummy_span, ref false) acc
  ) StringMap.empty fn.params in
  let local_env = { env with vars = initial_vars; ret_typ = fn.ret_typ; current_role = role_str } in
  (match fn.body with
   | Some b -> 
       let env_final, block_ret_opt = check_block local_env b in
       (match block_ret_opt, fn.ret_typ with
        | Some t_e, Some expected_t ->
            let expected_t_role = add_role_if_missing expected_t role_str in
            if not (types_compatible expected_t_role t_e) then
              let span = match b.ret_expr with Some e -> e.span | None -> dummy_span in
              raise (Diagnostic.LocatedError (
                Diagnostic.make_error
                  ~code:Error_codes.return_type_mismatch
                  ~label:(Printf.sprintf "expected `%s`, found `%s`" (Ast.fmt_typ expected_t_role) (Ast.fmt_typ t_e))
                  "implicit return type mismatch"
                  span))
        | Some t_e, None ->
            let span = match b.ret_expr with Some e -> e.span | None -> dummy_span in
            raise (Diagnostic.LocatedError (
              Diagnostic.make_error
                ~code:Error_codes.return_type_mismatch
                ~label:(Printf.sprintf "expected unit, found `%s`" (Ast.fmt_typ t_e))
                "cannot return a value from a unit function"
                span))
        | None, Some expected_t ->
            raise (Diagnostic.LocatedError (
              Diagnostic.make_error
                ~code:Error_codes.return_type_mismatch
                ~label:(Printf.sprintf "expected `%s`, found unit" (Ast.fmt_typ expected_t))
                "function must return a value"
                expected_t.span))
        | None, None -> ());
       StringMap.iter (fun name _ ->
         match StringMap.find_opt name env_final.vars with
         | Some (t, _, state, _, used_ref) ->
             (match t.item with
              | TRole _ when state = Live && not (is_copy_type t) -> 
                  raise (TypeError ("Function " ^ fn.name ^ " ends with unconsumed linear resource: " ^ name))
              | _ ->
                  if not !used_ref && not (String.starts_with ~prefix:"_" name) then
                    Diagnostic.emit (Diagnostic.make_warning
                      ~code:"W001"
                      ~label:(Printf.sprintf "parameter `%s` is never used" name)
                      ~hints:[Printf.sprintf "if this is intentional, prefix it with an underscore: `_%s`" name]
                      (Printf.sprintf "unused parameter `%s`" name)
                      dummy_span))
         | None -> ()
       ) initial_vars
   | None -> if not fn.is_extern then raise (TypeError ("Function " ^ fn.name ^ " must have a body")));
  { env with funcs = StringMap.add fn.name fn env.funcs }

let rec eval_const (env_iota: Int64.t option) (e: Ast.expr) : Int64.t =
  match e.item with
  | ELit (LInt (v, _)) -> v
  | EVar "iota" | EPathVar ["iota"] -> 
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
  match item.item with
  | IFn f -> check_fn_decl env f
  | IEnum e ->
      let iota_env = { env with vars = StringMap.add "iota" ({ item = TRole ({ item = TBase TU64; span = dummy_span }, "Global"); span = dummy_span }, false, Live, dummy_span, ref true) env.vars } in
      let _, _ = check_expr iota_env e.iota_expr (Some { item = TBase TU64; span = dummy_span }) in
      let current_iota = ref 0L in
      List.iter (fun (m: Ast.enum_member) ->
        let computed = match m.override with
        | Some (IotaOverride, exp_val) ->
            let _, _ = check_expr iota_env exp_val (Some { item = TBase TU64; span = dummy_span }) in
            current_iota := eval_const (Some !current_iota) exp_val;
            eval_const (Some !current_iota) e.iota_expr
        | Some (ValueOverride, exp_val) ->
            let _, _ = check_expr iota_env exp_val (Some { item = TBase e.base_typ; span = dummy_span }) in
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
      let name = match i.item with
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
        match e.item with
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
        let mangled_name = i.trait_name ^ "_" ^ (Ast.fmt_typ i.for_typ |> String.map (function ' ' | '(' | ')' -> '_' | c -> c)) ^ "_" ^ m.name in
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
      let prog = try Parser.parse_program Lexer.read lexbuf with
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
    let e1 = { e with imports = StringMap.add prefix (imp.path, imp.span, ref false) e.imports } in
    match imp.path with
    | "bundle" :: rest ->
        let mod_name = List.hd rest in
        if StringMap.mem mod_name e1.modules then e1 else (
          let mod_path = Filename.concat e1.project_root (mod_name ^ ".wyz") in
          if Sys.file_exists mod_path then
            let inx = open_in mod_path in
            let lexbuf = Lexing.from_channel inx in
            lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = mod_path };
            let parsed_prog = try Parser.parse_program Lexer.read lexbuf with
              | _ -> close_in inx; raise (TypeError ("Failed to parse imported module " ^ mod_name))
            in
            close_in inx;
            let mod_env = check_program_inner { empty_env with project_root = e1.project_root } parsed_prog in
            { e1 with modules = StringMap.add mod_name mod_env e1.modules }
          else e1
        )
    | _ -> e1
  ) env prog.Ast.imports in
  let env_final = 
    try List.fold_left check_item env_with_imports prog.items
    with e -> 
      StringMap.iter (fun prefix (_path, span, used_ref) ->
        if not !used_ref then
          Diagnostic.emit (Diagnostic.make_warning
            ~code:"W002"
            ~label:(Printf.sprintf "import `%s` is never used" prefix)
            (Printf.sprintf "unused import `%s`" prefix)
            span)
      ) env_with_imports.imports;
      raise e
  in
  StringMap.iter (fun prefix (_path, span, used_ref) ->
    if not !used_ref then
      Diagnostic.emit (Diagnostic.make_warning
        ~code:"W002"
        ~label:(Printf.sprintf "import `%s` is never used" prefix)
        (Printf.sprintf "unused import `%s`" prefix)
        span)
  ) env_final.imports;
  env_final

let check_program project_root prog =
  check_program_inner { empty_env with project_root = project_root } prog
