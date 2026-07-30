
(* The type of tokens. *)

type token = 
  | WHILE
  | VAR
  | USIZE
  | UNDERSCORE
  | U8
  | U64
  | U32
  | U16
  | TRANSFER
  | TRAIT
  | STRUCT
  | STRING_VAL of (string)
  | STR
  | STAR
  | SLASH
  | SHR
  | SHL
  | SEMICOLON
  | RPAREN
  | ROLE
  | RETURN
  | RESULT
  | RBRACKET
  | RBRACE
  | PUB
  | PLUS
  | OR
  | OK
  | NOT
  | NEQ
  | MINUS
  | MATCH
  | LTE
  | LT
  | LPAREN
  | LET
  | LBRACKET
  | LBRACE
  | ISIZE
  | IOTA
  | INT of (int64)
  | IN
  | IMPORT
  | IMPL
  | IF
  | IDENT of (string)
  | I8
  | I64
  | I32
  | I16
  | GTE
  | GT
  | GLOBAL
  | GENERIC
  | FSTRING_VAL of (string)
  | FOR
  | FN
  | FATARROW
  | EXTERN
  | ERR
  | EQEQ
  | EQ
  | EOF
  | ENUM
  | ELSE
  | DOT
  | DOLLAR_EQ
  | CONST
  | COMMA
  | COLONCOLON
  | COLON
  | BOOL_VAL of (bool)
  | BOOL
  | BITOR
  | BITAND
  | AT_EQ
  | AT
  | AS
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val standalone_expr: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expr)

val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)
