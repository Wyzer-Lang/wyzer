{
open Parser
exception SyntaxError of string
}

let white = [' ' '\t' '\r']+
let newline = '\n'
let digit = ['0'-'9']
let letter = ['a'-'z' 'A'-'Z' '_']
let ident = letter (letter | digit)*

rule read = parse
  | white { read lexbuf }
  | newline { Lexing.new_line lexbuf; read lexbuf }
  | "//" [^ '\n']* { read lexbuf }
  | "fn" { FN }
  | "enum" { ENUM }
  | "import" { IMPORT }
  | "as" { AS }
  | "if" { IF }
  | "else" { ELSE }
  | "while" { WHILE }
  | "for" { FOR }
  | "let" { LET }
  | "var" { VAR }
  | "const" { CONST }
  | "global" { GLOBAL }
  | "extern" { EXTERN }
  | "in" { IN }
  | "match" { MATCH }
  | "return" { RETURN }
  | "transfer" { TRANSFER }
  | "struct" { STRUCT }
  | "Result" { RESULT }
  | "Ok" { OK }
  | "Err" { ERR }
  | "iota" { IOTA }
  | "_" { UNDERSCORE }
  | "u8" { U8 } | "u16" { U16 } | "u32" { U32 } | "u64" { U64 }
  | "i8" { I8 } | "i16" { I16 } | "i32" { I32 } | "i64" { I64 }
  | "bool" { BOOL } | "str" { STR }
  | "true" { BOOL_VAL true }
  | "false" { BOOL_VAL false }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*" { STAR }
  | "/" { SLASH }
  | "<<" { SHL }
  | ">>" { SHR }
  | "&" { BITAND }
  | "|" { BITOR }
  | "==" { EQEQ }
  | "!=" { NEQ }
  | "<=" { LTE }
  | ">=" { GTE }
  | "<" { LT }
  | ">" { GT }
  | "=" { EQ }
  | "=>" { FATARROW }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | "{" { LBRACE }
  | "}" { RBRACE }
  | "[" { LBRACKET }
  | "]" { RBRACKET }
  | "," { COMMA }
  | ":" { COLON }
  | ";" { SEMICOLON }
  | "." { DOT }
  | "::" { COLONCOLON }
  | "@" { AT }
  | "@=" { AT_EQ }
  | "$=" { DOLLAR_EQ }
  | digit+ as n { INT (Int64.of_string n) }
  | '"' { read_string (Buffer.create 17) lexbuf }
  | ident as id { IDENT id }
  | _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf)) }
  | eof { EOF }

and read_string buf = parse
  | '"'       { STRING_VAL (Buffer.contents buf) }
  | '\\' '/'  { Buffer.add_char buf '/'; read_string buf lexbuf }
  | '\\' '\\' { Buffer.add_char buf '\\'; read_string buf lexbuf }
  | '\\' 'b'  { Buffer.add_char buf '\b'; read_string buf lexbuf }
  | '\\' 'f'  { Buffer.add_char buf '\012'; read_string buf lexbuf }
  | '\\' 'n'  { Buffer.add_char buf '\n'; read_string buf lexbuf }
  | '\\' 'r'  { Buffer.add_char buf '\r'; read_string buf lexbuf }
  | '\\' 't'  { Buffer.add_char buf '\t'; read_string buf lexbuf }
  | [^ '"' '\\']+
    { Buffer.add_string buf (Lexing.lexeme lexbuf);
      read_string buf lexbuf
    }
  | _ { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError ("String is not terminated")) }
