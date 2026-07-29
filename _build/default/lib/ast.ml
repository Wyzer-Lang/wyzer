type base_type =
  | TU8 | TU16 | TU32 | TU64
  | TI8 | TI16 | TI32 | TI64
  | TBool | TStr | TUnit
  | TCustom of string
[@@deriving show, eq]

type typ =
  | TBase of base_type
  | TResult of typ * typ
  | TRole of typ * string
  | TArray of typ
[@@deriving show, eq]

type binop =
  | Add | Sub | Mul | Div
  | Shl | Shr | BitAnd | BitOr
  | Eq | Neq | Lt | Gt | Lte | Gte
[@@deriving show, eq]

type literal =
  | LInt of int64 * base_type option
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
  | EOk of expr * string option
  | EErr of expr * string option
  | EStruct of string * (string * expr) list * string option
  | EField of expr * string
  | EMatch of expr * (pattern * expr) list
  | EDup of string * expr
  | ECast of expr * typ
  | EArray of expr list
  | EIndex of expr * expr
  | ETransfer of expr * string
[@@deriving show, eq]

and stmt =
  | SDecl of { kind: var_kind; name: string; typ: typ option; init: expr }
  | SAssign of expr * expr
  | SExpr of expr
  | SWhile of expr * block
  | SFor of string * expr * block
  | SDrop of string
  | SReturn of expr option
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
  ret_typ: typ option;
  role: string option;
  is_extern: bool;
  body: block option;
}
[@@deriving show, eq]

type enum_member = {
  name: string;
  explicit_val: expr option;
  computed_val: Int64.t option ref;
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
  | IGlobal of { name: string; typ: typ; init: expr }
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

