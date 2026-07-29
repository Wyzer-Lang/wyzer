
(* The type of tokens. *)

type token = 
  | WHILE
  | VAR
  | UNDERSCORE
  | U8
  | U64
  | U32
  | U16
  | STRUCT
  | STRING_VAL of (string)
  | STR
  | STAR
  | SLASH
  | SHR
  | SHL
  | SEMICOLON
  | RPAREN
  | RESULT
  | RBRACE
  | PLUS
  | OK
  | NEQ
  | MINUS
  | MATCH
  | LTE
  | LT
  | LPAREN
  | LET
  | LBRACE
  | INT of (int64)
  | IN
  | IMPORT
  | IF
  | IDENT of (string)
  | I8
  | I64
  | I32
  | I16
  | GTE
  | GT
  | FOR
  | FN
  | FATARROW
  | ERR
  | EQEQ
  | EQ
  | EOF
  | ENUM
  | ELSE
  | DOT
  | CONST
  | COMMA
  | COLONCOLON
  | COLON
  | BOOL_VAL of (bool)
  | BOOL
  | BITOR
  | BITAND
  | AT
  | AS

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.program)
