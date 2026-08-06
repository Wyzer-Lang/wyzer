{
open Token
exception SyntaxError of string
}

let white = [' ' '\t' '\r']+
let newline = '\n'
let digit   = ['0'-'9']
let letter  = ['a'-'z' 'A'-'Z' '_']
let ident   = letter (letter | digit)*
let float_lit = digit+ '.' digit* | '.' digit+
let hex_lit = '0' ['x' 'X'] ['0'-'9' 'a'-'f' 'A'-'F']+
let bin_lit = '0' ['b' 'B'] ['0' '1']+

rule read = parse
  | white { read lexbuf }
  | newline { Lexing.new_line lexbuf; read lexbuf }
  | "//" [^ '\n']* { read lexbuf }
  | "fn" { FN }
  | "trait" { TRAIT }
  | "impl" { IMPL }
  | "pub" { PUB }
  | "mod" { MOD }
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
  | "generic" { GENERIC }
  | "in" { IN }
  | "match" { MATCH }
  | "return" { RETURN }
  | "transfer" { TRANSFER }
  | "struct" { STRUCT }
  | "role" { ROLE }
  | "Result" { RESULT }
  | "Ok" { OK }
  | "Err" { ERR }
  | "iota" { IOTA }
  | "sizeof" { SIZEOF }
  | "typeof" { TYPEOF }
  | "_" { UNDERSCORE }
  | "u8" { U8 } | "u16" { U16 } | "u32" { U32 } | "u64" { U64 } | "u128" { U128 }
  | "usize" { USIZE }
  | "isize" { ISIZE }
  | "i8" { I8 } | "i16" { I16 } | "i32" { I32 } | "i64" { I64 } | "i128" { I128 }
  | "f16" { F16 } | "f32" { F32 } | "f64" { F64 } | "f128" { F128 }
  | "bool" { BOOL } | "str" { STR } | "char" { CHAR }
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
  | "&&" { AND }
  | "||" { OR }
  | "!" { NOT }
  | "==" { EQEQ }
  | "!=" { NEQ }
  | "<=" { LTE }
  | ">=" { GTE }
  | "<" { LT }
  | ">" { GT }
  | "+=" { PLUS_EQ }
  | "-=" { MINUS_EQ }
  | "*=" { STAR_EQ }
  | "/=" { SLASH_EQ }
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
  | float_lit as f { FLOAT (float_of_string f) }
  | hex_lit as h { INT (Int64.of_string h) }
  | bin_lit as b { INT (Int64.of_string b) }
  | digit+ as n { INT (Int64.of_string n) }
  | '"' { read_string (Buffer.create 17) lexbuf }
  | "f\"" { read_fstring (Buffer.create 17) lexbuf }
  | '\'' { read_char lexbuf }
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
  | '\\' 'e'  { Buffer.add_char buf '\027'; read_string buf lexbuf }
  | '\\' 'x' ['0'-'9' 'a'-'f' 'A'-'F'] ['0'-'9' 'a'-'f' 'A'-'F'] as hex
      { let code = int_of_string ("0x" ^ String.sub hex 2 2) in
        Buffer.add_char buf (Char.chr code); read_string buf lexbuf }
  | [^ '"' '\\']+
    { Buffer.add_string buf (Lexing.lexeme lexbuf);
      read_string buf lexbuf
    }
  | _ { raise (SyntaxError ("Illegal string character: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError ("String is not terminated")) }

and read_fstring buf = parse
  | '"'       { FSTRING_VAL (Buffer.contents buf) }
  | '\\' '"'  { Buffer.add_char buf '"'; read_fstring buf lexbuf }
  | '\\' '{'  { Buffer.add_char buf '{'; read_fstring buf lexbuf }
  | '\\' '}'  { Buffer.add_char buf '}'; read_fstring buf lexbuf }
  | '\\' '\\' { Buffer.add_char buf '\\'; read_fstring buf lexbuf }
  | '\\' 'n'  { Buffer.add_char buf '\n'; read_fstring buf lexbuf }
  | '\\' 'r'  { Buffer.add_char buf '\r'; read_fstring buf lexbuf }
  | '\\' 't'  { Buffer.add_char buf '\t'; read_fstring buf lexbuf }
  | [^ '"' '\\']+
    { Buffer.add_string buf (Lexing.lexeme lexbuf);
      read_fstring buf lexbuf
    }
  | _ { raise (SyntaxError ("Illegal f-string character: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError ("f-string is not terminated")) }

and read_char = parse
  | '\\' 'n' '\'' { CHAR_VAL '\n' }
  | '\\' 'r' '\'' { CHAR_VAL '\r' }
  | '\\' 't' '\'' { CHAR_VAL '\t' }
  | '\\' '\\' '\'' { CHAR_VAL '\\' }
  | '\\' '\'' '\'' { CHAR_VAL '\'' }
  | [^ '\\' '\''] '\'' as s { CHAR_VAL s.[0] }
  | _ { raise (SyntaxError ("Invalid char literal: " ^ Lexing.lexeme lexbuf)) }
  | eof { raise (SyntaxError "Unterminated char literal") }
