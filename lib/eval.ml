open Ast
module StringMap = Map.Make(String)

type value =
  | VInt of int64
  | VBool of bool
  | VStr of string
  | VUnit
  | VPtr of int
  | VArray of value array
  | VFormatStr of string * (value * string) list
[@@deriving show]

type heap_val =
  | HStruct of string * (string * value) list
  | HEnum of string * string * value list
  | HOk of value
  | HErr of value

type heap_entry = {
  ref_count: int ref;
  mutable data: heap_val;
}

module IntMap = Map.Make(Int)
let heap : heap_entry IntMap.t ref = ref IntMap.empty
let next_ptr = ref 1

let rec print_val oc is_nl arg =
  (match arg with
  | VInt i -> if is_nl then Printf.fprintf oc "%Ld\n" i else Printf.fprintf oc "%Ld" i
  | VBool b -> if is_nl then Printf.fprintf oc "%b\n" b else Printf.fprintf oc "%b" b
  | VStr s -> if is_nl then Printf.fprintf oc "%s\n" s else Printf.fprintf oc "%s" s
  | VUnit -> if is_nl then Printf.fprintf oc "()\n" else Printf.fprintf oc "()"
  | VPtr ptr -> 
       let entry = IntMap.find ptr !heap in
       (match entry.data with
       | HOk _ -> if is_nl then Printf.fprintf oc "Ok(...)\n" else Printf.fprintf oc "Ok(...)"
       | HErr _ -> if is_nl then Printf.fprintf oc "Err(...)\n" else Printf.fprintf oc "Err(...)"
       | HStruct _ -> if is_nl then Printf.fprintf oc "struct{...}\n" else Printf.fprintf oc "struct{...}"
       | HEnum (_, v_name, _) -> if is_nl then Printf.fprintf oc "%s(...)\n" v_name else Printf.fprintf oc "%s(...)" v_name)
  | VArray _ -> if is_nl then Printf.fprintf oc "[...]\n" else Printf.fprintf oc "[...]"
  | VFormatStr (s, pieces) ->
      Printf.fprintf oc "%s" s;
      List.iter (fun (v, next_s) ->
        print_val oc false v;
        Printf.fprintf oc "%s" next_s
      ) pieces;
      if is_nl then Printf.fprintf oc "\n"
  );
  flush oc

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
  current_role: string;
  modules: env StringMap.t;
  project_root: string;
}

let ipc_send_counter = ref 0
let ipc_recv_counter = ref 0

let empty_env = {
  vars = StringMap.empty;
  globals = StringMap.empty;
  funcs = StringMap.empty;
  enums = StringMap.empty;
  imports = StringMap.empty;
  current_role = "Poly";
  modules = StringMap.empty;
  project_root = Sys.getcwd ();
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
        let arg_vals = List.map (eval_expr env) args in
        let ptr = alloc_heap (HEnum (enum_name, variant_name, arg_vals)) in
        VPtr ptr
      ) else
      let resolved_path =
        match StringMap.find_opt prefix env.imports with
        | Some actual_module -> actual_module @ (List.tl path)
        | None -> path (* Assume it's an absolute path to a root library *)
      in
      let rec resolve_module current_env p =
        match p with
        | [] -> current_env
        | "bundle" :: rest -> resolve_module current_env rest
        | mod_name :: rest ->
            match StringMap.find_opt mod_name current_env.modules with
            | Some sub_env -> resolve_module sub_env rest
            | None -> raise (EvalError ("Module not found at runtime: " ^ mod_name))
      in
      if List.length resolved_path > 0 && List.hd resolved_path = "std" then (
        if resolved_path = ["std"; "io"; "println"] || resolved_path = ["std"; "io"; "print"] then (
          let is_nl = resolved_path = ["std"; "io"; "println"] in
          let arg = eval_expr env (List.hd args) in
          print_val stdout is_nl arg;
          VUnit
        ) else if resolved_path = ["std"; "io"; "eprintln"] || resolved_path = ["std"; "io"; "eprint"] then (
          let is_nl = resolved_path = ["std"; "io"; "eprintln"] in
          let arg = eval_expr env (List.hd args) in
          print_val stderr is_nl arg;
          VUnit
        ) else if resolved_path = ["std"; "hw"; "bind_interrupt"] then (
          let irq_val = eval_expr env (List.hd args) in
          let handler_name = match List.nth args 1 with
            | EVar name -> name
            | _ -> "unknown"
          in
          print_endline ("[Hardware] Bound IRQ " ^ show_value irq_val ^ " to " ^ handler_name);
          VUnit

        (* === std::conv — Type Conversions === *)
        ) else if resolved_path = ["std"; "conv"; "to_str"] then (
          let arg = eval_expr env (List.hd args) in
          let buf = Buffer.create 64 in
          let fmt = Format.formatter_of_buffer buf in
          (match arg with
           | VInt i -> Format.fprintf fmt "%Ld" i
           | VBool b -> Format.fprintf fmt "%b" b
           | VStr s -> Format.fprintf fmt "%s" s
           | VUnit -> Format.fprintf fmt "()"
           | VArray _ -> Format.fprintf fmt "[...]"
           | VPtr _ -> Format.fprintf fmt "<ptr>"
           | VFormatStr _ -> Format.fprintf fmt "<fstr>");
          Format.pp_print_flush fmt ();
          VStr (Buffer.contents buf)
        ) else if resolved_path = ["std"; "conv"; "parse_int"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VStr s ->
              (try
                let n = Int64.of_string (String.trim s) in
                let ptr = alloc_heap (HOk (VInt n)) in VPtr ptr
              with _ ->
                let ptr = alloc_heap (HErr (VStr ("Cannot parse '" ^ s ^ "' as integer"))) in VPtr ptr)
          | _ -> raise (EvalError "std::conv::parse_int expects a string")
        ) else if resolved_path = ["std"; "conv"; "parse_bool"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VStr s ->
              let trimmed = String.trim s in
              if trimmed = "true" then
                let ptr = alloc_heap (HOk (VBool true)) in VPtr ptr
              else if trimmed = "false" then
                let ptr = alloc_heap (HOk (VBool false)) in VPtr ptr
              else
                let ptr = alloc_heap (HErr (VStr ("Cannot parse '" ^ s ^ "' as bool"))) in VPtr ptr
          | _ -> raise (EvalError "std::conv::parse_bool expects a string")

        (* === std::str — String Operations === *)
        ) else if resolved_path = ["std"; "string"; "len"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VStr s -> VInt (Int64.of_int (String.length s))
          | _ -> raise (EvalError "std::string::len expects a string")
        ) else if resolved_path = ["std"; "string"; "concat"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VStr s1, VStr s2 -> VStr (s1 ^ s2)
          | _ -> raise (EvalError "std::string::concat expects two strings")
        ) else if resolved_path = ["std"; "string"; "contains"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VStr haystack, VStr needle ->
              let found = try let _ = Str.search_forward (Str.regexp_string needle) haystack 0 in true with Not_found -> false in
              VBool found
          | _ -> raise (EvalError "std::string::contains expects two strings")
        ) else if resolved_path = ["std"; "string"; "starts_with"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VStr s, VStr prefix ->
              let plen = String.length prefix in
              VBool (String.length s >= plen && String.sub s 0 plen = prefix)
          | _ -> raise (EvalError "std::string::starts_with expects two strings")
        ) else if resolved_path = ["std"; "string"; "ends_with"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VStr s, VStr suffix ->
              let slen = String.length s in
              let suflen = String.length suffix in
              VBool (slen >= suflen && String.sub s (slen - suflen) suflen = suffix)
          | _ -> raise (EvalError "std::string::ends_with expects two strings")
        ) else if resolved_path = ["std"; "string"; "to_upper"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VStr s -> VStr (String.uppercase_ascii s)
          | _ -> raise (EvalError "std::string::to_upper expects a string")
        ) else if resolved_path = ["std"; "string"; "to_lower"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VStr s -> VStr (String.lowercase_ascii s)
          | _ -> raise (EvalError "std::string::to_lower expects a string")
        ) else if resolved_path = ["std"; "string"; "trim"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VStr s -> VStr (String.trim s)
          | _ -> raise (EvalError "std::string::trim expects a string")
        ) else if resolved_path = ["std"; "string"; "replace"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          let c = eval_expr env (List.nth args 2) in
          match a, b, c with
          | VStr s, VStr from_s, VStr to_s ->
              VStr (Str.global_replace (Str.regexp_string from_s) to_s s)
          | _ -> raise (EvalError "std::string::replace expects three strings")
        ) else if resolved_path = ["std"; "string"; "substr"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          let c = eval_expr env (List.nth args 2) in
          match a, b, c with
          | VStr s, VInt start, VInt len ->
              let si = Int64.to_int start in
              let li = Int64.to_int len in
              let slen = String.length s in
              if si < 0 || si > slen then VStr ""
              else
                let actual_len = min li (slen - si) in
                VStr (String.sub s si actual_len)
          | _ -> raise (EvalError "std::string::substr expects (str, int, int)")
        ) else if resolved_path = ["std"; "string"; "char_at"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VStr s, VInt idx ->
              let i = Int64.to_int idx in
              if i < 0 || i >= String.length s then VStr ""
              else VStr (String.make 1 (String.get s i))
          | _ -> raise (EvalError "std::string::char_at expects (str, int)")
        ) else if resolved_path = ["std"; "string"; "split"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VStr s, VStr delim ->
              let parts = Str.split (Str.regexp_string delim) s in
              VArray (Array.of_list (List.map (fun p -> VStr p) parts))
          | _ -> raise (EvalError "std::string::split expects two strings")

        (* === std::math — Numeric Operations === *)
        ) else if resolved_path = ["std"; "math"; "abs"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VInt i -> VInt (Int64.abs i)
          | _ -> raise (EvalError "std::math::abs expects an integer")
        ) else if resolved_path = ["std"; "math"; "min"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VInt x, VInt y -> VInt (Int64.min x y)
          | _ -> raise (EvalError "std::math::min expects two integers")
        ) else if resolved_path = ["std"; "math"; "max"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VInt x, VInt y -> VInt (Int64.max x y)
          | _ -> raise (EvalError "std::math::max expects two integers")
        ) else if resolved_path = ["std"; "math"; "pow"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          match a, b with
          | VInt base_v, VInt exp_v ->
              let rec ipow b e acc =
                if Int64.compare e 0L <= 0 then acc
                else ipow b (Int64.sub e 1L) (Int64.mul acc b)
              in
              VInt (ipow base_v exp_v 1L)
          | _ -> raise (EvalError "std::math::pow expects two integers")
        ) else if resolved_path = ["std"; "math"; "sqrt"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VInt n ->
              let f = Int64.to_float n in
              VInt (Int64.of_float (Float.round (sqrt f)))
          | _ -> raise (EvalError "std::math::sqrt expects an integer")
        ) else if resolved_path = ["std"; "math"; "clamp"] then (
          let a = eval_expr env (List.hd args) in
          let b = eval_expr env (List.nth args 1) in
          let c = eval_expr env (List.nth args 2) in
          match a, b, c with
          | VInt v, VInt lo, VInt hi ->
              VInt (Int64.max lo (Int64.min hi v))
          | _ -> raise (EvalError "std::math::clamp expects three integers")

        (* === std::collections — Array/Collection Utilities === *)
        ) else if resolved_path = ["std"; "collections"; "len"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VArray arr -> VInt (Int64.of_int (Array.length arr))
          | _ -> raise (EvalError "std::collections::len expects an array")
        ) else if resolved_path = ["std"; "collections"; "push"] then (
          let arr_val = eval_expr env (List.hd args) in
          let elem_val = eval_expr env (List.nth args 1) in
          match arr_val with
          | VArray arr -> VArray (Array.append arr [| elem_val |])
          | _ -> raise (EvalError "std::collections::push expects an array as first argument")
        ) else if resolved_path = ["std"; "collections"; "pop"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VArray arr ->
              let len = Array.length arr in
              if len = 0 then VArray [||]
              else VArray (Array.sub arr 0 (len - 1))
          | _ -> raise (EvalError "std::collections::pop expects an array")
        ) else if resolved_path = ["std"; "collections"; "reverse"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VArray arr ->
              let copy = Array.copy arr in
              let len = Array.length copy in
              for i = 0 to (len / 2) - 1 do
                let tmp = copy.(i) in
                copy.(i) <- copy.(len - 1 - i);
                copy.(len - 1 - i) <- tmp
              done;
              VArray copy
          | _ -> raise (EvalError "std::collections::reverse expects an array")
        ) else if resolved_path = ["std"; "collections"; "contains"] then (
          let arr_val = eval_expr env (List.hd args) in
          let elem_val = eval_expr env (List.nth args 1) in
          match arr_val with
          | VArray arr -> VBool (Array.exists (fun v -> v = elem_val) arr)
          | _ -> raise (EvalError "std::collections::contains expects an array as first argument")

        (* === std::process — Process Control === *)
        ) else if resolved_path = ["std"; "process"; "exit"] then (
          let arg = eval_expr env (List.hd args) in
          match arg with
          | VInt code -> exit (Int64.to_int code)
          | _ -> raise (EvalError "std::process::exit expects an integer")
        ) else if resolved_path = ["std"; "process"; "args"] then (
          let argv = Array.to_list Sys.argv in
          VArray (Array.of_list (List.map (fun s -> VStr s) argv))

        ) else
          raise (EvalError ("Unknown std path call: " ^ String.concat "::" resolved_path))
      ) else (
        let module_path = List.rev (List.tl (List.rev resolved_path)) in
        let func_name = List.hd (List.rev resolved_path) in
        let target_env = resolve_module env module_path in
        match StringMap.find_opt func_name target_env.funcs with
        | Some fn ->
            let temp_name = String.concat "::" resolved_path in
            let env_with_fn = { env with funcs = StringMap.add temp_name fn env.funcs } in
            eval_expr env_with_fn (ECall (temp_name, args))
        | None -> raise (EvalError ("Function not found in module at runtime: " ^ func_name))
      )
  | EUnOp (Not, e) ->
      (match eval_expr env e with
      | VBool b -> VBool (not b)
      | _ -> raise (EvalError "Expected bool for Not"))
  | EUnOp (Neg, e) ->
      (match eval_expr env e with
      | VInt i -> VInt (Int64.neg i)
      | _ -> raise (EvalError "Expected int for Neg"))
  | EBinOp (e1, And, e2) ->
      let v1 = eval_expr env e1 in
      (match v1 with
      | VBool false -> VBool false
      | VBool true -> eval_expr env e2
      | _ -> raise (EvalError "Expected bool for And"))
  | EBinOp (e1, Or, e2) ->
      let v1 = eval_expr env e1 in
      (match v1 with
      | VBool true -> VBool true
      | VBool false -> eval_expr env e2
      | _ -> raise (EvalError "Expected bool for Or"))
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
          | Gte -> VBool (i1 >= i2)
          | And | Or -> raise (EvalError "Invalid operator on integers"))
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
              | PVariant (name, None), VStr s ->
                  let v_name = if String.contains name ':' then List.hd (List.rev (Str.split (Str.regexp_string "::") name)) else name in
                  (v_name = s), env
              | PVariant (name, None), VPtr ptr -> 
                  let v_name = if String.contains name ':' then List.hd (List.rev (Str.split (Str.regexp_string "::") name)) else name in
                  (match (IntMap.find ptr !heap).data with
                  | HOk _ when v_name = "Ok" -> true, env
                  | HErr _ when v_name = "Err" -> true, env
                  | HEnum (_, ev_name, _) when v_name = ev_name -> true, env
                  | _ -> false, env)
              | PVariant (name, Some pats), VPtr ptr -> 
                  let v_name = if String.contains name ':' then List.hd (List.rev (Str.split (Str.regexp_string "::") name)) else name in
                  (match (IntMap.find ptr !heap).data with
                  | HOk inner when v_name = "Ok" && List.length pats = 1 -> 
                      (match List.hd pats with
                      | PIdent id -> true, { env with vars = StringMap.add id (ref inner) env.vars }
                      | PWildcard -> true, env
                      | _ -> false, env)
                  | HErr inner when v_name = "Err" && List.length pats = 1 -> 
                      (match List.hd pats with
                      | PIdent id -> true, { env with vars = StringMap.add id (ref inner) env.vars }
                      | PWildcard -> true, env
                      | _ -> false, env)
                  | HEnum (_, ev_name, args) when v_name = ev_name && List.length pats = List.length args ->
                      let rec match_pats env_acc ps avs =
                        match ps, avs with
                        | [], [] -> true, env_acc
                        | (PIdent id) :: ps_rest, a :: avs_rest ->
                            match_pats { env_acc with vars = StringMap.add id (ref a) env_acc.vars } ps_rest avs_rest
                        | PWildcard :: ps_rest, _ :: avs_rest ->
                            match_pats env_acc ps_rest avs_rest
                        | _ -> false, env
                      in
                      match_pats env pats args
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
  | ECast (e, _) -> eval_expr env e
  | EGenericApp (_, e) -> eval_expr env e
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
  | EPathVar path ->
      let resolved_path =
        match StringMap.find_opt (List.hd path) env.imports with
        | Some mod_path -> mod_path @ List.tl path
        | None -> path
      in
      (match resolved_path with
      | [enum_name; variant_name] ->
          (match StringMap.find_opt enum_name env.enums with
          | Some _ -> VStr variant_name
          | None ->
              if resolved_path = ["std"; "io"; "stdin"] then VStr "stdin"
              else if resolved_path = ["std"; "io"; "stdout"] then VStr "stdout"
              else if resolved_path = ["std"; "io"; "stderr"] then VStr "stderr"
              else raise (EvalError "Unknown path variable"))
      | _ ->
          if resolved_path = ["std"; "io"; "stdin"] then VStr "stdin"
          else if resolved_path = ["std"; "io"; "stdout"] then VStr "stdout"
          else if resolved_path = ["std"; "io"; "stderr"] then VStr "stderr"
          else raise (EvalError "Unknown path variable"))
  | EFormatStr (s_ref, parsed_ref) ->
      let evaled_rest = List.map (fun (e_inner, lit) -> (eval_expr env e_inner, lit)) !parsed_ref in
      VFormatStr (!s_ref, evaled_rest)
  | ETyped (e, _) -> eval_expr env e
  | ENetSend (dest_role, e) ->
      let v = eval_expr env e in
      let my_role = env.current_role in
      let msg_id = !ipc_send_counter in
      ipc_send_counter := !ipc_send_counter + 1;
      let fn = Printf.sprintf "/tmp/wyzer_ipc_%s_%s_%d" my_role dest_role msg_id in
      let oc = open_out fn in
      Marshal.to_channel oc v [];
      close_out oc;
      Printf.printf "[IPC] %s sent msg_%d to %s\n%!" my_role msg_id dest_role;
      v
  | ENetRecv source_role ->
      let my_role = env.current_role in
      let msg_id = !ipc_recv_counter in
      ipc_recv_counter := !ipc_recv_counter + 1;
      let fn = Printf.sprintf "/tmp/wyzer_ipc_%s_%s_%d" source_role my_role msg_id in
      Printf.printf "[IPC] %s waiting for msg_%d from %s...\n%!" my_role msg_id source_role;
      let rec wait () =
        if Sys.file_exists fn then (
           let ic = open_in fn in
           let v = Marshal.from_channel ic in
           close_in ic;
           Sys.remove fn;
           Printf.printf "[IPC] %s received msg_%d from %s\n%!" my_role msg_id source_role;
           v
        ) else (
           Unix.sleepf 0.1;
           wait ()
        )
      in
      wait ()
  | EMethodCall (obj, _method_name, args, resolved_name_ref) ->
      (match !resolved_name_ref with
       | Some mangled_name -> eval_expr env (ECall (mangled_name, obj :: args))
       | None -> raise (EvalError "EMethodCall not desugared"))
  | ESizeOf _ | ETypeOf _ | EComptime _ -> raise (EvalError "sizeof/typeof/comptime should have been evaluated at compile-time")

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

let rec build_env env prog =
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
              | _ -> close_in inx; raise (EvalError ("Failed to parse imported module " ^ mod_name))
            in
            close_in inx;
            let mod_env = build_env { empty_env with project_root = e1.project_root } parsed_prog in
            { e1 with modules = StringMap.add mod_name mod_env e1.modules }
          else e1
        )
    | _ -> e1
  ) env prog.Ast.imports in
  let rec eval_item e item =
    match item with
    | IFn f -> { e with funcs = StringMap.add f.name f e.funcs }
    | IEnum en -> { e with enums = StringMap.add en.name en e.enums }
    | IStruct _ -> e
    | IGlobal { name; init; _ } ->
        let v = eval_expr e init in
        { e with globals = StringMap.add name (ref v) e.globals }
    | IGeneric (_, i) -> eval_item e i
    | IRole _ -> e
    | ITrait _ -> e
    | IImpl i ->
        List.fold_left (fun acc (m: fn_decl) ->
          let mangled_name = i.trait_name ^ "_" ^ (Ast.show_typ i.for_typ |> String.map (function ' ' | '(' | ')' -> '_' | c -> c)) ^ "_" ^ m.name in
          let mangled_m = { m with name = mangled_name } in
          { acc with funcs = StringMap.add mangled_name mangled_m acc.funcs }
        ) e i.methods
    | IMod m ->
        let mod_path = Filename.concat e.project_root (m.name ^ ".wyz") in
        if not (Sys.file_exists mod_path) then
          raise (EvalError ("Module file not found: " ^ mod_path));
        let inx = open_in mod_path in
        let lexbuf = Lexing.from_channel inx in
        lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = mod_path };
        let parsed_prog = try Parser.program Lexer.read lexbuf with
          | _ -> close_in inx; raise (EvalError ("Failed to parse module " ^ m.name))
        in
        close_in inx;
        let mod_env = build_env { empty_env with project_root = e.project_root } parsed_prog in
        { e with modules = StringMap.add m.name mod_env e.modules }
  in
  List.fold_left eval_item env_with_imports prog.Ast.items

let eval_program project_root prog role =
  let env = build_env { empty_env with project_root = project_root } prog in
  let env = { env with current_role = role } in
  match StringMap.find_opt "main" env.funcs with
  | Some main_fn ->
      (try ignore (eval_block env (Option.get main_fn.body)) with Return _ -> ())
  | None ->
      Printf.printf "Warning: no main function found\n"
