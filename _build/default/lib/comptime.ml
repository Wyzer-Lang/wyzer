open Ast
open Eval

let rec val_to_expr (v: value) : expr =
  match v with
  | VUnit -> EStruct ("Unit", [], None)
  | VInt i -> ELit (LInt (i, None))
  | VBool b -> ELit (LBool b)
  | VStr s -> ELit (LStr s)
  | VArray arr -> EArray (Array.to_list (Array.map val_to_expr arr))
  | VFormatStr (s, pieces) ->
      let mapped = List.map (fun (v, lit) -> (val_to_expr v, lit)) pieces in
      EFormatStr (ref s, ref mapped)
  | VPtr _ -> failwith "Returning heap-allocated structs/enums from @Compiler is not yet supported in val_to_expr"

let rec transform_expr env e =
  match e with
  | ETransfer (inner, "Compiler") ->
      (* EVALUATE AT COMPILE TIME! *)
      let v = Eval.eval_expr env inner in
      val_to_expr v
  | ETransfer (inner, role) -> ETransfer (transform_expr env inner, role)
  | ECall (name, args) -> ECall (name, List.map (transform_expr env) args)
  | EPathCall (path, args) -> EPathCall (path, List.map (transform_expr env) args)
  | EBinOp (e1, op, e2) -> EBinOp (transform_expr env e1, op, transform_expr env e2)
  | EUnOp (op, e1) -> EUnOp (op, transform_expr env e1)
  | EIf (cond, thn, els) ->
      EIf (transform_expr env cond, transform_block env thn, Option.map (transform_block env) els)
  | EOk (e1, r) -> EOk (transform_expr env e1, r)
  | EErr (e1, r) -> EErr (transform_expr env e1, r)
  | EStruct (name, fields, t) ->
      EStruct (name, List.map (fun (n, e) -> (n, transform_expr env e)) fields, t)
  | EField (e1, f) -> EField (transform_expr env e1, f)
  | EArray items -> EArray (List.map (transform_expr env) items)
  | EIndex (arr, idx) -> EIndex (transform_expr env arr, transform_expr env idx)
  | EMatch (e1, arms) ->
      EMatch (transform_expr env e1, List.map (fun (p, e2) -> (p, transform_expr env e2)) arms)
  | EDup (t, e1) -> EDup (t, transform_expr env e1)
  | ECast (e1, t) -> ECast (transform_expr env e1, t)
  | EGenericApp (targs, e1) -> EGenericApp (targs, transform_expr env e1)
  | EMethodCall (obj, method_name, args, resolved_name_ref) ->
      (match !resolved_name_ref with
      | Some mangled_name -> ECall (mangled_name, List.map (transform_expr env) (obj :: args))
      | None -> failwith ("Method call " ^ method_name ^ " was not resolved by typechecker!"))
  | EFormatStr (s_ref, parsed_ref) ->
      let new_parsed = List.map (fun (e_inner, lit) -> (transform_expr env e_inner, lit)) !parsed_ref in
      EFormatStr (s_ref, ref new_parsed)
  | ELit _ | EVar _ | EPathVar _ -> e

and transform_stmt env s =
  match s with
  | SDecl d -> SDecl { d with init = transform_expr env d.init }
  | SAssign (e1, e2) -> SAssign (transform_expr env e1, transform_expr env e2)
  | SExpr e1 -> SExpr (transform_expr env e1)
  | SWhile (cond, b) -> SWhile (transform_expr env cond, transform_block env b)
  | SFor (name, iter, b) -> SFor (name, transform_expr env iter, transform_block env b)
  | SReturn (Some e1) -> SReturn (Some (transform_expr env e1))
  | SDrop _ | SReturn None -> s

and transform_block env b =
  { stmts = List.map (transform_stmt env) b.stmts;
    ret_expr = Option.map (transform_expr env) b.ret_expr }

let transform_item env i =
  match i with
  | IFn f ->
      let new_body = Option.map (transform_block env) f.body in
      IFn { f with body = new_body }
  | IGlobal g -> IGlobal { g with init = transform_expr env g.init }
  | IGeneric (params, inner) -> IGeneric (params, inner) (* Ignoring generics for now, might need deep map *)
  | _ -> i

let transform_program (p: program) : program =
  let env = Eval.build_env p in
  { p with items = List.map (transform_item env) p.items }
