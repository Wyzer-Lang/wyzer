%{
open Ast
%}

%token <int64> INT
%token <bool> BOOL_VAL
%token <string> STRING_VAL
%token <string> IDENT

%token FN ENUM IMPORT AS IF ELSE WHILE FOR LET VAR CONST GLOBAL EXTERN IN MATCH RETURN TRANSFER RESULT OK ERR STRUCT UNDERSCORE IOTA GENERIC ROLE PUB
%token U8 U16 U32 U64 USIZE I8 I16 I32 I64 ISIZE BOOL STR
%token PLUS MINUS STAR SLASH SHL SHR BITAND BITOR AND OR NOT
%token EQEQ NEQ LT GT LTE GTE EQ FATARROW
%token LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET COMMA COLON SEMICOLON DOT COLONCOLON AT AT_EQ DOLLAR_EQ
%token EOF

%type <Ast.override_kind * Ast.expr> override

%left BITOR
%left BITAND
%left OR
%left AND
%left EQEQ NEQ LT GT LTE GTE
%left SHL SHR
%left PLUS MINUS
%left STAR SLASH
%left AS
%left DOT
%left LBRACKET
%nonassoc NOT UMINUS

%start <Ast.program> program
%%

%inline visibility:
  | PUB { true }
  | /* empty */ { false }

program:
  | imports=list(import_decl) items=list(item) EOF { { imports; items } }

import_decl:
  | IMPORT path=module_path alias=option(AS id=IDENT {id}) SEMICOLON { { path; alias } }

module_path:
  | id=IDENT { [id] }
  | id=IDENT COLONCOLON rest=module_path { id :: rest }

item:
  | f=fn_decl { IFn f }
  | e=enum_decl { IEnum e }
  | s=struct_decl { IStruct s }
  | v=visibility GLOBAL name=IDENT COLON t=typ EQ init=expr SEMICOLON { IGlobal { is_pub = v; name; typ = t; init } }
  | ROLE AT id=IDENT SEMICOLON { IRole { name = id; properties = [] } }
  | ROLE AT id=IDENT LBRACE props=separated_list(COMMA, field_init) RBRACE { IRole { name = id; properties = props } }
  | GENERIC LT params=separated_nonempty_list(COMMA, IDENT) GT i=item { IGeneric (params, i) }

struct_decl:
  | v=visibility STRUCT name=IDENT LBRACE fields=separated_list(COMMA, field) RBRACE { { is_pub = v; name; fields } }

field:
  | name=IDENT COLON typ=typ { ({ name; typ } : Ast.field) }

fn_decl:
  | v=visibility EXTERN FN name=IDENT LPAREN params=separated_list(COMMA, param) RPAREN role=option(AT r=IDENT {r}) ret=option(MINUS GT t=typ {t}) SEMICOLON
    { { is_pub = v; name; params; ret_typ = ret; role; is_extern = true; body = None } }
  | v=visibility FN name=IDENT LPAREN params=separated_list(COMMA, param) RPAREN role=option(AT r=IDENT {r}) ret=option(MINUS GT t=typ {t}) b=block
    { { is_pub = v; name; params; ret_typ = ret; role; is_extern = false; body = Some b } }

param:
  | name=IDENT COLON typ=typ { ({ name; typ } : Ast.param) }

typ:
  | b=base_type { TBase b }
  | b=base_type AT role=IDENT { TRole (TBase b, role) }
  | RESULT LT t1=typ COMMA t2=typ GT { TResult (t1, t2) }
  | RESULT LT t1=typ COMMA t2=typ GT AT role=IDENT { TRole (TResult (t1, t2), role) }
  | LBRACKET t=typ RBRACKET { TArray t }
  | LBRACKET t=typ RBRACKET AT role=IDENT { TRole (TArray t, role) }

base_type:
  | U8 { TU8 } | U16 { TU16 } | U32 { TU32 } | U64 { TU64 } | USIZE { TUSize }
  | I8 { TI8 } | I16 { TI16 } | I32 { TI32 } | I64 { TI64 } | ISIZE { TISize }
  | BOOL { TBool } | STR { TStr }
  | id=IDENT { TCustom id }
  | GENERIC LT args=separated_nonempty_list(COMMA, typ) GT t=base_type { TGenericApp (args, t) }

enum_decl:
  | v=visibility ENUM name=IDENT COLON base_typ=base_type LPAREN iota_expr=expr RPAREN LBRACE members=separated_list(COMMA, enum_member) RBRACE
    { { is_pub = v; name; base_typ; iota_expr; members } }

override:
  | AT_EQ e=expr { (Ast.IotaOverride, e) }
  | DOLLAR_EQ e=expr { (Ast.ValueOverride, e) }

enum_member:
  | name=IDENT ov=option(override) { { name; override = ov; computed_val = ref None } }

block:
  | LBRACE RBRACE { { stmts = []; ret_expr = None } }
  | LBRACE b=block_stmts RBRACE { b }

block_stmts:
  | e=expr { { stmts = []; ret_expr = Some e } }
  | s=stmt { { stmts = [s]; ret_expr = None } }
  | s=stmt b=block_stmts { { stmts = s :: b.stmts; ret_expr = b.ret_expr } }

stmt:
  | LET name=IDENT typ=option(COLON t=typ {t}) EQ init=expr SEMICOLON
    { SDecl { kind = VLet; name; typ; init } }
  | VAR name=IDENT typ=option(COLON t=typ {t}) EQ init=expr SEMICOLON
    { SDecl { kind = VVar; name; typ; init } }
  | CONST name=IDENT typ=option(COLON t=typ {t}) EQ init=expr SEMICOLON
    { SDecl { kind = VConst; name; typ; init } }
  | lhs=expr EQ e=expr SEMICOLON { SAssign (lhs, e) }
  | RETURN e=option(expr) SEMICOLON { SReturn e }
  | e=expr SEMICOLON { SExpr e }
  | WHILE cond=expr_no_struct b=block { SWhile (cond, b) }
  | FOR id=IDENT IN e=expr_no_struct b=block { SFor (id, e, b) }

expr:
  | e=expr_base(expr) { e }
  | path=module_path LBRACE fields=separated_list(COMMA, field_init) RBRACE { EStruct (List.hd (List.rev path), fields, None) }

expr_no_struct:
  | e=expr_base(expr_no_struct) { e }

expr_base(X):
  | NOT e=X { EUnOp (Not, e) }
  | MINUS e=X %prec UMINUS { EUnOp (Neg, e) }
  | e1=X PLUS e2=X { EBinOp (e1, Add, e2) }
  | e1=X MINUS e2=X { EBinOp (e1, Sub, e2) }
  | e1=X STAR e2=X { EBinOp (e1, Mul, e2) }
  | e1=X SLASH e2=X { EBinOp (e1, Div, e2) }
  | e1=X SHL e2=X { EBinOp (e1, Shl, e2) }
  | e1=X SHR e2=X { EBinOp (e1, Shr, e2) }
  | e1=X BITAND e2=X { EBinOp (e1, BitAnd, e2) }
  | e1=X BITOR e2=X { EBinOp (e1, BitOr, e2) }
  | e1=X AND e2=X { EBinOp (e1, And, e2) }
  | e1=X OR e2=X { EBinOp (e1, Or, e2) }
  | e1=X EQEQ e2=X { EBinOp (e1, Eq, e2) }
  | e1=X NEQ e2=X { EBinOp (e1, Neq, e2) }
  | e1=X LT e2=X { EBinOp (e1, Lt, e2) }
  | e1=X GT e2=X { EBinOp (e1, Gt, e2) }
  | e1=X LTE e2=X { EBinOp (e1, Lte, e2) }
  | e1=X GTE e2=X { EBinOp (e1, Gte, e2) }
  | e=X AS t=typ { ECast (e, t) }
  | OK LPAREN e=expr RPAREN { EOk (e, None) }
  | ERR LPAREN e=expr RPAREN { EErr (e, None) }
  | id1=IDENT COLONCOLON rest=module_path { EPathCall (id1 :: rest, []) }
  | IOTA { EVar "iota" }
  | IF cond=expr_no_struct thn=block els=option(ELSE e=else_branch {e}) { EIf (cond, thn, els) }
  | e=X DOT f=IDENT { EField (e, f) }
  | MATCH e=expr_no_struct LBRACE arms=nonempty_list(match_arm) RBRACE { EMatch (e, arms) }
  | path=module_path LPAREN args=separated_list(COMMA, expr) RPAREN
    { match path with
      | [id] -> ECall (id, args)
      | _ -> EPathCall (path, args) }
  | LBRACKET elems=separated_list(COMMA, expr) RBRACKET { EArray elems }
  | TRANSFER LPAREN e=expr COMMA r=IDENT RPAREN { ETransfer (e, r) }
  | e1=X LBRACKET e2=expr RBRACKET %prec LBRACKET { EIndex (e1, e2) }
  | GENERIC LT args=separated_nonempty_list(COMMA, typ) GT e=X { EGenericApp (args, e) }
  | l=literal { ELit l }
  | id=IDENT { EVar id }
  | LPAREN e=expr RPAREN { e }

field_init:
  | name=IDENT COLON e=expr { (name, e) }

match_arm:
  | p=pattern FATARROW e=expr COMMA { (p, e) }
  | p=pattern FATARROW e=expr { (p, e) }

variant_ident:
  | IDENT { $1 }
  | OK { "Ok" }
  | ERR { "Err" }

pattern:
  | UNDERSCORE { PWildcard }
  | IDENT { PIdent $1 }
  | OK { PVariant ("Ok", None) }
  | ERR { PVariant ("Err", None) }
  | v=variant_ident LPAREN args=separated_list(COMMA, pattern) RPAREN { PVariant (v, Some args) }

else_branch:
  | b=block { b }
  | IF cond=expr_no_struct thn=block els=option(ELSE e=else_branch {e}) { { stmts = []; ret_expr = Some (EIf (cond, thn, els)) } }
  | MATCH e=expr_no_struct LBRACE arms=nonempty_list(match_arm) RBRACE { { stmts = []; ret_expr = Some (EMatch (e, arms)) } }

literal:
  | v=INT t=option(int_suffix) { LInt (v, t) }
  | v=BOOL_VAL { LBool v }
  | v=STRING_VAL { LStr v }

int_suffix:
  | U8 { TU8 } | U16 { TU16 } | U32 { TU32 } | U64 { TU64 }
  | I8 { TI8 } | I16 { TI16 } | I32 { TI32 } | I64 { TI64 }
