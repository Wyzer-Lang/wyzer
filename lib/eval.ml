open Ast
module StringMap = Map.Make(String)

type value =
  | VInt of int64
  | VFloat of float
  | VBool of bool
  | VStr of string
  | VChar of char
  | VUnit
  | VPtr of int
  | VArray of value array
  | VTuple of value list
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

let split_string s delim =
  if delim = "" then List.init (String.length s) (fun i -> String.make 1 s.[i])
  else
    let len_d = String.length delim in
    let rec aux pos =
      if pos > String.length s then []
      else if pos = String.length s then [""]
      else
        let rec find_from p =
          if p + len_d > String.length s then None
          else if String.sub s p len_d = delim then Some p
          else find_from (p + 1)
        in
        match find_from pos with
        | Some idx -> String.sub s pos (idx - pos) :: aux (idx + len_d)
        | None -> [String.sub s pos (String.length s - pos)]
    in
    aux 0

let replace_string s from_str to_str =
  if from_str = "" then s
  else String.concat to_str (split_string s from_str)

let string_of_val arg =
  match arg with
  | VInt i -> Int64.to_string i
  | VFloat f -> if Float.is_integer f then Printf.sprintf "%.1f" f else Printf.sprintf "%g" f
  | VBool b -> string_of_bool b
  | VStr s -> s
  | VChar c -> String.make 1 c
  | VUnit -> "()"
  | VPtr ptr -> 
       let entry = IntMap.find ptr !heap in
       (match entry.data with
       | HOk _ -> "Ok(...)"
       | HErr _ -> "Err(...)"
       | HStruct _ -> "struct{...}"
       | HEnum (_, v_name, _) -> v_name ^ "(...)")
  | VArray _ -> "[...]"
  | VTuple _ -> "(...)"
  | _ -> "<unknown>"

let rec print_val oc is_nl arg =
  (match arg with
  | VInt i -> if is_nl then Printf.fprintf oc "%Ld\n" i else Printf.fprintf oc "%Ld" i
  | VFloat f ->
      let s = if Float.is_integer f then Printf.sprintf "%.1f" f else Printf.sprintf "%g" f in
      if is_nl then Printf.fprintf oc "%s\n" s else Printf.fprintf oc "%s" s
  | VBool b -> if is_nl then Printf.fprintf oc "%b\n" b else Printf.fprintf oc "%b" b
  | VStr s -> if is_nl then Printf.fprintf oc "%s\n" s else Printf.fprintf oc "%s" s
  | VChar c -> if is_nl then Printf.fprintf oc "%c\n" c else Printf.fprintf oc "%c" c
  | VUnit -> if is_nl then Printf.fprintf oc "()\n" else Printf.fprintf oc "()"
  | VPtr ptr -> 
       let entry = IntMap.find ptr !heap in
       (match entry.data with
       | HOk _ -> if is_nl then Printf.fprintf oc "Ok(...)\n" else Printf.fprintf oc "Ok(...)"
       | HErr _ -> if is_nl then Printf.fprintf oc "Err(...)\n" else Printf.fprintf oc "Err(...)"
       | HStruct _ -> if is_nl then Printf.fprintf oc "struct{...}\n" else Printf.fprintf oc "struct{...}"
       | HEnum (_, v_name, _) -> if is_nl then Printf.fprintf oc "%s(...)\n" v_name else Printf.fprintf oc "%s(...)" v_name)
  | VArray _ -> if is_nl then Printf.fprintf oc "[...]\n" else Printf.fprintf oc "[...]"
  | VTuple _ -> if is_nl then Printf.fprintf oc "(...)\n" else Printf.fprintf oc "(...)"
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

let rec match_pat p v current_env =
  match p.item, v with
  | PWildcard, _ -> true, current_env
  | PIdent id, _ -> true, { current_env with vars = StringMap.add id (ref v) current_env.vars }
  | PTuple pats, VTuple vals ->
      if List.length pats <> List.length vals then false, current_env
      else
        List.fold_left2 (fun (m_acc, env_acc) p_i v_i ->
          if not m_acc then false, env_acc
          else match_pat p_i v_i env_acc
        ) (true, current_env) pats vals
  | PLit (LInt (i, _)), VInt i_val -> (i = i_val), current_env
  | PLit (LBool b), VBool b_val -> (b = b_val), current_env
  | PLit (LStr s), VStr s_val -> (s = s_val), current_env
  | PLit (LChar c), VChar c_val -> (c = c_val), current_env
  | PVariant (name, None), VStr s -> (name = s), current_env
  | PVariant (name, None), VPtr ptr -> 
      (match (IntMap.find ptr !heap).data with
      | HOk _ when name = "Ok" -> true, current_env
      | HErr _ when name = "Err" -> true, current_env
      | _ -> false, current_env)
  | PVariant (name, Some [inner_p]), VPtr ptr -> 
      (match (IntMap.find ptr !heap).data with
      | HOk inner when name = "Ok" -> match_pat inner_p inner current_env
      | HErr inner when name = "Err" -> match_pat inner_p inner current_env
      | _ -> false, current_env)
  | _ -> false, current_env

let rec eval_expr env e =
  match e.item with
  | ELit (LInt (v, _)) -> VInt v
  | ELit (LFloat (v, _)) -> VFloat v
  | ELit (LBool v) -> VBool v
  | ELit (LStr v) -> VStr v
  | ELit (LChar c) -> VChar c
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
          if List.length args > 1 then (
            let fmt_str = match eval_expr env (List.hd args) with VStr s -> s | _ -> raise (EvalError "Expected string format") in
            let arg_vals = List.map (eval_expr env) (List.tl args) in
            let rec format_string s args acc =
              match args with
              | [] -> acc ^ s
              | arg :: rest ->
                  try
                    let idx = String.index s '{' in
                    if idx + 1 < String.length s && s.[idx+1] = '}' then
                      let before = String.sub s 0 idx in
                      let after = String.sub s (idx + 2) (String.length s - idx - 2) in
                      format_string after rest (acc ^ before ^ (string_of_val arg))
                    else
                      format_string (String.sub s (idx + 1) (String.length s - idx - 1)) args (acc ^ String.sub s 0 (idx + 1))
                  with Not_found -> acc ^ s
            in
            let formatted = format_string fmt_str arg_vals "" in
            if is_nl then print_endline formatted else print_string formatted;
            VUnit
          ) else (
            let arg = eval_expr env (List.hd args) in
            print_val stdout is_nl arg;
            VUnit
          )
        ) else if resolved_path = ["std"; "io"; "eprintln"] || resolved_path = ["std"; "io"; "eprint"] then (
          let is_nl = resolved_path = ["std"; "io"; "eprintln"] in
          if List.length args > 1 then (
            let fmt_str = match eval_expr env (List.hd args) with VStr s -> s | _ -> raise (EvalError "Expected string format") in
            let arg_vals = List.map (eval_expr env) (List.tl args) in
            let rec format_string s args acc =
              match args with
              | [] -> acc ^ s
              | arg :: rest ->
                  try
                    let idx = String.index s '{' in
                    if idx + 1 < String.length s && s.[idx+1] = '}' then
                      let before = String.sub s 0 idx in
                      let after = String.sub s (idx + 2) (String.length s - idx - 2) in
                      format_string after rest (acc ^ before ^ (string_of_val arg))
                    else
                      format_string (String.sub s (idx + 1) (String.length s - idx - 1)) args (acc ^ String.sub s 0 (idx + 1))
                  with Not_found -> acc ^ s
            in
            let formatted = format_string fmt_str arg_vals "" in
            if is_nl then prerr_endline formatted else prerr_string formatted;
            VUnit
          ) else (
            let arg = eval_expr env (List.hd args) in
            print_val stderr is_nl arg;
            VUnit
          )
        ) else if resolved_path = ["std"; "io"; "read_line"] then (
          try VStr (read_line ()) with End_of_file -> VStr ""
        ) else if resolved_path = ["std"; "fs"; "read_file"] then (
          let filename = match eval_expr env (List.hd args) with VStr s -> s | _ -> raise (EvalError "Expected string path") in
          try
            let ic = open_in_bin filename in
            let len = in_channel_length ic in
            let content = really_input_string ic len in
            close_in ic;
            VStr content
          with _ -> VStr ""
        ) else if resolved_path = ["std"; "fs"; "write_file"] then (
          let filename = match eval_expr env (List.hd args) with VStr s -> s | _ -> raise (EvalError "Expected string path") in
          let content = match eval_expr env (List.nth args 1) with VStr s -> s | _ -> raise (EvalError "Expected string content") in
          try
            let oc = open_out_bin filename in
            output_string oc content;
            close_out oc;
            VBool true
          with _ -> VBool false
        ) else if resolved_path = ["std"; "fs"; "file_exists"] then (
          let filename = match eval_expr env (List.hd args) with VStr s -> s | _ -> raise (EvalError "Expected string path") in
          VBool (Sys.file_exists filename)
        ) else if resolved_path = ["std"; "process"; "exit"] then (
          let code = match eval_expr env (List.hd args) with VInt i -> Int64.to_int i | _ -> 0 in
          exit code
        ) else if resolved_path = ["std"; "process"; "sleep"] then (
          let ms = match eval_expr env (List.hd args) with VInt i -> Int64.to_float i /. 1000.0 | _ -> 0.0 in
          Unix.sleepf ms;
          VUnit
        ) else if resolved_path = ["std"; "time"; "now_ms"] then (
          VInt (Int64.of_float (Unix.gettimeofday () *. 1000.0))
        ) else if resolved_path = ["std"; "process"; "args"] then (
          VArray (Array.map (fun s -> VStr s) Sys.argv)
        ) else if List.length resolved_path = 3 && List.nth resolved_path 0 = "std" && List.nth resolved_path 1 = "string" then (
          let fn_name = List.nth resolved_path 2 in
          match fn_name with
          | "len" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              VInt (Int64.of_int (String.length s))
          | "concat" ->
              let s1 = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              let s2 = match eval_expr env (List.nth args 1) with VStr s -> s | _ -> "" in
              VStr (s1 ^ s2)
          | "to_uppercase" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              VStr (String.uppercase_ascii s)
          | "to_lowercase" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              VStr (String.lowercase_ascii s)
          | "trim" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              VStr (String.trim s)
          | "replace" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              let from_s = match eval_expr env (List.nth args 1) with VStr s -> s | _ -> "" in
              let to_s = match eval_expr env (List.nth args 2) with VStr s -> s | _ -> "" in
              VStr (replace_string s from_s to_s)
          | "substring" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              let st = match eval_expr env (List.nth args 1) with VInt i -> Int64.to_int i | _ -> 0 in
              let len = match eval_expr env (List.nth args 2) with VInt i -> Int64.to_int i | _ -> 0 in
              let st = max 0 (min (String.length s) st) in
              let len = max 0 (min (String.length s - st) len) in
              VStr (String.sub s st len)
          | "char_at" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              let idx = match eval_expr env (List.nth args 1) with VInt i -> Int64.to_int i | _ -> 0 in
              if idx >= 0 && idx < String.length s then VStr (String.make 1 s.[idx])
              else VStr ""
          | "starts_with" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              let pref = match eval_expr env (List.nth args 1) with VStr s -> s | _ -> "" in
              VBool (String.starts_with ~prefix:pref s)
          | "ends_with" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              let suf = match eval_expr env (List.nth args 1) with VStr s -> s | _ -> "" in
              VBool (String.ends_with ~suffix:suf s)
          | "split" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              let delim = match eval_expr env (List.nth args 1) with VStr s -> s | _ -> "" in
              let parts = split_string s delim in
              VArray (Array.of_list (List.map (fun x -> VStr x) parts))
          | _ -> raise (EvalError ("Unknown string function: " ^ fn_name))
        ) else if List.length resolved_path = 3 && List.nth resolved_path 0 = "std" && List.nth resolved_path 1 = "conv" then (
          let fn_name = List.nth resolved_path 2 in
          match fn_name with
          | "parse_int" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              (try
                 let i = Int64.of_string (String.trim s) in
                 let ptr = !next_ptr in incr next_ptr;
                 heap := IntMap.add ptr { ref_count = ref 1; data = HOk (VInt i) } !heap;
                 VPtr ptr
               with _ ->
                 let ptr = !next_ptr in incr next_ptr;
                 heap := IntMap.add ptr { ref_count = ref 1; data = HErr (VStr "Invalid integer format") } !heap;
                 VPtr ptr)
          | "parse_bool" ->
              let s = match eval_expr env (List.hd args) with VStr s -> s | _ -> "" in
              (match String.lowercase_ascii (String.trim s) with
               | "true" | "1" ->
                   let ptr = !next_ptr in incr next_ptr;
                   heap := IntMap.add ptr { ref_count = ref 1; data = HOk (VBool true) } !heap;
                   VPtr ptr
               | "false" | "0" ->
                   let ptr = !next_ptr in incr next_ptr;
                   heap := IntMap.add ptr { ref_count = ref 1; data = HOk (VBool false) } !heap;
                   VPtr ptr
               | _ ->
                   let ptr = !next_ptr in incr next_ptr;
                   heap := IntMap.add ptr { ref_count = ref 1; data = HErr (VStr "Invalid boolean format") } !heap;
                   VPtr ptr)
          | "to_str" ->
              let v = eval_expr env (List.hd args) in
              VStr (show_value v)
          | _ -> raise (EvalError ("Unknown conv function: " ^ fn_name))
        ) else if List.length resolved_path = 3 && List.nth resolved_path 0 = "std" && List.nth resolved_path 1 = "collections" then (
          let fn_name = List.nth resolved_path 2 in
          match fn_name with
          | "len" ->
              let arr = match eval_expr env (List.hd args) with VArray a -> a | _ -> [||] in
              VInt (Int64.of_int (Array.length arr))
          | "push" ->
              let arr = match eval_expr env (List.hd args) with VArray a -> a | _ -> [||] in
              let elem = eval_expr env (List.nth args 1) in
              VArray (Array.append arr [| elem |])
          | "pop" ->
              let arr = match eval_expr env (List.hd args) with VArray a -> a | _ -> [||] in
              let len = Array.length arr in
              if len = 0 then VArray [||]
              else VArray (Array.sub arr 0 (len - 1))
          | "reverse" ->
              let arr = match eval_expr env (List.hd args) with VArray a -> a | _ -> [||] in
              let copy = Array.copy arr in
              let len = Array.length copy in
              for i = 0 to (len / 2) - 1 do
                let tmp = copy.(i) in
                copy.(i) <- copy.(len - 1 - i);
                copy.(len - 1 - i) <- tmp
              done;
              VArray copy
          | "contains" ->
              let arr = match eval_expr env (List.hd args) with VArray a -> a | _ -> [||] in
              let target = eval_expr env (List.nth args 1) in
              VBool (Array.exists (fun item -> item = target) arr)
          | _ -> raise (EvalError ("Unknown collections function: " ^ fn_name))
        ) else if List.length resolved_path = 3 && List.nth resolved_path 0 = "std" && List.nth resolved_path 1 = "math" then (
          let fn_name = List.nth resolved_path 2 in
          match fn_name with
          | "abs" ->
              let v = match eval_expr env (List.hd args) with VInt i -> Int64.abs i | _ -> 0L in
              VInt v
          | "min" ->
              let v1 = match eval_expr env (List.hd args) with VInt i -> i | _ -> 0L in
              let v2 = match eval_expr env (List.nth args 1) with VInt i -> i | _ -> 0L in
              VInt (Int64.min v1 v2)
          | "max" ->
              let v1 = match eval_expr env (List.hd args) with VInt i -> i | _ -> 0L in
              let v2 = match eval_expr env (List.nth args 1) with VInt i -> i | _ -> 0L in
              VInt (Int64.max v1 v2)
          | "clamp" ->
              let v = match eval_expr env (List.hd args) with VInt i -> i | _ -> 0L in
              let min_v = match eval_expr env (List.nth args 1) with VInt i -> i | _ -> 0L in
              let max_v = match eval_expr env (List.nth args 2) with VInt i -> i | _ -> 0L in
              VInt (Int64.max min_v (Int64.min max_v v))
          | "sin" ->
              let f = match eval_expr env (List.hd args) with VFloat f -> f | VInt i -> Int64.to_float i | _ -> 0.0 in
              VFloat (sin f)
          | "cos" ->
              let f = match eval_expr env (List.hd args) with VFloat f -> f | VInt i -> Int64.to_float i | _ -> 0.0 in
              VFloat (cos f)
          | "tan" ->
              let f = match eval_expr env (List.hd args) with VFloat f -> f | VInt i -> Int64.to_float i | _ -> 0.0 in
              VFloat (tan f)
          | "sqrt" ->
              let f = match eval_expr env (List.hd args) with VFloat f -> f | VInt i -> Int64.to_float i | _ -> 0.0 in
              VFloat (sqrt f)
          | "log" ->
              let f = match eval_expr env (List.hd args) with VFloat f -> f | VInt i -> Int64.to_float i | _ -> 0.0 in
              VFloat (log f)
          | "pow" ->
              let b = match eval_expr env (List.hd args) with VFloat f -> f | VInt i -> Int64.to_float i | _ -> 0.0 in
              let e = match eval_expr env (List.nth args 1) with VFloat f -> f | VInt i -> Int64.to_float i | _ -> 0.0 in
              VFloat (Float.pow b e)
          | _ -> raise (EvalError ("Unknown math function: " ^ fn_name))
        ) else if resolved_path = ["std"; "hw"; "bind_interrupt"] then (
          let irq_val = eval_expr env (List.hd args) in
          let handler_name = match List.nth args 1 with
            | { item = EVar name; _ } -> name
            | _ -> "unknown"
          in
          print_endline ("[Hardware] Bound IRQ " ^ show_value irq_val ^ " to " ^ handler_name);
          VUnit
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
            eval_expr env_with_fn ({ item = ECall (temp_name, args); span = dummy_span })
        | None -> raise (EvalError ("Function not found in module at runtime: " ^ func_name))
      )
  | EUnOp (Not, e) ->
      (match eval_expr env e with
      | VBool b -> VBool (not b)
      | _ -> raise (EvalError "Expected bool for Not"))
  | EUnOp (Neg, e) ->
      (match eval_expr env e with
      | VInt i -> VInt (Int64.neg i)
      | VFloat f -> VFloat (Float.neg f)
      | _ -> raise (EvalError "Expected int or float for Neg"))
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
      | VFloat f1, VFloat f2 ->
          (match op with
          | Add -> VFloat (f1 +. f2)
          | Sub -> VFloat (f1 -. f2)
          | Mul -> VFloat (f1 *. f2)
          | Div -> VFloat (f1 /. f2)
          | Eq -> VBool (f1 = f2)
          | Neq -> VBool (f1 <> f2)
          | Lt -> VBool (f1 < f2)
          | Gt -> VBool (f1 > f2)
          | Lte -> VBool (f1 <= f2)
          | Gte -> VBool (f1 >= f2)
          | _ -> raise (EvalError "Invalid operator on floats"))
      | VInt i, VFloat f -> (* coerce int to float for mixed expressions *)
          let f1 = Int64.to_float i in
          (match op with
          | Add -> VFloat (f1 +. f) | Sub -> VFloat (f1 -. f)
          | Mul -> VFloat (f1 *. f) | Div -> VFloat (f1 /. f)
          | Eq -> VBool (f1 = f) | Neq -> VBool (f1 <> f)
          | Lt -> VBool (f1 < f) | Gt -> VBool (f1 > f)
          | Lte -> VBool (f1 <= f) | Gte -> VBool (f1 >= f)
          | _ -> raise (EvalError "Invalid operator on int/float"))
      | VFloat f, VInt i ->
          let f2 = Int64.to_float i in
          (match op with
          | Add -> VFloat (f +. f2) | Sub -> VFloat (f -. f2)
          | Mul -> VFloat (f *. f2) | Div -> VFloat (f /. f2)
          | Eq -> VBool (f = f2) | Neq -> VBool (f <> f2)
          | Lt -> VBool (f < f2) | Gt -> VBool (f > f2)
          | Lte -> VBool (f <= f2) | Gte -> VBool (f >= f2)
          | _ -> raise (EvalError "Invalid operator on float/int"))
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
      | VTuple lst ->
          (try List.nth lst (int_of_string field_name)
          with _ -> raise (EvalError ("Invalid tuple index: " ^ field_name)))
      | _ -> raise (EvalError "Field access on non-pointer or non-tuple"))
  | EMatch (e, arms) ->
      let v = eval_expr env e in
      let rec try_match arms =
        match arms with
        | [] -> raise (EvalError "Non-exhaustive match")
        | (pat, e_arm) :: rest ->
            let matches, env_ext = match pat.item, v with
              | PWildcard, _ -> true, env
              | PIdent id, _ -> true, { env with vars = StringMap.add id (ref v) env.vars }
              | PVariant (name, None), VStr s -> (name = s), env
              | PVariant (name, None), VPtr ptr -> 
                  (match (IntMap.find ptr !heap).data with
                  | HOk _ when name = "Ok" -> true, env
                  | HErr _ when name = "Err" -> true, env
                  | HEnum (_, vname, _) when vname = name -> true, env
                  | _ -> false, env)
              | PVariant (name, Some pats), VPtr ptr -> 
                  (match (IntMap.find ptr !heap).data with
                  | HOk inner when name = "Ok" -> 
                      (match (List.hd pats).item with
                      | PIdent id -> true, { env with vars = StringMap.add id (ref inner) env.vars }
                      | PWildcard -> true, env
                      | _ -> false, env)
                  | HErr inner when name = "Err" -> 
                      (match (List.hd pats).item with
                      | PIdent id -> true, { env with vars = StringMap.add id (ref inner) env.vars }
                      | PWildcard -> true, env
                      | _ -> false, env)
                  | HEnum (_, vname, args) when vname = name ->
                      let rec match_args ps vs env_acc =
                        match ps, vs with
                        | [], [] -> true, env_acc
                        | p::ps_rest, v::vs_rest ->
                            (match p.item with
                            | PIdent id -> match_args ps_rest vs_rest { env_acc with vars = StringMap.add id (ref v) env_acc.vars }
                            | PWildcard -> match_args ps_rest vs_rest env_acc
                            | _ -> false, env_acc)
                        | _ -> false, env_acc
                      in
                      match_args pats args env
                  | _ -> false, env)
              | PLit (LInt (n, _)), VInt i  -> Int64.equal n i, env
              | PLit (LFloat (f, _)), VFloat g -> f = g, env
              | PLit (LBool b), VBool b2   -> b = b2, env
              | PLit (LStr s), VStr s2     -> s = s2, env
              | PLit (LChar c), VChar c2   -> c = c2, env
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
  | ECast (e, t) ->
      let v = eval_expr env e in
      (match v, t.item with
      | VInt i, TBase (TF16 | TF32 | TF64 | TF128) -> VFloat (Int64.to_float i)
      | VFloat f, TBase (TU8 | TU16 | TU32 | TU64 | TU128 | TUSize
                        | TI8 | TI16 | TI32 | TI64 | TI128 | TISize) -> VInt (Int64.of_float f)
      | VChar c, TBase (TU8 | TU16 | TU32 | TU64 | TU128 | TUSize
                        | TI8 | TI16 | TI32 | TI64 | TI128 | TISize) -> VInt (Int64.of_int (Char.code c))
      | VInt i, TBase TChar -> VChar (Char.chr (Int64.to_int i))
      | VChar c, TBase TStr -> VStr (String.make 1 c)
      | _ -> v)
  | EGenericApp (_, e) -> eval_expr env e
  | EArray elems ->
      let arr = Array.of_list (List.map (eval_expr env) elems) in
      VArray arr
  | ETuple elems ->
      VTuple (List.map (eval_expr env) elems)
  | EIndex (e, i) ->
      let v_arr = eval_expr env e in
      let v_idx = eval_expr env i in
      (match v_arr, v_idx with
      | VArray arr, VInt idx ->
          let i_int = Int64.to_int idx in
          if i_int < 0 || i_int >= Array.length arr then raise (EvalError "Array index out of bounds");
          arr.(i_int)
      | VStr str, VInt idx ->
          let i_int = Int64.to_int idx in
          if i_int < 0 || i_int >= String.length str then raise (EvalError "String index out of bounds");
          VChar str.[i_int]
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
  | EMethodCall (obj, method_name, args, resolved_name_ref) ->
      let mangled_name = match !resolved_name_ref with
        | Some name -> name
        | None ->
            let suffix = "_" ^ method_name in
            (match StringMap.bindings env.funcs |> List.find_opt (fun (k, _) -> String.ends_with ~suffix k) with
             | Some (name, _) -> name
             | None -> raise (EvalError ("Cannot resolve method " ^ method_name)))
      in
      eval_expr env ({ item = ECall (mangled_name, obj :: args); span = dummy_span })
  | ESizeOf _ | ETypeOf _ | EComptime _ -> raise (EvalError "sizeof/typeof/comptime should have been evaluated at compile-time")

and eval_stmt env stmt =
  match stmt.item with
  | SDecl { kind = _; pat; typ = _; init } ->
      let v = eval_expr env init in
      let matches, new_env = match_pat pat v env in
      if not matches then raise (EvalError "Pattern match failed in variable declaration");
      new_env
  | SAssign (lhs, e) ->
      let v = eval_expr env e in
      (match lhs with
      | { item = EVar name; _ } ->
          if StringMap.mem name env.vars then
            let v_ref = StringMap.find name env.vars in
            v_ref := v;
            env
          else if StringMap.mem name env.globals then
            let v_ref = StringMap.find name env.globals in
            v_ref := v;
            env
          else raise (EvalError ("Variable not found: " ^ name))
      | { item = EIndex (arr, i); _ } ->
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

and build_env env prog =
  let env_with_imports = List.fold_left (fun e (imp : import_decl) ->
    let basename = Filename.basename imp.path in
    let default_prefix = if String.ends_with ~suffix:".wyz" basename then
        String.sub basename 0 (String.length basename - 4)
      else basename
    in
    let is_std = String.starts_with ~prefix:"std/" imp.path in
    if is_std then
      let prefix = match imp.alias with Some a -> a | None -> default_prefix in
      let path_list = String.split_on_char '/' imp.path in
      { e with imports = StringMap.add prefix path_list e.imports }
    else
      let mod_path = Filename.concat e.project_root imp.path in
      let mod_path = if String.ends_with ~suffix:".wyz" mod_path then mod_path else mod_path ^ ".wyz" in
      if not (Sys.file_exists mod_path) then
        raise (EvalError ("Module file not found: " ^ mod_path));
      
      let inx = open_in mod_path in
      let lexbuf = Lexing.from_channel inx in
      lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = mod_path };
      let parsed_prog = try Parser.parse_program Lexer.read lexbuf with
        | _ -> close_in inx; raise (EvalError ("Failed to parse imported module " ^ imp.path))
      in
      close_in inx;
      let mod_env = build_env { empty_env with project_root = e.project_root } parsed_prog in
      
      match imp.alias with
      | Some a ->
          let e1 = { e with modules = StringMap.add a mod_env e.modules } in
          { e1 with imports = StringMap.add a [a] e1.imports }
      | None ->
          let merge_map m1 m2 = StringMap.fold StringMap.add m1 m2 in
          { e with 
            funcs = merge_map mod_env.funcs e.funcs;
            globals = merge_map mod_env.globals e.globals;
            enums = merge_map mod_env.enums e.enums;
            modules = merge_map mod_env.modules e.modules;
          }
  ) env prog.Ast.imports in
  let rec eval_item e item =
    match item.item with
    | IFn f -> { e with funcs = StringMap.add f.name f e.funcs }
    | IEnum en -> { e with enums = StringMap.add en.name en e.enums }
    | IStruct _ -> e
    | IGlobal { name; init; _ } ->
        let v = eval_expr e init in
        { e with globals = StringMap.add name (ref v) e.globals }
    | IGeneric (_, i) -> eval_item e i
    | IRole _ -> e
    | ITrait _ -> e
    | IImpl impl ->
        let new_funcs = List.fold_left (fun acc (m: Ast.fn_decl) ->
          let mangled = impl.trait_name ^ "_" ^ (Ast.show_typ impl.for_typ |> String.map (function ' ' | '(' | ')' -> '_' | c -> c)) ^ "_" ^ m.name in
          StringMap.add mangled m acc
        ) e.funcs impl.methods in
        { e with funcs = new_funcs }
    | IMod m ->
        let mod_path = Filename.concat e.project_root (m.name ^ ".wyz") in
        if not (Sys.file_exists mod_path) then
          raise (EvalError ("Module file not found: " ^ mod_path));
        let inx = open_in mod_path in
        let lexbuf = Lexing.from_channel inx in
        lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = mod_path };
        let parsed_prog = try Parser.parse_program Lexer.read lexbuf with
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
