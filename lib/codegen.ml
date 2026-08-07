open Ast
open Llvm

let pat_name (p: Ast.pattern) : string =
  match p.item with
  | PIdent name -> name
  | _ -> "_pat"

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

module StringMap = Map.Make(String)
let named_values : (lltype * llvalue) StringMap.t ref = ref StringMap.empty
let global_values : (lltype * llvalue) StringMap.t ref = ref StringMap.empty
let function_types : lltype StringMap.t ref = ref StringMap.empty

let struct_decls : struct_decl StringMap.t ref = ref StringMap.empty
let enum_decls : enum_decl StringMap.t ref = ref StringMap.empty
let generic_struct_decls : (string list * struct_decl) StringMap.t ref = ref StringMap.empty
let generic_enum_decls : (string list * enum_decl) StringMap.t ref = ref StringMap.empty

let type_cache = Hashtbl.create 100

let rec generate_type (t: typ) : lltype =
  let key = fmt_typ t in
  match Hashtbl.find_opt type_cache key with
  | Some llty -> llty
  | None ->
      let llty = match t.item with
      | TBase TU32 | TBase TI32 -> i32_type
      | TBase TU64 | TBase TI64 | TBase TUSize | TBase TISize -> i64_type
      | TBase TU8 | TBase TI8 -> i8_type context
      | TBase TU16 | TBase TI16 -> i16_type context
      | TBase TF8 -> i8_type context
      | TBase TF16 -> i16_type context
      | TBase TF32 -> float_type context
      | TBase TF64 -> double_type context
      | TBase TF128 -> fp128_type context
      | TBase TBool -> bool_type
      | TBase TStr -> str_type
      | TBase TChar -> i32_type
      | TBase TUnit -> void_type
      | TRole (inner, _) -> generate_type inner
      | TTuple elems ->
          let ll_elems = Array.of_list (List.map generate_type elems) in
          struct_type context ll_elems
      | TBase (TCustom name) ->
          (match StringMap.find_opt name !struct_decls with
          | Some s_decl ->
              let fields = Array.of_list (List.map (fun (f: field) -> generate_type f.typ) s_decl.fields) in
              let named_struct = named_struct_type context name in
              struct_set_body named_struct fields false;
              named_struct
          | None ->
              (match StringMap.find_opt name !enum_decls with
              | Some _ ->
                  (* Tagged union: { i32 tag, { max_payload } } *)
                  let named_struct = named_struct_type context name in
                  let payload_ty = struct_type context (Array.make 4 i64_type) in
                  struct_set_body named_struct [| i32_type; payload_ty |] false;
                  named_struct
              | None -> raise (CodegenError ("Unknown type: " ^ name))))
      | TBase (TGenericApp (targs, TCustom name)) ->
          (* Simple monomorphization stub *)
          (match StringMap.find_opt name !generic_struct_decls with
          | Some (params, s_decl) ->
              let subst = List.fold_left2 (fun acc p targ -> StringMap.add p targ acc) StringMap.empty params targs in
              let fields = Array.of_list (List.map (fun (f: field) -> generate_type (Typechecker.substitute_typ subst f.typ)) s_decl.fields) in
              let named_struct = named_struct_type context (name ^ "_mono") in
              struct_set_body named_struct fields false;
              named_struct
          | None -> raise (CodegenError ("Unknown generic struct: " ^ name)))
      | TResult (ok, err) ->
          let ok_ty = generate_type ok in
          let err_ty = generate_type err in
          struct_type context [| i32_type; struct_type context [| ok_ty; err_ty |] |]
      | TArray _elem ->
          (* dynamic array stub: { i64 len, i64 cap, ptr data } *)
          struct_type context [| i64_type; i64_type; pointer_type context |]
      | _ -> void_type
      in
      Hashtbl.add type_cache key llty;
      llty

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

let rec type_of_expr (e: expr) : typ =
  match Typechecker.ExprMap.find_opt Typechecker.typed_ast_map e with
  | Some t -> t
  | None -> 
      (* Fallback type inference for reconstructed AST nodes (e.g. from Perceus) *)
      let dummy = { Ast.file = ""; start_line = 0; start_col = 0; end_line = 0; end_col = 0 } in
      let wrap item = { Ast.item; span = dummy } in
      (match e.item with
      | ELit (LInt (_, Some t)) -> wrap (TBase t)
      | ELit (LInt (_, None)) -> wrap (TBase TU32)
      | ELit (LFloat (_, Some t)) -> wrap (TBase t)
      | ELit (LFloat (_, None)) -> wrap (TBase TF64)
      | ELit (LBool _) -> wrap (TBase TBool)
      | ELit (LStr _) -> wrap (TBase TStr)
      | ELit (LChar _) -> wrap (TBase TChar)
      | ETuple elems -> wrap (TTuple (List.map type_of_expr elems))
      | EOk (inner, _) -> wrap (TResult (type_of_expr inner, wrap (TBase TUnit)))
      | EErr (inner, _) -> wrap (TResult (wrap (TBase TUnit), type_of_expr inner))
      | EDup (_, inner) -> type_of_expr inner
      | EStruct (name, _, _) -> wrap (TBase (TCustom name))
      | EField (inner, fname) ->
          let inner_ty = type_of_expr inner in
          let base = match inner_ty.item with TRole (t, _) -> t.item | t -> t in
          (match base with
          | TTuple elems -> List.nth elems (int_of_string fname)
          | TBase (TCustom name) ->
              (match StringMap.find_opt name !struct_decls with
              | Some s_decl -> (List.find (fun (f: field) -> f.name = fname) s_decl.fields).typ
              | None -> raise (CodegenError ("Unknown struct in EField: " ^ name)))
          | _ -> raise (CodegenError "Field access on non-struct"))
      | _ -> raise (CodegenError ("Untyped expression in AST at file " ^ e.span.file ^ ": " ^ Ast.show_expr_node e.item)))

let rec generate_expr (e: expr) : llvalue =
  match e.item with
  | ELit (LInt (i, t)) -> 
      let ty = match t with
        | Some ty -> generate_type { Ast.item = TBase ty; span = Ast.dummy_span }
        | None -> i32_type
      in
      const_int ty (Int64.to_int i)
  | ELit (LFloat (f, t)) ->
      let ty = match t with
        | Some ty -> generate_type { Ast.item = TBase ty; span = Ast.dummy_span }
        | None -> double_type context
      in
      const_float ty f
  | ELit (LBool b) -> const_int bool_type (if b then 1 else 0)
  | ELit (LStr s) -> build_global_stringptr s "strtmp" builder
  | ELit (LChar c) -> const_int (i32_type) (Char.code c)
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
      let is_float_op = match Llvm.classify_type (type_of v1) with
        | Llvm.TypeKind.Half | Llvm.TypeKind.Float | Llvm.TypeKind.Double | Llvm.TypeKind.Fp128 -> true
        | _ -> false
      in
      (match op with
      | Add -> if is_float_op then build_fadd v1 v2 "faddtmp" builder else build_add v1 v2 "addtmp" builder
      | Sub -> if is_float_op then build_fsub v1 v2 "fsubtmp" builder else build_sub v1 v2 "subtmp" builder
      | Mul -> if is_float_op then build_fmul v1 v2 "fmultmp" builder else build_mul v1 v2 "multmp" builder
      | Div -> if is_float_op then build_fdiv v1 v2 "fdivtmp" builder else build_sdiv v1 v2 "sdivtmp" builder
      | Eq -> if is_float_op then build_fcmp Fcmp.Oeq v1 v2 "feqtmp" builder else build_icmp Icmp.Eq v1 v2 "eqtmp" builder
      | Neq -> if is_float_op then build_fcmp Fcmp.One v1 v2 "fneqtmp" builder else build_icmp Icmp.Ne v1 v2 "neqtmp" builder
      | Lt -> if is_float_op then build_fcmp Fcmp.Olt v1 v2 "flttmp" builder else build_icmp Icmp.Slt v1 v2 "lttmp" builder
      | Gt -> if is_float_op then build_fcmp Fcmp.Ogt v1 v2 "fgttmp" builder else build_icmp Icmp.Sgt v1 v2 "gttmp" builder
      | Lte -> if is_float_op then build_fcmp Fcmp.Ole v1 v2 "fltetmp" builder else build_icmp Icmp.Sle v1 v2 "ltetmp" builder
      | Gte -> if is_float_op then build_fcmp Fcmp.Oge v1 v2 "fgtetmp" builder else build_icmp Icmp.Sge v1 v2 "gtetmp" builder
      | And -> build_and v1 v2 "andtmp" builder
      | Or -> build_or v1 v2 "ortmp" builder
      | Shl -> build_shl v1 v2 "shltmp" builder
      | Shr -> build_lshr v1 v2 "shrtmp" builder
      | BitAnd -> build_and v1 v2 "bitandtmp" builder
      | BitOr -> build_or v1 v2 "bitortmp" builder)
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
      let name = if return_type f_ty = void_type then "" else "calltmp" in
      build_call f_ty callee args_val name builder
  | EPathVar path ->
      let t = type_of_expr e in
      let base_t = match t.item with TRole (t_inner, _) -> t_inner.item | _ -> t.item in
      let the_function = block_parent (insertion_block builder) in
      (match base_t with
      | TBase (TCustom name) ->
          if StringMap.mem name !enum_decls then
            let enum_decl = StringMap.find name !enum_decls in
            let variant_name = List.nth path (List.length path - 1) in
            let variant_idx = List.mapi (fun i (m: enum_member) -> if m.name = variant_name then Some i else None) enum_decl.members |> List.find_map (fun x -> x) |> Option.get in
            
            let llty = generate_type t in
            let alloca = create_entry_block_alloca the_function "enum_val" llty in
            let tag_ptr = build_struct_gep llty alloca 0 "tag_gep" builder in
            ignore (build_store (const_int i32_type variant_idx) tag_ptr builder);
            build_load llty alloca "enum_val" builder
          else
            raise (CodegenError ("Unknown custom type in EPathVar: " ^ name))
      | _ -> raise (CodegenError ("Unsupported EPathVar type")))
  | EPathCall (path, args) ->
      let ty_opt = (try Some (type_of_expr e) with _ -> None) in
      let base_ty_opt = match ty_opt with Some t -> Some (match t.item with TRole (inner, _) -> inner.item | item -> item) | None -> None in
      (match base_ty_opt with
      | Some (TBase (TCustom name)) when StringMap.mem name !enum_decls ->
          let enum_decl = StringMap.find name !enum_decls in
          let variant_name = List.nth path (List.length path - 1) in
          let variant_idx = List.mapi (fun i (m: enum_member) -> if m.name = variant_name then Some i else None) enum_decl.members |> List.find_map (fun x -> x) |> Option.get in
          let llty = generate_type (Option.get ty_opt) in
          let the_function = block_parent (insertion_block builder) in
          let alloca = create_entry_block_alloca the_function "enum_tmp" llty in
          
          let tag_ptr = build_struct_gep llty alloca 0 "tag_gep" builder in
          ignore (build_store (const_int i32_type variant_idx) tag_ptr builder);
          
          let payload_gep = build_struct_gep llty alloca 1 "payload_gep" builder in
          let args_val = Array.of_list (List.map generate_expr args) in
          if Array.length args_val > 0 then (
              let variant_payload_ty = struct_type context (Array.map type_of args_val) in
              Array.iteri (fun i arg_v ->
                  let field_ptr = build_struct_gep variant_payload_ty payload_gep i "f_gep" builder in
                  ignore (build_store arg_v field_ptr builder)
              ) args_val
          );
          build_load llty alloca "enum_val" builder
      | _ ->
          let resolved = String.concat "_" path in
          if resolved = "std_io_println" || resolved = "std_io_print" || resolved = "std_io_eprintln" || resolved = "std_io_eprint" then
            let is_nl = (resolved = "std_io_println" || resolved = "std_io_eprintln") in
            if List.length args > 1 then
              let fmt_expr = List.hd args in
              let fmt_str = match fmt_expr.item with ELit (LStr s) -> s | _ -> failwith "Expected string format in codegen" in
              let arg_exprs = List.tl args in
              let args_val = Array.of_list (List.map generate_expr arg_exprs) in
              let c_fmt = ref "" in
              let arg_idx = ref 0 in
              let i = ref 0 in
              while !i < String.length fmt_str do
                if !i + 1 < String.length fmt_str && fmt_str.[!i] = '{' && fmt_str.[!i+1] = '}' then (
                  let ll_val = args_val.(!arg_idx) in
                  let ll_ty = type_of ll_val in
                  let spec = match Llvm.classify_type ll_ty with
                    | Llvm.TypeKind.Integer -> "%d"
                    | Llvm.TypeKind.Pointer -> "%s"
                    | Llvm.TypeKind.Double | Llvm.TypeKind.Float -> "%f"
                    | _ -> "%s"
                  in
                  c_fmt := !c_fmt ^ spec;
                  arg_idx := !arg_idx + 1;
                  i := !i + 2
                ) else (
                  c_fmt := !c_fmt ^ String.make 1 (fmt_str.[!i]);
                  i := !i + 1
                )
              done;
              let final_fmt = if is_nl then !c_fmt ^ "\n" else !c_fmt in
              let fmt_ptr = build_global_stringptr final_fmt "fmt" builder in
              let all_args = Array.append [| fmt_ptr |] args_val in
              build_call printf_type printf_func all_args "printf_call" builder
            else
              let arg_val = generate_expr (List.hd args) in
              let spec = match Llvm.classify_type (type_of arg_val) with
                | Llvm.TypeKind.Integer -> "%d"
                | Llvm.TypeKind.Pointer -> "%s"
                | Llvm.TypeKind.Double | Llvm.TypeKind.Float -> "%f"
                | _ -> "%s"
              in
              let final_fmt = if is_nl then spec ^ "\n" else spec in
              let fmt_ptr = build_global_stringptr final_fmt "fmt" builder in
              build_call printf_type printf_func [| fmt_ptr; arg_val |] "printf_call" builder
          else
            let args_val = Array.of_list (List.map generate_expr args) in
            let wyzer_c_name = if String.starts_with ~prefix:"std_" resolved then "wyzer_" ^ resolved else resolved in
            let callee, f_ty = match lookup_function wyzer_c_name the_module with
              | Some f ->
                  let ty = match StringMap.find_opt wyzer_c_name !function_types with
                    | Some t -> t
                    | None -> function_type i64_type (Array.make (Array.length args_val) i64_type)
                  in
                  f, ty
              | None ->
                  let ret_ty, param_tys = match resolved with
                    | "std_io_read_line" | "std_fs_read_file" -> str_type, [| str_type |]
                    | "std_fs_write_file" -> bool_type, [| str_type; str_type |]
                    | "std_fs_file_exists" -> bool_type, [| str_type |]
                    | "std_time_now_ms" -> i64_type, [||]
                    | "std_process_sleep" -> void_type, [| i32_type |]
                    | "std_process_exit" -> void_type, [| i32_type |]
                    | _ -> i64_type, Array.make (Array.length args_val) i64_type
                  in
                  let ft = function_type ret_ty param_tys in
                  let f = declare_function wyzer_c_name ft the_module in
                  function_types := StringMap.add wyzer_c_name ft !function_types;
                  f, ft
            in
            let name = if return_type f_ty = void_type then "" else "calltmp" in
            build_call f_ty callee args_val name builder)
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
      
      position_at_end then_bb builder;
      let _ret_val_opt = generate_block thn in
      ignore (build_br merge_bb builder);
      
      position_at_end else_bb builder;
      let _else_val_opt = match els with
      | Some e_block -> generate_block e_block
      | None -> None
      in
      ignore (build_br merge_bb builder);
      
      position_at_end merge_bb builder;
      const_int i32_type 0 
      
  | ETuple elems ->
      let llty = generate_type (type_of_expr e) in
      let the_function = block_parent (insertion_block builder) in
      let alloca = create_entry_block_alloca the_function "tuple_tmp" llty in
      List.iteri (fun i elem_expr ->
          let elem_val = generate_expr elem_expr in
          let field_ptr = build_struct_gep llty alloca i "gep" builder in
          ignore (build_store elem_val field_ptr builder)
      ) elems;
      build_load llty alloca "tuple_load" builder
      
  | EStruct (_, fields, _) ->
      let llty = generate_type (type_of_expr e) in
      let the_function = block_parent (insertion_block builder) in
      let alloca = create_entry_block_alloca the_function "struct_tmp" llty in
      let typ = type_of_expr e in
      let base = match typ.item with TRole (inner, _) -> inner.item | _ -> typ.item in
      let struct_decl_opt = match base with 
        | TBase (TCustom name) -> StringMap.find_opt name !struct_decls 
        | TBase (TGenericApp (_, TCustom name)) -> Option.map snd (StringMap.find_opt name !generic_struct_decls)
        | _ -> None
      in
      (match struct_decl_opt with
      | Some s_decl ->
          List.iter (fun (fname, fexpr) ->
              let idx_opt = List.mapi (fun i (f: field) -> if f.name = fname then Some i else None) s_decl.fields |> List.find_map (fun x -> x) in
              match idx_opt with
              | Some idx ->
                  let f_val = generate_expr fexpr in
                  let f_ptr = build_struct_gep llty alloca idx "gep" builder in
                  ignore (build_store f_val f_ptr builder)
              | None -> ()
          ) fields;
          build_load llty alloca "struct_load" builder
      | None -> raise (CodegenError "Unknown struct instantiated"))
      
  | EField (inner, fname) ->
      let inner_val = generate_expr inner in
      let inner_ty = generate_type (type_of_expr inner) in
      let the_function = block_parent (insertion_block builder) in
      let alloca = create_entry_block_alloca the_function "field_tmp" inner_ty in
      ignore (build_store inner_val alloca builder);
      
      let base = match (type_of_expr inner).item with TRole (t, _) -> t.item | t -> t in
      let idx = match base with
      | TTuple _ -> int_of_string fname
      | TBase (TCustom name) ->
          (match StringMap.find_opt name !struct_decls with
          | Some s_decl -> List.mapi (fun i (f: field) -> if f.name = fname then Some i else None) s_decl.fields |> List.find_map (fun x -> x) |> Option.get
          | None -> raise (CodegenError "Unknown struct"))
      | TBase (TGenericApp (_, TCustom name)) ->
          (match StringMap.find_opt name !generic_struct_decls with
          | Some (_, s_decl) -> List.mapi (fun i (f: field) -> if f.name = fname then Some i else None) s_decl.fields |> List.find_map (fun x -> x) |> Option.get
          | None -> raise (CodegenError "Unknown struct"))
      | _ -> 0
      in
      let field_ptr = build_struct_gep inner_ty alloca idx "gep" builder in
      let field_ty = match element_type inner_ty with t -> struct_element_types t |> fun arr -> arr.(idx) in
      build_load field_ty field_ptr "field_val" builder
      
  | EMatch (expr_to_match, arms) ->
      if List.length arms = 0 then raise (CodegenError "Empty match") else
      let match_val = generate_expr expr_to_match in
      let match_ty = type_of_expr expr_to_match in
      let the_function = block_parent (insertion_block builder) in
      
      let llty = generate_type match_ty in
      let alloca = create_entry_block_alloca the_function "match_val" llty in
      ignore (build_store match_val alloca builder);
      
      let tag_ptr = build_struct_gep llty alloca 0 "tag_gep" builder in
      let tag_val = build_load i32_type tag_ptr "tag" builder in
      
      let merge_bb = append_block context "match_cont" the_function in
      let default_bb = append_block context "match_default" the_function in
      
      let switch_inst = build_switch tag_val default_bb (List.length arms) builder in
      
      let ret_ty = (try generate_type (type_of_expr e) with _ -> void_type) in
      let result_alloca = if ret_ty <> void_type then Some (create_entry_block_alloca the_function "match_res" ret_ty) else None in
      let base_match_ty = match match_ty.item with TRole (t, _) -> t | _ -> match_ty in
      let enum_decl = match (base_match_ty.item) with
      | TBase (TCustom name) -> StringMap.find name !enum_decls
      | _ -> raise (CodegenError ("Match on non-enum: " ^ show_typ_node match_ty.item))
      in
      
      List.iteri (fun arm_idx (pat, arm_expr) ->
          let arm_bb = append_block context ("match_arm_" ^ string_of_int arm_idx) the_function in
          position_at_end arm_bb builder;
          
          (match pat.item with
          | PVariant (variant_name, Some payload_pats) ->
              let variant_idx = List.mapi (fun i (m: enum_member) -> if m.name = variant_name then Some i else None) enum_decl.members |> List.find_map (fun x -> x) |> Option.get in
              add_case switch_inst (const_int i32_type variant_idx) arm_bb;
              
              let payload_gep = build_struct_gep llty alloca 1 "payload_gep" builder in
              let variant_payload_ty = struct_type context (Array.of_list (List.map generate_type (List.nth enum_decl.members variant_idx).payload)) in
              
              List.iteri (fun i p ->
                  let field_ptr = build_struct_gep variant_payload_ty payload_gep i "f_gep" builder in
                  let f_ty = generate_type (List.nth (List.nth enum_decl.members variant_idx).payload i) in
                  let f_val = build_load f_ty field_ptr "f_val" builder in
                  let bind_pat p v ty =
                    match p.item with
                    | PIdent name ->
                        let var_alloca = create_entry_block_alloca the_function name ty in
                        ignore (build_store v var_alloca builder);
                        named_values := StringMap.add name (ty, var_alloca) !named_values
                    | _ -> () 
                  in
                  bind_pat p f_val f_ty
              ) payload_pats
          | PVariant (variant_name, None) ->
              let variant_idx = List.mapi (fun i (m: enum_member) -> if m.name = variant_name then Some i else None) enum_decl.members |> List.find_map (fun x -> x) |> Option.get in
              add_case switch_inst (const_int i32_type variant_idx) arm_bb;
          | PWildcard -> ()
          | _ -> ());
          
          let arm_val = generate_expr arm_expr in
          (match result_alloca with
          | Some ptr -> ignore (build_store arm_val ptr builder)
          | None -> ());
          ignore (build_br merge_bb builder)
      ) arms;
      
      position_at_end default_bb builder;
      let wildcard_arm = List.find_opt (fun (p, _) -> p.item = PWildcard) arms in
      (match wildcard_arm with
      | Some (_, expr) -> 
          let v = generate_expr expr in
          (match result_alloca with
          | Some ptr -> ignore (build_store v ptr builder)
          | None -> ());
          ignore (build_br merge_bb builder)
      | None -> ignore (build_unreachable builder));
      
      position_at_end merge_bb builder;
      (match result_alloca with
      | Some ptr -> build_load ret_ty ptr "match_result" builder
      | None -> const_null i32_type)
      
  | EDup (_, inner) -> generate_expr inner
  | EOk (inner, _) -> generate_expr inner 
  | EErr (inner, _) -> generate_expr inner
  | EFormatStr (_, _parsed_ref) ->
      build_global_stringptr "FString Stub" "fstrtmp" builder
  | EComptime e_inner -> generate_expr e_inner
  | _ -> raise (CodegenError ("Unsupported expression in LLVM backend: " ^ Ast.show_expr_node e.item))

and generate_stmt (s: stmt) : unit =
  match s.item with
  | SExpr e -> ignore (generate_expr e)
  | SDecl d ->
      let init_val = generate_expr d.init in
      let init_type = generate_type (type_of_expr d.init) in
      let the_function = block_parent (insertion_block builder) in
      let rec bind_pat (p: pattern) v ty =
        match p.item with
        | PIdent name ->
            let alloca = create_entry_block_alloca the_function name ty in
            ignore (build_store v alloca builder);
            named_values := StringMap.add name (ty, alloca) !named_values
        | PTuple pats ->
            let alloca = create_entry_block_alloca the_function "tuple_pat" ty in
            ignore (build_store v alloca builder);
            List.iteri (fun i p_elem ->
                let f_ptr = build_struct_gep ty alloca i "gep" builder in
                let elem_ty = (struct_element_types ty).(i) in
                let f_val = build_load elem_ty f_ptr "f_val" builder in
                bind_pat p_elem f_val elem_ty
            ) pats
        | _ -> ()
      in
      bind_pat d.pat init_val init_type
  | SAssign ({ item = EVar name; _ }, e_right) ->
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

and generate_block (b: block) : llvalue option =
  List.iter generate_stmt b.stmts;
  match b.ret_expr with
  | Some e -> Some (generate_expr e)
  | None -> None

let generate_item (item: item) : unit =
  match item.item with
  | IStruct s -> struct_decls := StringMap.add s.name s !struct_decls
  | IEnum e -> enum_decls := StringMap.add e.name e !enum_decls
  | IGeneric (params, { item = IStruct s; _ }) -> generic_struct_decls := StringMap.add s.name (params, s) !generic_struct_decls
  | IGeneric (params, { item = IEnum e; _ }) -> generic_enum_decls := StringMap.add e.name (params, e) !generic_enum_decls
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
          let p_type = generate_type p_ast.typ in
          let alloca = create_entry_block_alloca the_function p_ast.name p_type in
          ignore (build_store p_val alloca builder);
          named_values := StringMap.add p_ast.name (p_type, alloca) !named_values
        ) (params the_function);
        
        (match f.body with
        | Some body ->
            let ret_val_opt = generate_block body in
            let last_bb = insertion_block builder in
            if block_terminator last_bb = None then (
              match ret_val_opt with
              | Some v -> ignore (build_ret v builder)
              | None ->
                  if ret_type = void_type then ignore (build_ret_void builder)
                  else ignore (build_ret (const_null ret_type) builder)
            )
        | None -> ());
        
        named_values := old_vars
      )
  | IGlobal g ->
      let init_val = generate_expr g.init in
      let init_type = generate_type g.typ in
      let g_var = define_global g.name init_val the_module in
      global_values := StringMap.add g.name (init_type, g_var) !global_values
  | _ -> ()

let generate_llvm (p: program) (_target_role: string) : llmodule =
  List.iter (fun (item: item) ->
    match item.item with
    | IStruct s -> struct_decls := StringMap.add s.name s !struct_decls
    | IEnum e -> enum_decls := StringMap.add e.name e !enum_decls
    | IGeneric (params, { item = IStruct s; _ }) -> generic_struct_decls := StringMap.add s.name (params, s) !generic_struct_decls
    | IGeneric (params, { item = IEnum e; _ }) -> generic_enum_decls := StringMap.add e.name (params, e) !generic_enum_decls
    | _ -> ()
  ) p.items;
  
  List.iter generate_item p.items;
  
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
