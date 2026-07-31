open Ast
open Printf

let generate_type (t: typ) : string =
  match t with
  | TBase TU32 -> "uint32_t"
  | TBase TU64 -> "uint64_t"
  | TBase TI32 -> "int32_t"
  | TBase TI64 -> "int64_t"
  | TBase TBool -> "bool"
  | TBase TStr -> "char*"
  | TBase TUnit -> "void"
  | TBase (TCustom name) -> "struct " ^ name ^ "*"
  | TRole (_inner, _) -> (* Roles are erased in C *)
      let rec unwrap = function
        | TRole (i, _) -> unwrap i
        | other -> other
      in
      (match unwrap t with
       | TBase TU32 -> "uint32_t"
       | TBase TU64 -> "uint64_t"
       | TBase TI32 -> "int32_t"
       | TBase TI64 -> "int64_t"
       | TBase TBool -> "bool"
       | TBase TStr -> "char*"
       | TBase TUnit -> "void"
       | TBase (TCustom name) -> "struct " ^ name ^ "*"
       | _ -> "void*")
  | TBase (TGenericApp _) -> "void*"
  | _ -> "void*"

let rec generate_expr (e: expr) : string =
  match e with
  | ELit (LInt (i, _)) -> Int64.to_string i
  | ELit (LBool b) -> if b then "true" else "false"
  | ELit (LStr s) -> "\"" ^ String.escaped s ^ "\""
  | EVar name -> name
  | EPathVar path -> String.concat "_" path
  | EBinOp (e1, op, e2) ->
      let op_str = match op with
        | Add -> "+" | Sub -> "-" | Mul -> "*" | Div -> "/"
        | Eq -> "==" | Neq -> "!=" | Lt -> "<" | Gt -> ">" | Lte -> "<=" | Gte -> ">="
        | And -> "&&" | Or -> "||" | Shl -> "<<" | Shr -> ">>"
        | BitAnd -> "&" | BitOr -> "|"
      in
      sprintf "(%s %s %s)" (generate_expr e1) op_str (generate_expr e2)
  | EUnOp (Not, e) -> sprintf "!(%s)" (generate_expr e)
  | EUnOp (Neg, e) -> sprintf "-(%s)" (generate_expr e)
  | ECall (name, args) ->
      let arg_strs = List.map generate_expr args in
      sprintf "%s(%s)" name (String.concat ", " arg_strs)
  | EPathCall (path, args) ->
      let resolved = String.concat "_" path in
      let arg_strs = List.map generate_expr args in
      if resolved = "std_io_println" then
        sprintf "printf(\"%%s\\n\", %s)" (List.hd arg_strs) (* Hack for strings for now *)
      else if resolved = "std_io_print" then
        sprintf "printf(\"%%s\", %s)" (List.hd arg_strs)
      else
        sprintf "%s(%s)" resolved (String.concat ", " arg_strs)
  | EIf (cond, thn, els) ->
      let cond_str = generate_expr cond in
      let thn_str = generate_block thn in
      let els_str = match els with
        | Some eb -> " : ({" ^ generate_block eb ^ "})"
        | None -> " : ({(void)0;})"
      in
      sprintf "(%s ? ({%s}) %s)" cond_str thn_str els_str
  | EStruct (name, _fields, _) ->
      sprintf "wyzer_alloc_%s()" name (* Simplified *)
  | EField (obj, field) ->
      sprintf "%s->%s" (generate_expr obj) field
  | EDup (_name, e) -> generate_expr e
  | ENetSend (target, e) ->
      sprintf "wyzer_ipc_send(\"%s\", %s)" target (generate_expr e)
  | ENetRecv src ->
      sprintf "wyzer_ipc_recv(\"%s\")" src
  | ESizeOf _ | ETypeOf _ | EComptime _ -> failwith "sizeof/typeof/comptime should have been evaluated at compile-time"
  | _ -> "/* unimplemented expr */"

and generate_stmt (s: stmt) : string =
  match s with
  | SExpr e -> generate_expr e ^ ";"
  | SDecl d ->
      let typ_str = match d.typ with
        | Some t -> generate_type t
        | None -> "auto"
      in
      sprintf "%s %s = %s;" typ_str d.name (generate_expr d.init)
  | SAssign (e_left, e_right) ->
      sprintf "%s = %s;" (generate_expr e_left) (generate_expr e_right)
  | SReturn (Some e) ->
      sprintf "return %s;" (generate_expr e)
  | SReturn None ->
      "return;"
  | SWhile (cond, body) ->
      sprintf "while (%s) %s" (generate_expr cond) (generate_block body)
  | SDrop name -> sprintf "/* drop %s */;" name
  | _ -> "/* unimplemented stmt */"

and generate_block (b: block) : string =
  let stmts = List.map generate_stmt b.stmts in
  let ret = match b.ret_expr with
    | Some e -> generate_expr e ^ ";"
    | None -> ""
  in
  let all_stmts = stmts @ (if ret <> "" then [ret] else []) in
  String.concat "\n  " all_stmts

let generate_item (i: item) : string =
  match i with
  | IFn (f : fn_decl) ->
      let ret_str = match f.ret_typ with
        | Some t -> generate_type t
        | None -> "void"
      in
      let param_strs = List.map (fun (p: param) -> generate_type p.typ ^ " " ^ p.name) f.params in
      let fn_name = if f.name = "main" then "wyzer_main" else f.name in
      let sig_str = sprintf "%s %s(%s)" ret_str fn_name (String.concat ", " param_strs) in
      (match f.body with
       | Some b -> sig_str ^ " {\n  " ^ generate_block b ^ "\n}\n"
       | None -> sig_str ^ ";\n")
  | IStruct (s : struct_decl) ->
      let field_strs = List.map (fun (f: field) -> generate_type f.typ ^ " " ^ f.name ^ ";") s.fields in
      sprintf "struct %s {\n  uint32_t _rc;\n  %s\n};\n" s.name (String.concat "\n  " field_strs)
  | IEnum _e ->
      "/* Enums not fully implemented in C yet */\n"
  | IGlobal g ->
      sprintf "%s %s = %s;\n" (generate_type g.typ) g.name (generate_expr g.init)
  | _ -> ""

let c_header = "
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define wyzer_rc_inc(ptr) /* no-op for now */
#define wyzer_rc_dec(ptr) /* no-op for now */

void wyzer_ipc_send(const char* target, uint32_t val) {
    char filename[256];
    sprintf(filename, \"/tmp/wyzer_ipc_%s\", target);
    FILE* f = fopen(filename, \"w\");
    if (f) {
        fprintf(f, \"%u\\n\", val);
        fclose(f);
    }
}

uint32_t wyzer_ipc_recv(const char* src) {
    char filename[256];
    sprintf(filename, \"/tmp/wyzer_ipc_%s\", src);
    uint32_t val = 0;
    while (1) {
        FILE* f = fopen(filename, \"r\");
        if (f) {
            if (fscanf(f, \"%u\", &val) == 1) {
                fclose(f);
                remove(filename);
                return val;
            }
            fclose(f);
        }
    }
    return val;
}
"

let generate_c (p: program) (_role: string) : string =
  let items_str = List.map generate_item p.items |> String.concat "\n" in
  let main_func = "
int main() {
    wyzer_main();
    return 0;
}
" in
  c_header ^ "\n" ^ items_str ^ "\n" ^ main_func
