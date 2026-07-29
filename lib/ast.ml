type base_type =
  | TU8 | TU16 | TU32 | TU64
  | TI8 | TI16 | TI32 | TI64
  | TBool | TStr | TUnit
  | TCustom of string
[@@deriving show, eq]

type typ =
  | TBase of base_type
  | TResult of typ * typ
[@@deriving show, eq]

type binop =
  | Add | Sub | Mul | Div
  | Shl | Shr | BitAnd | BitOr
  | Eq | Neq | Lt | Gt | Lte | Gte
[@@deriving show, eq]

type literal =
  | LInt of int64 * base_type
  | LBool of bool
  | LStr of string
[@@deriving show, eq]

type pattern =
  | PWildcard
  | PIdent of string
  | PVariant of string * pattern list option
[@@deriving show, eq]

type var_kind = VLet | VVar | VConst
[@@deriving show, eq]

type expr =
  | ELit of literal
  | EVar of string
  | ECall of string * expr list
  | EPathCall of string list * expr list
  | EBinOp of expr * binop * expr
  | EIf of expr * block * block option
  | EOk of expr
  | EErr of expr
  | EStruct of string * (string * expr) list
  | EField of expr * string
  | EMatch of expr * (pattern * expr) list
[@@deriving show, eq]

and stmt =
  | SDecl of { kind: var_kind; name: string; typ: typ option; init: expr }
  | SAssign of string * expr
  | SExpr of expr
  | SWhile of expr * block
  | SFor of string * expr * block
[@@deriving show, eq]

and block = {
  stmts: stmt list;
  ret_expr: expr option;
}
[@@deriving show, eq]

type param = { name: string; typ: typ }
[@@deriving show, eq]

type fn_decl = {
  name: string;
  params: param list;
  ret_typ: typ;
  body: block;
}
[@@deriving show, eq]

type enum_member = {
  name: string;
  const_expr: expr option;
}
[@@deriving show, eq]

type enum_decl = {
  name: string;
  base_typ: base_type;
  iota_expr: expr;
  members: enum_member list;
}
[@@deriving show, eq]

type field = { name: string; typ: typ }
[@@deriving show, eq]

type struct_decl = {
  name: string;
  fields: field list;
}
[@@deriving show, eq]

type item =
  | IFn of fn_decl
  | IEnum of enum_decl
  | IStruct of struct_decl
[@@deriving show, eq]

type import_decl = {
  path: string list;
  alias: string option;
}
[@@deriving show, eq]

type program = {
  imports: import_decl list;
  items: item list;
}
[@@deriving show, eq]

