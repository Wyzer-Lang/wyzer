type base_type =
  | TU8 | TU16 | TU32 | TU64 | TUSize
  | TI8 | TI16 | TI32 | TI64 | TISize
  | TBool | TStr | TUnit
  | TCustom of string
  | TGenericApp of typ list * base_type
[@@deriving show, eq]

and typ =
  | TBase of base_type
  | TResult of typ * typ
  | TRole of typ * string
  | TArray of typ
[@@deriving show, eq]

type binop =
  | Add | Sub | Mul | Div
  | Shl | Shr | BitAnd | BitOr
  | And | Or
  | Eq | Neq | Lt | Gt | Lte | Gte
[@@deriving show, eq]

type unop =
  | Not | Neg
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
  | PLit of literal
[@@deriving show, eq]

type var_kind = VLet | VVar | VConst
[@@deriving show, eq]

type expr =
  | ELit of literal
  | EVar of string
  | EPathVar of string list
  | ECall of string * expr list
  | EPathCall of string list * expr list
  | EUnOp of unop * expr
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
  | EFormatStr of string ref * (expr * string) list ref
  | EGenericApp of typ list * expr
  | EMethodCall of expr * string * expr list * string option ref
  | ETyped of expr * typ
  | ENetSend of string * expr
  | ENetRecv of string
  | ESizeOf of typ
  | ETypeOf of expr
  | EComptime of expr
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
  is_pub: bool;
  name: string;
  params: param list;
  ret_typ: typ option;
  role: string option;
  is_extern: bool;
  body: block option;
}
[@@deriving show, eq]

type fn_sig = {
  name: string;
  params: param list;
  ret_typ: typ option;
}
[@@deriving show, eq]

type override_kind =
  | IotaOverride
  | ValueOverride
[@@deriving show, eq]

type enum_member = {
  name: string;
  payload: typ list;
  override: (override_kind * expr) option;
  computed_val: int64 option ref;
}
[@@deriving show, eq]

type enum_decl = {
  is_pub: bool;
  name: string;
  base_typ: base_type;
  iota_expr: expr;
  members: enum_member list;
}
[@@deriving show, eq]

type field = { name: string; typ: typ }
[@@deriving show, eq]

type struct_decl = {
  is_pub: bool;
  name: string;
  fields: field list;
}
[@@deriving show, eq]

type role_decl = {
  name: string;
  properties: (string * expr) list;
}
[@@deriving show, eq]

type trait_decl = {
  is_pub: bool;
  name: string;
  methods: fn_sig list;
}
[@@deriving show, eq]

type impl_decl = {
  trait_name: string;
  for_typ: typ;
  methods: fn_decl list;
}
[@@deriving show, eq]

type mod_decl = {
  is_pub: bool;
  name: string;
}
[@@deriving show, eq]

type item =
  | IFn of fn_decl
  | IEnum of enum_decl
  | IStruct of struct_decl
  | IGlobal of { is_pub: bool; name: string; typ: typ; init: expr }
  | IGeneric of string list * item
  | IRole of role_decl
  | ITrait of trait_decl
  | IImpl of impl_decl
  | IMod of mod_decl
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

