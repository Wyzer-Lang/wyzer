type token =
  | INT of int64
  | FLOAT of float
  | BOOL_VAL of bool
  | STRING_VAL of string
  | FSTRING_VAL of string
  | CHAR_VAL of char
  | IDENT of string
  | FN | ENUM | IMPORT | AS | IF | ELSE | WHILE | FOR | LET | VAR | CONST | GLOBAL | EXTERN | IN | MATCH | RETURN | TRANSFER | RESULT | OK | ERR | STRUCT | UNDERSCORE | IOTA | GENERIC | ROLE | PUB | TRAIT | IMPL | MOD | SIZEOF | TYPEOF
  | U8 | U16 | U32 | U64 | U128 | USIZE | I8 | I16 | I32 | I64 | I128 | ISIZE | BOOL | STR | CHAR
  | F8 | F16 | F32 | F64 | F128
  | PLUS | MINUS | STAR | SLASH | SHL | SHR | BITAND | BITOR | AND | OR | NOT
  | EQEQ | NEQ | LT | GT | LTE | GTE | EQ | FATARROW | PLUS_EQ | MINUS_EQ | STAR_EQ | SLASH_EQ
  | LPAREN | RPAREN | LBRACE | RBRACE | LBRACKET | RBRACKET | COMMA | COLON | SEMICOLON | DOT | COLONCOLON | AT | AT_EQ | DOLLAR_EQ
  | EOF
[@@deriving show, eq]

(** Human-readable token display (used in diagnostics). *)
let show_token_human = function
  | INT v    -> Printf.sprintf "%Ld" v
  | FLOAT f  -> Printf.sprintf "%g" f
  | BOOL_VAL b -> string_of_bool b
  | STRING_VAL s -> Printf.sprintf "\"%s\"" s
  | FSTRING_VAL s -> Printf.sprintf "f\"%s\"" s
  | CHAR_VAL c -> Printf.sprintf "'%c'" c
  | IDENT s  -> s
  | FN -> "fn" | ENUM -> "enum" | IMPORT -> "import" | AS -> "as"
  | IF -> "if" | ELSE -> "else" | WHILE -> "while" | FOR -> "for"
  | LET -> "let" | VAR -> "var" | CONST -> "const" | GLOBAL -> "global"
  | EXTERN -> "extern" | IN -> "in" | MATCH -> "match" | RETURN -> "return"
  | TRANSFER -> "transfer" | RESULT -> "Result" | OK -> "Ok" | ERR -> "Err"
  | STRUCT -> "struct" | UNDERSCORE -> "_" | IOTA -> "iota"
  | GENERIC -> "generic" | ROLE -> "role" | PUB -> "pub"
  | TRAIT -> "trait" | IMPL -> "impl" | MOD -> "mod"
  | SIZEOF -> "sizeof" | TYPEOF -> "typeof"
  | U8->"u8"|U16->"u16"|U32->"u32"|U64->"u64"|U128->"u128"|USIZE->"usize"
  | I8->"i8"|I16->"i16"|I32->"i32"|I64->"i64"|I128->"i128"|ISIZE->"isize"
  | F8->"f8"|F16->"f16"|F32->"f32"|F64->"f64"|F128->"f128"
  | BOOL->"bool"|STR->"str"|CHAR->"char"
  | PLUS->"+"|MINUS->"-"|STAR->"*"|SLASH->"/"|SHL->"<<"|SHR->">>"|BITAND->"&"|BITOR->"|"
  | AND->"&&"|OR->"||"|NOT->"!"
  | EQEQ->"=="|NEQ->"!="|LT->"<"|GT->">"|LTE->"<="|GTE->">="
  | EQ->"="|FATARROW->"=>"|PLUS_EQ->"+="|MINUS_EQ->"-="|STAR_EQ->"*="|SLASH_EQ->"/="
  | LPAREN->"("|RPAREN->")"|LBRACE->"{"|RBRACE->"}"|LBRACKET->"["|RBRACKET->"]"
  | COMMA->","|COLON->":"|SEMICOLON->";"|DOT->"."|COLONCOLON->"::"|AT->"@"
  | AT_EQ->"@="|DOLLAR_EQ->"$="|EOF->"<eof>"
