open Ast

module StringSet = Set.Make(String)

let get_role e =
  match Typechecker.ExprMap.find_opt Typechecker.typed_ast_map e with
  | Some (TRole (_, r)) -> Some r
  | _ -> None

let rec roles_in_expr e =
  match get_role e with
  | Some r -> StringSet.singleton r
  | None ->
      (match e with
      | ELit _ | EVar _ | EPathVar _ | ENetRecv _ -> StringSet.empty
      | ECall (_, args) | EPathCall (_, args) | EMethodCall (_, _, args, _) ->
          List.fold_left (fun acc arg -> StringSet.union acc (roles_in_expr arg)) StringSet.empty args
      | EUnOp (_, e) | EDup (_, e) | ECast (e, _) | EField (e, _) | EGenericApp (_, e) | ETyped (e, _) | ENetSend (_, e) | ETypeOf e | EComptime e -> roles_in_expr e
      | ESizeOf _ -> StringSet.empty
      | EBinOp (e1, _, e2) | EIndex (e1, e2) -> StringSet.union (roles_in_expr e1) (roles_in_expr e2)
      | EStruct (_, fields, _) ->
          List.fold_left (fun acc (_, fe) -> StringSet.union acc (roles_in_expr fe)) StringSet.empty fields
      | EArray items ->
          List.fold_left (fun acc fe -> StringSet.union acc (roles_in_expr fe)) StringSet.empty items
      | EIf (cond, thn, els) ->
          let c = roles_in_expr cond in
          let t = roles_in_block thn in
          let e_roles = match els with Some b -> roles_in_block b | None -> StringSet.empty in
          StringSet.union c (StringSet.union t e_roles)
      | ETransfer (inner, dest) ->
          StringSet.add dest (roles_in_expr inner)
      | EFormatStr (_, parsed_ref) ->
          List.fold_left (fun acc (e_inner, _) -> StringSet.union acc (roles_in_expr e_inner)) StringSet.empty !parsed_ref
      | EMatch (e, cases) ->
          let c = roles_in_expr e in
          List.fold_left (fun acc (_, ce) -> StringSet.union acc (roles_in_expr ce)) c cases
      | EOk (e, _) | EErr (e, _) -> roles_in_expr e)

and roles_in_stmt s =
  match s with
  | SDecl d -> roles_in_expr d.init
  | SAssign (lhs, rhs) -> StringSet.union (roles_in_expr lhs) (roles_in_expr rhs)
  | SExpr e -> roles_in_expr e
  | SWhile (cond, b) -> StringSet.union (roles_in_expr cond) (roles_in_block b)
  | SFor (_, it, b) -> StringSet.union (roles_in_expr it) (roles_in_block b)
  | SReturn (Some e) -> roles_in_expr e
  | SReturn None | SDrop _ -> StringSet.empty

and roles_in_block b =
  let stmt_roles = List.fold_left (fun acc s -> StringSet.union acc (roles_in_stmt s)) StringSet.empty b.stmts in
  match b.ret_expr with
  | Some e -> StringSet.union stmt_roles (roles_in_expr e)
  | None -> stmt_roles

let rec project_expr e target_role =
  let my_role = get_role e in
  match my_role with
  | Some r when r <> target_role && r <> "Global" && r <> "Poly" ->
      (* This expression belongs to another role, but check if it's a transfer targeting us *)
      (match e with
      | ETransfer (inner, dest) when dest = target_role ->
          let source_role = match get_role inner with | Some sr -> sr | None -> "Poly" in
          Some (ENetRecv source_role)
      | _ -> None)
  | _ ->
      (* It's our role or Poly. Project children *)
      (match e with
      | ELit _ | EVar _ | EPathVar _ -> Some e
      | ETransfer (inner, dest) ->
          if dest = target_role then
             let source_role = match get_role inner with | Some sr -> sr | None -> "Poly" in
             Some (ENetRecv source_role)
          else (
             match project_expr inner target_role with
             | Some p_inner -> Some (ENetSend (dest, p_inner))
             | None -> None
          )
      | ENetSend (r, inner) ->
          (match project_expr inner target_role with
          | Some p_inner -> Some (ENetSend (r, p_inner))
          | None -> None)
      | ENetRecv r -> Some (ENetRecv r)
      | ESizeOf _ | ETypeOf _ | EComptime _ -> failwith "sizeof/typeof/comptime should have been evaluated at compile-time"
      | EIf (cond, thn, els) ->
          let cond_role = match get_role cond with | Some r -> r | None -> "Poly" in
          if cond_role <> target_role && cond_role <> "Poly" then
            (* KNOWLEDGE OF CHOICE: We don't evaluate the condition, we RECEIVE it *)
            let p_thn_opt = project_block thn target_role in
            let p_els_opt = match els with Some b -> project_block b target_role | None -> None in
            (match p_thn_opt with
            | Some p_thn -> Some (EIf (ENetRecv cond_role, p_thn, p_els_opt))
            | None -> None)
          else
            (* We evaluate the condition. We must NOTIFY other roles if they have code in the blocks *)
            let p_cond = Option.value (project_expr cond target_role) ~default:cond in
            let p_thn = Option.value (project_block thn target_role) ~default:{stmts=[]; ret_expr=None} in
            let p_els = Option.value (match els with Some b -> project_block b target_role | None -> None) ~default:{stmts=[]; ret_expr=None} in
            
            let thn_roles = roles_in_block thn in
            let els_roles = match els with Some b -> roles_in_block b | None -> StringSet.empty in
            let other_roles = StringSet.remove target_role (StringSet.union thn_roles els_roles) in
            
            let notify_stmts v = 
              StringSet.elements other_roles |> List.map (fun r -> SExpr (ENetSend (r, ELit (LBool v))))
            in
            
            let final_thn = { p_thn with stmts = notify_stmts true @ p_thn.stmts } in
            let final_els = { p_els with stmts = notify_stmts false @ p_els.stmts } in
            
            Some (EIf (p_cond, final_thn, Some final_els))
      
      (* Standard AST traversal for other nodes *)
      | EBinOp (e1, op, e2) ->
          (match project_expr e1 target_role, project_expr e2 target_role with
          | Some p1, Some p2 -> Some (EBinOp (p1, op, p2))
          | _ -> None)
      | ECall (name, args) ->
          let p_args = List.filter_map (fun a -> project_expr a target_role) args in
          if List.length args > 0 && p_args = [] then None else Some (ECall (name, p_args))
      | EPathCall (path, args) ->
          let p_args = List.filter_map (fun a -> project_expr a target_role) args in
          if List.length args > 0 && p_args = [] then None else Some (EPathCall (path, p_args))
      | EFormatStr (s_ref, parsed_ref) ->
          let p_parsed = List.filter_map (fun (e_inner, lit) ->
            match project_expr e_inner target_role with
            | Some p -> Some (p, lit)
            | None -> None
          ) !parsed_ref in
          Some (EFormatStr (s_ref, ref p_parsed))
      | EUnOp (op, e1) -> Option.map (fun p -> EUnOp (op, p)) (project_expr e1 target_role)
      | EField (e1, f) -> Option.map (fun p -> EField (p, f)) (project_expr e1 target_role)
      | EArray items -> Some (EArray (List.filter_map (fun a -> project_expr a target_role) items))
      | EIndex (e1, e2) -> 
          (match project_expr e1 target_role, project_expr e2 target_role with
          | Some p1, Some p2 -> Some (EIndex (p1, p2))
          | _ -> None)
      | _ -> Some e) (* Fallback for others *)

and project_stmt s target_role =
  match s with
  | SDecl d ->
      (match project_expr d.init target_role with
      | Some p_init -> Some (SDecl { d with init = p_init })
      | None -> None)
  | SAssign (lhs, rhs) ->
      (match project_expr lhs target_role, project_expr rhs target_role with
      | Some p_lhs, Some p_rhs -> Some (SAssign (p_lhs, p_rhs))
      | _ -> None)
  | SExpr e ->
      (match project_expr e target_role with
      | Some p_e -> Some (SExpr p_e)
      | None -> None)
  | SReturn (Some e) ->
      (match project_expr e target_role with
      | Some p_e -> Some (SReturn (Some p_e))
      | None -> None)
  | SReturn None -> Some s
  | SWhile (cond, b) ->
      (match project_expr cond target_role, project_block b target_role with
      | Some p_cond, Some p_b -> Some (SWhile (p_cond, p_b))
      | _ -> None)
  | SFor (it, e, b) ->
      (match project_expr e target_role, project_block b target_role with
      | Some p_e, Some p_b -> Some (SFor (it, p_e, p_b))
      | _ -> None)
  | SDrop _ -> Some s

and project_block b target_role =
  let p_stmts = List.filter_map (fun s -> project_stmt s target_role) b.stmts in
  let p_ret = match b.ret_expr with
    | Some e -> project_expr e target_role
    | None -> None
  in
  if p_stmts = [] && p_ret = None then None
  else Some { stmts = p_stmts; ret_expr = p_ret }

let rec project_item target_role i =
  match i with
  | IFn f ->
      let role = Option.value f.role ~default:"Poly" in
      if role = target_role || role = "Poly" || role = "Global" then
        let p_body = match f.body with
          | Some b -> project_block b target_role
          | None -> None
        in
        Some (IFn { f with body = p_body })
      else None
  | IGlobal g ->
      let get_role_from_typ t =
        match t with
        | TRole (_, r) -> r
        | _ -> "Poly"
      in
      let r = get_role_from_typ g.typ in
      if r = target_role || r = "Global" || r = "Poly" then
        Some (IGlobal g)
      else None
  | IEnum _ | IStruct _ | IRole _ | ITrait _ | IImpl _ -> Some i
  | IGeneric (params, inner) ->
      (match project_item target_role inner with
      | Some p_inner -> Some (IGeneric (params, p_inner))
      | None -> None)
  | IMod _ -> Some i

let project_program p target_role =
  let p_items = List.filter_map (project_item target_role) p.items in
  { p with items = p_items }
