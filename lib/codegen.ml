open Ast
open Llvm

exception CodegenError of string

let context = global_context ()
let the_module = create_module context "wyzer_module"
let builder = builder context

(* Base LLVM types *)
let i32_type = i32_type context
let i64_type = i64_type context
let bool_type = i1_type context
let void_type = void_type context
let str_type = pointer_type context

(* Symbol Table mapping names to their alloca instructions (pointers) *)
module StringMap = Map.Make(String)
let named_values : (lltype * llvalue) StringMap.t ref = ref StringMap.empty
let global_values : (lltype * llvalue) StringMap.t ref = ref StringMap.empty
let function_types : lltype StringMap.t ref = ref StringMap.empty

let rec generate_type (t: typ) : lltype =
  match t with
  | TBase TU32 -> i32_type
  | TBase TU64 -> i64_type
  | TBase TI32 -> i32_type
  | TBase TI64 -> i64_type
  | TBase TBool -> bool_type
  | TBase TStr -> str_type
  | TBase TUnit -> void_type
  | TRole (inner, _) -> generate_type inner
  | _ -> void_type (* Simplified for now *)

(* Declare external functions *)
let printf_type = var_arg_function_type i32_type [| str_type |]
let printf_func = declare_function "printf" printf_type the_module
let _ = function_types := StringMap.add "printf" printf_type !function_types

let ipc_send_type = function_type void_type [| str_type; i32_type |]
let ipc_send_func = declare_function "wyzer_ipc_send" ipc_send_type the_module
let _ = function_types := StringMap.add "wyzer_ipc_send" ipc_send_type !function_types

let ipc_recv_type = function_type i32_type [| str_type |]
let ipc_recv_func = declare_function "wyzer_ipc_recv" ipc_recv_type the_module
let _ = function_types := StringMap.add "wyzer_ipc_recv" ipc_recv_type !function_types

let create_entry_block_alloca fn_val var_name var_type =
  let entry = entry_block fn_val in
  let builder = builder_at context (instr_begin entry) in
  build_alloca var_type var_name builder

let rec generate_expr (e: expr) : llvalue =
  match e with
  | ELit (LInt (i, t)) -> 
      let llty = match t with Some TU64 | Some TI64 -> i64_type | _ -> i32_type in
      const_int llty (Int64.to_int i)
  | ELit (LBool b) -> const_int bool_type (if b then 1 else 0)
  | ELit (LStr s) -> build_global_stringptr s "strtmp" builder
  | EVar name ->
      (match StringMap.find_opt name !named_values with
      | Some (ty, ptr) -> build_load ty ptr name builder
      | None -> 
          match StringMap.find_opt name !global_values with
          | Some (ty, g) -> build_load ty g name builder
          | None -> raise (CodegenError ("Unknown variable " ^ name)))
  | EBinOp (e1, op, e2) ->
      let v1 = generate_expr e1 in
      let v2 = generate_expr e2 in
      (match op with
      | Add -> build_add v1 v2 "addtmp" builder
      | Sub -> build_sub v1 v2 "subtmp" builder
      | Mul -> build_mul v1 v2 "multmp" builder
      | Div -> build_sdiv v1 v2 "sdivtmp" builder
      | Eq -> build_icmp Icmp.Eq v1 v2 "eqtmp" builder
      | Neq -> build_icmp Icmp.Ne v1 v2 "neqtmp" builder
      | Lt -> build_icmp Icmp.Slt v1 v2 "lttmp" builder
      | Gt -> build_icmp Icmp.Sgt v1 v2 "gttmp" builder
      | Lte -> build_icmp Icmp.Sle v1 v2 "ltetmp" builder
      | Gte -> build_icmp Icmp.Sge v1 v2 "gtetmp" builder
      | And -> build_and v1 v2 "andtmp" builder
      | Or -> build_or v1 v2 "ortmp" builder
      | _ -> raise (CodegenError "Unsupported binary operator in LLVM backend"))
  | ECall (name, args) ->
      let callee = match lookup_function name the_module with
        | Some f -> f
        | None -> raise (CodegenError ("Unknown function referenced: " ^ name))
      in
      let f_ty = match StringMap.find_opt name !function_types with
        | Some t -> t
        | None -> raise (CodegenError ("Unknown function type: " ^ name))
      in
      let args_val = Array.of_list (List.map generate_expr args) in
      build_call f_ty callee args_val "calltmp" builder
  | EPathCall (path, args) ->
      let resolved = String.concat "_" path in
      let args_val = Array.of_list (List.map generate_expr args) in
      if resolved = "std_io_println" || resolved = "std_io_print" then
        let fmt = build_global_stringptr (if resolved = "std_io_println" then "%s\n" else "%s") "fmt" builder in
        let all_args = Array.append [| fmt |] args_val in
        build_call printf_type printf_func all_args "printf_call" builder
      else
        let callee = match lookup_function resolved the_module with
          | Some f -> f
          | None -> raise (CodegenError ("Unknown function: " ^ resolved))
        in
        let f_ty = match StringMap.find_opt resolved !function_types with
          | Some t -> t
          | None -> raise (CodegenError ("Unknown function type: " ^ resolved))
        in
        build_call f_ty callee args_val "calltmp" builder
  | ENetSend (target, inner) ->
      let v = generate_expr inner in
      let target_str = build_global_stringptr target "target_str" builder in
      build_call ipc_send_type ipc_send_func [| target_str; v |] "" builder
  | ENetRecv src ->
      let src_str = build_global_stringptr src "src_str" builder in
      build_call ipc_recv_type ipc_recv_func [| src_str |] "recvtmp" builder
  | EIf (cond, thn, els) ->
      let cond_val = generate_expr cond in
      let start_bb = insertion_block builder in
      let the_function = block_parent start_bb in
      
      let then_bb = append_block context "then" the_function in
      let else_bb = append_block context "else" the_function in
      let merge_bb = append_block context "ifcont" the_function in
      
      ignore (build_cond_br cond_val then_bb else_bb builder);
      
      (* Generate Then *)
      position_at_end then_bb builder;
      ignore (generate_block thn);
      ignore (build_br merge_bb builder);
      
      (* Generate Else *)
      position_at_end else_bb builder;
      (match els with
      | Some e_block -> ignore (generate_block e_block)
      | None -> ());
      ignore (build_br merge_bb builder);
      
      position_at_end merge_bb builder;
      const_int i32_type 0 (* Placeholder for now, proper phi requires tracking if block returns a value *)
  | _ -> raise (CodegenError "Unsupported expression in LLVM backend")

and generate_stmt (s: stmt) : unit =
  match s with
  | SExpr e -> ignore (generate_expr e)
  | SDecl d ->
      let init_val = generate_expr d.init in
      let init_type = type_of init_val in
      let the_function = block_parent (insertion_block builder) in
      let alloca = create_entry_block_alloca the_function d.name init_type in
      ignore (build_store init_val alloca builder);
      named_values := StringMap.add d.name (init_type, alloca) !named_values
  | SAssign (EVar name, e_right) ->
      let val_right = generate_expr e_right in
      (match StringMap.find_opt name !named_values with
      | Some (_, ptr) -> ignore (build_store val_right ptr builder)
      | None -> raise (CodegenError ("Unknown variable assigned: " ^ name)))
  | SReturn (Some e) ->
      ignore (build_ret (generate_expr e) builder)
  | SReturn None ->
      ignore (build_ret_void builder)
  | SDrop _ -> ()
  | _ -> raise (CodegenError "Unsupported statement in LLVM backend")

and generate_block (b: block) : unit =
  List.iter generate_stmt b.stmts;
  match b.ret_expr with
  | Some e -> ignore (generate_expr e)
  | None -> ()

let generate_item (item: item) : unit =
  match item with
  | IFn f ->
      let actual_name = if f.name = "main" then "wyzer_main" else f.name in
      let ret_type = match f.ret_typ with Some t -> generate_type t | None -> void_type in
      let param_types = Array.of_list (List.map (fun (p: Ast.param) -> generate_type p.typ) f.params) in
      let ft = function_type ret_type param_types in
      let the_function = declare_function actual_name ft the_module in
      function_types := StringMap.add actual_name ft !function_types;
      
      if not f.is_extern then (
        let bb = append_block context "entry" the_function in
        position_at_end bb builder;
        
        let old_vars = !named_values in
        named_values := StringMap.empty;
        
        Array.iteri (fun i p_val ->
          let p_ast = List.nth f.params i in
          set_value_name p_ast.name p_val;
          let p_type = type_of p_val in
          let alloca = create_entry_block_alloca the_function p_ast.name p_type in
          ignore (build_store p_val alloca builder);
          named_values := StringMap.add p_ast.name (p_type, alloca) !named_values
        ) (params the_function);
        
        (match f.body with
        | Some body ->
            generate_block body;
            (* Ensure all blocks have a terminator *)
            let last_bb = insertion_block builder in
            if block_terminator last_bb = None then (
              if ret_type = void_type then ignore (build_ret_void builder)
              else ignore (build_ret (const_null ret_type) builder)
            )
        | None -> ());
        
        named_values := old_vars
      )
  | IGlobal g ->
      let init_val = generate_expr g.init in
      let init_type = type_of init_val in
      let g_var = define_global g.name init_val the_module in
      global_values := StringMap.add g.name (init_type, g_var) !global_values
  | _ -> ()

let generate_llvm (p: program) (_target_role: string) : llmodule =
  List.iter generate_item p.items;
  
  (* Create C main wrapper if wyzer_main exists *)
  (match lookup_function "wyzer_main" the_module with
  | Some wyzer_main_func ->
      let main_ft = function_type i32_type [||] in
      let c_main = declare_function "main" main_ft the_module in
      let bb = append_block context "entry" c_main in
      position_at_end bb builder;
      let _ = build_call (function_type void_type [||]) wyzer_main_func [||] "" builder in
      ignore (build_ret (const_int i32_type 0) builder)
  | None -> ());
  
  the_module
