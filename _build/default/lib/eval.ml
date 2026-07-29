open Ast
module StringMap = Map.Make(String)

type value =
  | VInt of int64
  | VBool of bool
  | VStr of string
  | VUnit
  | VPtr of int
  | VArray of value array
[@@deriving show]

type heap_val =
  | HStruct of string * (string * value) list
  | HOk of value
  | HErr of value

type heap_entry = {
  ref_count: int ref;
  mutable data: heap_val;
}

module IntMap = Map.Make(Int)
let heap : heap_entry IntMap.t ref = ref IntMap.empty
let next_ptr = ref 1

let alloc_heap (v: heap_val) =
  let ptr = !next_ptr in
  next_ptr := ptr + 1;
  heap := IntMap.add ptr { ref_count = ref 1; data = v } !heap;
  Printf.printf "[Perceus] Allocated at 0x%X\n" ptr;
  ptr

type env = {
  vars: (value ref) StringMap.t;
  globals: (value ref) StringMap.t;
  funcs: fn_decl StringMap.t;
  enums: enum_decl StringMap.t;
  imports: string list StringMap.t;
}

let empty_env = {
  vars = StringMap.empty;
  globals = StringMap.empty;
  funcs = StringMap.empty;
  enums = StringMap.empty;
  imports = StringMap.empty;
}

exception EvalError of string
exception Return of value

let rec eval_expr env e =
  match e with
  | ELit (LInt (v, _)) -> VInt v
  | ELit (LBool v) -> VBool v
  | ELit (LStr v) -> VStr v
  | EVar name ->
      (match StringMap.find_opt name env.vars with
      | Some v_ref -> !v_ref
      | None ->
          (match StringMap.find_opt name env.globals with
          | Some v_ref -> !v_ref
          | None -> raise (EvalError ("Undefined variable at runtime: " ^ name))))
  | ECall (name, args) ->
      let fn = StringMap.find name env.funcs in
      let evaled_args = List.map (eval_expr env) args in
      let new_vars = List.fold_left2 (fun acc (p: Ast.param) v ->
        StringMap.add p.name (ref v) acc
      ) StringMap.empty fn.Ast.params evaled_args in
      let local_env = { env with vars = new_vars } in
      if fn.is_extern then (
        if fn.name = "puts" then (
          (match List.hd evaled_args with
          | VStr s -> print_endline s
          | _ -> raise (EvalError "puts expects a string"));
          VInt 0L
        ) else if fn.name = "read_file" then (
          (match List.hd evaled_args with
          | VStr path ->
              let ch = open_in path in
              let s = really_input_string ch (in_channel_length ch) in
              close_in ch;
              VStr s
          | _ -> raise (EvalError "read_file expects a string"))
        ) else if fn.name = "write_file" then (
          (match evaled_args with
          | [VStr path; VStr content] ->
              let ch = open_out path in
              output_string ch content;
              close_out ch;
              VInt 0L
          | _ -> raise (EvalError "write_file expects two strings"))
        ) else raise (EvalError ("Unknown external function: " ^ fn.name))
      ) else
      (try
        let _, ret_val = eval_block local_env (Option.get fn.body) in
        Option.value ret_val ~default:VUnit
      with Return v -> v)
  | EPathCall (path, args) ->
      let prefix = List.hd path in
      if StringMap.mem prefix env.enums then (
        let enum_name = prefix in
        let variant_name = List.nth path 1 in
        let enum_decl = StringMap.find enum_name env.enums in
        let member = List.find (fun (m: Ast.enum_member) -> m.name = variant_name) enum_decl.members in
        match !(member.computed_val) with
        | Some v -> VInt v
        | None -> raise (EvalError ("Enum variant " ^ variant_name ^ " was not computed at compile-time"))
      ) else
      let resolved_path =
        match StringMap.find_opt prefix env.imports with
        | Some actual_module -> actual_module @ (List.tl path)
        | None -> path (* Assume it's an absolute path to a root library *)
      in
      if resolved_path = ["std"; "io"; "println"] || resolved_path = ["std"; "io"; "print"] then (
        let is_nl = resolved_path = ["std"; "io"; "println"] in
        let arg = eval_expr env (List.hd args) in
        (match arg with
        | VInt i -> if is_nl then Printf.printf "%Ld\n" i else Printf.printf "%Ld" i
        | VBool b -> if is_nl then Printf.printf "%b\n" b else Printf.printf "%b" b
        | VStr s -> if is_nl then Printf.printf "%s\n" s else Printf.printf "%s" s
        | VUnit -> if is_nl then Printf.printf "()\n" else Printf.printf "()"
        | VPtr ptr -> 
             let entry = IntMap.find ptr !heap in
             (match entry.data with
             | HOk _ -> if is_nl then Printf.printf "Ok(...)\n" else Printf.printf "Ok(...)"
             | HErr _ -> if is_nl then Printf.printf "Err(...)\n" else Printf.printf "Err(...)"
             | HStruct _ -> if is_nl then Printf.printf "struct{...}\n" else Printf.printf "struct{...}")
        | VArray _ -> if is_nl then Printf.printf "[...]\n" else Printf.printf "[...]"
        );
        VUnit
      ) else if resolved_path = ["std"; "hw"; "bind_interrupt"] then (
        let irq_val = eval_expr env (List.hd args) in
        let handler_name = match List.nth args 1 with
          | EVar name -> name
          | _ -> "unknown"
        in
        print_endline ("[Hardware] Bound IRQ " ^ show_value irq_val ^ " to " ^ handler_name);
        VUnit
      ) else
        raise (EvalError "Unknown path call")
  | EBinOp (e1, op, e2) ->
      let v1 = eval_expr env e1 in
      let v2 = eval_expr env e2 in
      (match v1, v2 with
      | VInt i1, VInt i2 ->
          (match op with
          | Add -> VInt (Int64.add i1 i2)
          | Sub -> VInt (Int64.sub i1 i2)
          | Mul -> VInt (Int64.mul i1 i2)
          | Div -> VInt (Int64.div i1 i2)
          | Shl -> VInt (Int64.shift_left i1 (Int64.to_int i2))
          | Shr -> VInt (Int64.shift_right i1 (Int64.to_int i2))
          | BitAnd -> VInt (Int64.logand i1 i2)
          | BitOr -> VInt (Int64.logor i1 i2)
          | Eq -> VBool (i1 = i2)
          | Neq -> VBool (i1 <> i2)
          | Lt -> VBool (i1 < i2)
          | Gt -> VBool (i1 > i2)
          | Lte -> VBool (i1 <= i2)
          | Gte -> VBool (i1 >= i2))
      | VBool b1, VBool b2 ->
          (match op with
          | Eq -> VBool (b1 = b2)
          | Neq -> VBool (b1 <> b2)
          | _ -> raise (EvalError "Invalid operator on booleans"))
      | VStr s1, VStr s2 ->
          (match op with
          | Eq -> VBool (s1 = s2)
          | Neq -> VBool (s1 <> s2)
          | _ -> raise (EvalError "Invalid operator on strings"))
      | _ -> raise (EvalError "Type mismatch in evaluation"))
  | EIf (cond, thn, els) ->
      (match eval_expr env cond with
      | VBool true ->
          let _, ret = eval_block env thn in
          Option.value ret ~default:VUnit
      | VBool false ->
          (match els with
          | Some e_block ->
              let _, ret = eval_block env e_block in
              Option.value ret ~default:VUnit
          | None -> VUnit)
      | _ -> raise (EvalError "If condition not a boolean"))
  | EOk (e, reuse) -> 
      let hval = HOk (eval_expr env e) in
      (match reuse with
      | Some r_var ->
          let v_ref = StringMap.find r_var env.vars in
          (match !v_ref with
          | VPtr ptr ->
              let entry = IntMap.find ptr !heap in
              if !(entry.ref_count) = 1 then (
                 Printf.printf "[Perceus] Reused 0x%X in-place for Ok!\n" ptr;
                 entry.data <- hval;
                 VPtr ptr
              ) else VPtr (alloc_heap hval)
          | _ -> VPtr (alloc_heap hval))
      | None -> VPtr (alloc_heap hval))
  | EErr (e, reuse) -> 
      let hval = HErr (eval_expr env e) in
      (match reuse with
      | Some r_var ->
          let v_ref = StringMap.find r_var env.vars in
          (match !v_ref with
          | VPtr ptr ->
              let entry = IntMap.find ptr !heap in
              if !(entry.ref_count) = 1 then (
                 Printf.printf "[Perceus] Reused 0x%X in-place for Err!\n" ptr;
                 entry.data <- hval;
                 VPtr ptr
              ) else VPtr (alloc_heap hval)
          | _ -> VPtr (alloc_heap hval))
      | None -> VPtr (alloc_heap hval))
  | EStruct (name, fields, reuse) ->
      let evaluated_fields = List.map (fun (f_name, e) -> (f_name, eval_expr env e)) fields in
      let hval = HStruct (name, evaluated_fields) in
      (match reuse with
      | Some r_var ->
          let v_ref = StringMap.find r_var env.vars in
          (match !v_ref with
          | VPtr ptr ->
              let entry = IntMap.find ptr !heap in
              if !(entry.ref_count) = 1 then (
                 Printf.printf "[Perceus] Reused 0x%X in-place for struct %s!\n" ptr name;
                 entry.data <- hval;
                 VPtr ptr
              ) else VPtr (alloc_heap hval)
          | _ -> VPtr (alloc_heap hval))
      | None -> VPtr (alloc_heap hval))
  | EField (e, field_name) ->
      let v = eval_expr env e in
      (match v with
      | VPtr ptr ->
          (match (IntMap.find ptr !heap).data with
          | HStruct (_, fields) ->
              (match List.assoc_opt field_name fields with
              | Some f_val -> f_val
              | None -> raise (EvalError ("Field " ^ field_name ^ " not found")))
          | _ -> raise (EvalError "Field access on non-struct"))
      | _ -> raise (EvalError "Field access on non-pointer"))
  | EMatch (e, arms) ->
      let v = eval_expr env e in
      let rec try_match arms =
        match arms with
        | [] -> raise (EvalError "Non-exhaustive match")
        | (pat, e_arm) :: rest ->
            let matches, env_ext = match pat, v with
              | PWildcard, _ -> true, env
              | PIdent id, _ -> true, { env with vars = StringMap.add id (ref v) env.vars }
              | PVariant (name, None), VPtr ptr -> 
                  (match (IntMap.find ptr !heap).data with
                  | HOk _ when name = "Ok" -> true, env
                  | HErr _ when name = "Err" -> true, env
                  | _ -> false, env)
              | PVariant (name, Some [p]), VPtr ptr -> 
                  (match (IntMap.find ptr !heap).data with
                  | HOk inner when name = "Ok" -> 
                      (match p with
                      | PIdent id -> true, { env with vars = StringMap.add id (ref inner) env.vars }
                      | PWildcard -> true, env
                      | _ -> false, env)
                  | HErr inner when name = "Err" -> 
                      (match p with
                      | PIdent id -> true, { env with vars = StringMap.add id (ref inner) env.vars }
                      | PWildcard -> true, env
                      | _ -> false, env)
                  | _ -> false, env)
              | _ -> false, env
            in
            if matches then eval_expr env_ext e_arm else try_match rest
      in
      try_match arms
  | EDup (_, e) -> 
      let v = eval_expr env e in
      (match v with
      | VPtr ptr ->
          (match IntMap.find_opt ptr !heap with
          | Some entry -> 
              entry.ref_count := !(entry.ref_count) + 1;
              Printf.printf "[Perceus] Dup 0x%X (refcount = %d)\n" ptr !(entry.ref_count);
          | None -> raise (EvalError "Dup on freed pointer"))
      | _ -> ());
      v
  | ECast (e, typ) ->
      let v = eval_expr env e in
      (match v, typ with
      | VInt i, TBase TU8 -> VInt (Int64.logand i 0xFFL)
      | VInt i, TBase TI8 -> 
          let m = Int64.logand i 0xFFL in
          if Int64.compare m 0x7FL > 0 then VInt (Int64.sub m 0x100L) else VInt m
      | VInt i, TBase TU16 -> VInt (Int64.logand i 0xFFFFL)
      | VInt i, TBase TI16 ->
          let m = Int64.logand i 0xFFFFL in
          if Int64.compare m 0x7FFFL > 0 then VInt (Int64.sub m 0x10000L) else VInt m
      | VInt i, TBase TU32 -> VInt (Int64.logand i 0xFFFFFFFFL)
      | VInt i, TBase TI32 ->
          let m = Int64.logand i 0xFFFFFFFFL in
          if Int64.compare m 0x7FFFFFFFL > 0 then VInt (Int64.sub m 0x100000000L) else VInt m
      | VInt i, _ -> VInt i
      | _ -> v)
  | EArray elems ->
      let evaled_elems = List.map (eval_expr env) elems in
      VArray (Array.of_list evaled_elems)
  | EIndex (e, i) ->
      let v_arr = eval_expr env e in
      let v_idx = eval_expr env i in
      (match v_arr, v_idx with
      | VArray arr, VInt idx ->
          let i_int = Int64.to_int idx in
          if i_int < 0 || i_int >= Array.length arr then raise (EvalError "Array index out of bounds");
          arr.(i_int)
      | _ -> raise (EvalError "Invalid array indexing"))
  | ETransfer (e, _) -> eval_expr env e

and eval_stmt env stmt =
  match stmt with
  | SDecl { kind = _; name; typ = _; init } ->
      let v = eval_expr env init in
      let v_ref = ref v in
      { env with vars = StringMap.add name v_ref env.vars }
  | SAssign (lhs, e) ->
      let v = eval_expr env e in
      (match lhs with
      | EVar name ->
          if StringMap.mem name env.vars then
            let v_ref = StringMap.find name env.vars in
            v_ref := v;
            env
          else if StringMap.mem name env.globals then
            let v_ref = StringMap.find name env.globals in
            v_ref := v;
            env
          else raise (EvalError ("Variable not found: " ^ name))
      | EIndex (arr, i) ->
          let v_arr = eval_expr env arr in
          let v_idx = eval_expr env i in
          (match v_arr, v_idx with
          | VArray arr_val, VInt idx ->
              let i_int = Int64.to_int idx in
              if i_int < 0 || i_int >= Array.length arr_val then raise (EvalError "Array index out of bounds");
              arr_val.(i_int) <- v;
              env
          | _ -> raise (EvalError "Invalid array index assignment"))
      | _ -> raise (EvalError "Invalid left-hand side assignment"))
  | SExpr e ->
      ignore (eval_expr env e);
      env
  | SWhile (cond, b) ->
      let rec loop () =
        match eval_expr env cond with
        | VBool true ->
            ignore (eval_block env b);
            loop ()
        | VBool false -> ()
        | _ -> raise (EvalError "while condition not a boolean")
      in
      loop ();
      env
  | SFor (id, e, b) ->
      let v = eval_expr env e in
      let env_for = { env with vars = StringMap.add id (ref v) env.vars } in
      ignore (eval_block env_for b);
      env
  | SDrop x ->
      (match StringMap.find_opt x env.vars with
      | Some v_ref ->
          (match !v_ref with
          | VPtr ptr ->
              (match IntMap.find_opt ptr !heap with
              | Some entry ->
                  entry.ref_count := !(entry.ref_count) - 1;
                  Printf.printf "[Perceus] Drop 0x%X (refcount = %d)\n" ptr !(entry.ref_count);
                  if !(entry.ref_count) = 0 then (
                    Printf.printf "[Perceus] Freed 0x%X\n" ptr;
                    heap := IntMap.remove ptr !heap
                  )
              | None -> ())
          | _ -> ())
      | None -> ());
      env
  | SReturn e_opt ->
      let ret_val = match e_opt with
        | Some e -> eval_expr env e
        | None -> VUnit
      in
      raise (Return ret_val)

and eval_block env block =
  let env_final = List.fold_left eval_stmt env block.stmts in
  let ret_val = Option.map (eval_expr env_final) block.ret_expr in
  env_final, ret_val

let eval_program prog =
  let env_with_imports = List.fold_left (fun e (imp : import_decl) ->
    let prefix = match imp.alias with
      | Some a -> a
      | None -> List.hd (List.rev imp.path)
    in
    { e with imports = StringMap.add prefix imp.path e.imports }
  ) empty_env prog.Ast.imports in
  let env = List.fold_left (fun e item ->
    match item with
    | IFn f -> { e with funcs = StringMap.add f.name f e.funcs }
    | IEnum en -> { e with enums = StringMap.add en.name en e.enums }
    | IStruct _ -> e
    | IGlobal { name; init; _ } ->
        let v = eval_expr e init in
        { e with globals = StringMap.add name (ref v) e.globals }
  ) env_with_imports prog.Ast.items in
  match StringMap.find_opt "main" env.funcs with
  | Some main_fn ->
      (try ignore (eval_block env (Option.get main_fn.body)) with Return _ -> ())
  | None ->
      Printf.printf "Warning: no main function found\n"
