open Ast

let rec project_item (target_role: string) (i: item) : item option =
  match i with
  | IFn f ->
      let role = Option.value f.role ~default:"Poly" in
      if role = target_role || role = "Poly" || role = "Global" then
        Some (IFn f)
      else None
  | IGlobal g ->
      (* For globals, we need to extract their role from the type.
         If the type is TRole(_, r), we check if r matches.
         If it doesn't have a TRole (e.g., just u32), it belongs to Poly or Global?
         Actually, in Wyzer, top-level globals usually require an explicit role. 
         But let's assume if it has no role, it's Poly. *)
      let get_role_from_typ t =
        match t with
        | TRole (_, r) -> r
        | _ -> "Poly"
      in
      let r = get_role_from_typ g.typ in
      if r = target_role || r = "Global" || r = "Poly" then
        Some (IGlobal g)
      else None
  | IEnum _ | IStruct _ | IRole _ ->
      (* Type definitions and topology declarations are shared globally across all nodes *)
      Some i
  | IGeneric (params, inner) ->
      (match project_item target_role inner with
      | Some p_inner -> Some (IGeneric (params, p_inner))
      | None -> None)

let project_program (p: program) (target_role: string) : program =
  let projected_items = List.filter_map (project_item target_role) p.items in
  { p with items = projected_items }
