open Ast

module StringSet = Set.Make(String)

let rec free_vars_expr (e: expr) : StringSet.t =
  match e with
  | ELit _ -> StringSet.empty
  | EVar x -> StringSet.singleton x
  | ECall (_, args) | EPathCall (_, args) ->
      List.fold_left (fun acc arg -> StringSet.union acc (free_vars_expr arg)) StringSet.empty args
  | EBinOp (e1, _, e2) -> StringSet.union (free_vars_expr e1) (free_vars_expr e2)
  | EIf (cond, thn, els) ->
      let s1 = free_vars_expr cond in
      let s2 = free_vars_block thn in
      let s3 = match els with Some b -> free_vars_block b | None -> StringSet.empty in
      StringSet.union s1 (StringSet.union s2 s3)
  | EOk (e, _) | EErr (e, _) | EField (e, _) | EDup (_, e) -> free_vars_expr e
  | EStruct (_, fields, _) ->
      List.fold_left (fun acc (_, e) -> StringSet.union acc (free_vars_expr e)) StringSet.empty fields
  | EMatch (e, arms) ->
      let s1 = free_vars_expr e in
      let s2 = List.fold_left (fun acc (pat, e_arm) ->
        let bound = bound_vars_pat pat in
        let free_in_arm = StringSet.diff (free_vars_expr e_arm) bound in
        StringSet.union acc free_in_arm
      ) StringSet.empty arms in
      StringSet.union s1 s2
  | ECast (e, _) -> free_vars_expr e
  | EArray elems ->
      List.fold_left (fun acc elem -> StringSet.union acc (free_vars_expr elem)) StringSet.empty elems
  | EIndex (e, i) ->
      StringSet.union (free_vars_expr e) (free_vars_expr i)
  | ETransfer (e, _) -> free_vars_expr e

and bound_vars_pat (p: pattern) : StringSet.t =
  match p with
  | PWildcard -> StringSet.empty
  | PIdent x -> StringSet.singleton x
  | PVariant (_, Some args) -> List.fold_left (fun acc pat -> StringSet.union acc (bound_vars_pat pat)) StringSet.empty args
  | PVariant (_, None) -> StringSet.empty

and free_vars_stmt (s: stmt) : StringSet.t =
  match s with
  | SDecl { init; _ } -> free_vars_expr init
  | SAssign (lhs, e) -> StringSet.union (free_vars_expr lhs) (free_vars_expr e)
  | SExpr e -> free_vars_expr e
  | SWhile (cond, b) -> StringSet.union (free_vars_expr cond) (free_vars_block b)
  | SFor (_, e, b) -> StringSet.union (free_vars_expr e) (free_vars_block b)
  | SDrop _ -> StringSet.empty
  | SReturn (Some e) -> free_vars_expr e
  | SReturn None -> StringSet.empty

and free_vars_block (b: block) : StringSet.t =
  let stmts_free = List.fold_left (fun acc s -> StringSet.union acc (free_vars_stmt s)) StringSet.empty b.stmts in
  let ret_free = match b.ret_expr with Some e -> free_vars_expr e | None -> StringSet.empty in
  StringSet.union stmts_free ret_free

let rec transform_expr (live_out: StringSet.t) (e: expr) : expr =
  match e with
  | EStruct (name, fields, _) ->
      let find_candidate () =
        List.find_map (fun (_, fe) ->
          match fe with
          | EVar p when not (StringSet.mem p live_out) -> Some p
          | EField (EVar p, _) when not (StringSet.mem p live_out) -> Some p
          | _ -> None
        ) fields
      in
      let reuse = find_candidate () in
      let fields' = List.map (fun (f, fe) -> (f, transform_expr live_out fe)) fields in
      EStruct (name, fields', reuse)
  | EOk (inner, _) ->
      let inner' = transform_expr live_out inner in
      let reuse = match inner with
        | EVar p when not (StringSet.mem p live_out) -> Some p
        | EField (EVar p, _) when not (StringSet.mem p live_out) -> Some p
        | _ -> None
      in
      EOk (inner', reuse)
  | EErr (inner, _) ->
      let inner' = transform_expr live_out inner in
      let reuse = match inner with
        | EVar p when not (StringSet.mem p live_out) -> Some p
        | EField (EVar p, _) when not (StringSet.mem p live_out) -> Some p
        | _ -> None
      in
      EErr (inner', reuse)
  | EIf (cond, thn, els) ->
      EIf (transform_expr live_out cond, transform_block live_out thn, Option.map (transform_block live_out) els)
  | EMatch (match_e, arms) ->
      let new_arms = List.map (fun (pat, arm_e) -> (pat, transform_expr live_out arm_e)) arms in
      EMatch (transform_expr live_out match_e, new_arms)
  | ECast (e, t) -> ECast (transform_expr live_out e, t)
  | EArray elems -> EArray (List.map (transform_expr live_out) elems)
  | EIndex (e, i) -> EIndex (transform_expr live_out e, transform_expr live_out i)
  | ETransfer (e, role) -> ETransfer (transform_expr live_out e, role)
  | _ -> e (* other expressions don't currently have reuse tags *)

and transform_stmt (live_out: StringSet.t) (s: stmt) : stmt =
  match s with
  | SDecl d -> SDecl { d with init = transform_expr live_out d.init }
  | SAssign (lhs, e) -> SAssign (transform_expr live_out lhs, transform_expr live_out e)
  | SExpr e -> SExpr (transform_expr live_out e)
  | SWhile (cond, b) -> SWhile (transform_expr live_out cond, transform_block live_out b)
  | SFor (id, e, b) -> SFor (id, transform_expr live_out e, transform_block live_out b)
  | SDrop x -> SDrop x
  | SReturn e_opt -> SReturn (Option.map (transform_expr live_out) e_opt)

and transform_block (live_out: StringSet.t) (b: block) : block =
  (* Backwards pass to compute liveness and insert drops for locally declared vars *)
  let rec process_stmts stmts current_live acc_stmts locally_declared =
    match stmts with
    | [] -> (acc_stmts, current_live, locally_declared)
    | s :: rest ->
        let (rest_stmts, next_live, locals) = process_stmts rest current_live acc_stmts locally_declared in
        let s' = transform_stmt next_live s in
        let s_free = free_vars_stmt s in
        let new_live = StringSet.union next_live s_free in
        
        let new_locals = match s with
          | SDecl d -> StringSet.add d.name locals
          | _ -> locals
        in
        
        (* If this was a decl, it's no longer live before this statement *)
        let new_live = match s with
          | SDecl d -> StringSet.remove d.name new_live
          | _ -> new_live
        in
        
        (s' :: rest_stmts, new_live, new_locals)
  in
  
  let ret_expr' = Option.map (transform_expr live_out) b.ret_expr in
  let ret_live = match b.ret_expr with
    | Some e -> StringSet.union live_out (free_vars_expr e)
    | None -> live_out
  in
  
  let (stmts', _, locally_declared) = process_stmts b.stmts ret_live [] StringSet.empty in
  
  let drops = StringSet.fold (fun var acc ->
    if not (StringSet.mem var ret_live) then SDrop var :: acc else acc
  ) locally_declared [] in
  
  { stmts = stmts' @ drops; ret_expr = ret_expr' }

let transform_item (i: item) : item =
  match i with
  | IFn f -> IFn { f with body = Option.map (transform_block StringSet.empty) f.body }
  | _ -> i

let transform_program (p: program) : program =
  { p with items = List.map transform_item p.items }
