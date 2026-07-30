
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
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
    | STRING_VAL of 
# 7 "lib/parser.mly"
       (string)
# 26 "lib/parser.ml"
  
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
    | INT of 
# 5 "lib/parser.mly"
       (int64)
# 59 "lib/parser.ml"
  
    | IN
    | IMPORT
    | IMPL
    | IF
    | IDENT of 
# 9 "lib/parser.mly"
       (string)
# 68 "lib/parser.ml"
  
    | I8
    | I64
    | I32
    | I16
    | GTE
    | GT
    | GLOBAL
    | GENERIC
    | FSTRING_VAL of 
# 8 "lib/parser.mly"
       (string)
# 81 "lib/parser.ml"
  
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
    | BOOL_VAL of 
# 6 "lib/parser.mly"
       (bool)
# 102 "lib/parser.ml"
  
    | BOOL
    | BITOR
    | BITAND
    | AT_EQ
    | AT
    | AS
    | AND
  
end

include MenhirBasics

# 1 "lib/parser.mly"
  
open Ast

# 120 "lib/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState000 : ('s, _menhir_box_program) _menhir_state
    (** State 000.
        Stack shape : <empty>.
        Start symbol: program. *)

  | MenhirState001 : (('s, _menhir_box_program) _menhir_cell1_IMPORT, _menhir_box_program) _menhir_state
    (** State 001.
        Stack shape : IMPORT.
        Start symbol: program. *)

  | MenhirState004 : (('s, 'r) _menhir_cell1_IDENT, 'r) _menhir_state
    (** State 004.
        Stack shape : IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState014 : (('s, _menhir_box_program) _menhir_cell1_list_import_decl_, _menhir_box_program) _menhir_state
    (** State 014.
        Stack shape : list(import_decl).
        Start symbol: program. *)

  | MenhirState017 : (('s, _menhir_box_program) _menhir_cell1_TRAIT _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 017.
        Stack shape : TRAIT IDENT.
        Start symbol: program. *)

  | MenhirState020 : (('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 020.
        Stack shape : FN IDENT.
        Start symbol: program. *)

  | MenhirState022 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 022.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState030 : (('s, 'r) _menhir_cell1_RESULT, 'r) _menhir_state
    (** State 030.
        Stack shape : RESULT.
        Start symbol: <undetermined>. *)

  | MenhirState031 : (('s, 'r) _menhir_cell1_LBRACKET, 'r) _menhir_state
    (** State 031.
        Stack shape : LBRACKET.
        Start symbol: <undetermined>. *)

  | MenhirState039 : (('s, 'r) _menhir_cell1_GENERIC, 'r) _menhir_state
    (** State 039.
        Stack shape : GENERIC.
        Start symbol: <undetermined>. *)

  | MenhirState042 : (('s, 'r) _menhir_cell1_typ, 'r) _menhir_state
    (** State 042.
        Stack shape : typ.
        Start symbol: <undetermined>. *)

  | MenhirState048 : ((('s, 'r) _menhir_cell1_GENERIC, 'r) _menhir_cell1_separated_nonempty_list_COMMA_typ_, 'r) _menhir_state
    (** State 048.
        Stack shape : GENERIC separated_nonempty_list(COMMA,typ).
        Start symbol: <undetermined>. *)

  | MenhirState055 : ((('s, 'r) _menhir_cell1_RESULT, 'r) _menhir_cell1_typ, 'r) _menhir_state
    (** State 055.
        Stack shape : RESULT typ.
        Start symbol: <undetermined>. *)

  | MenhirState063 : (('s, _menhir_box_program) _menhir_cell1_param, _menhir_box_program) _menhir_state
    (** State 063.
        Stack shape : param.
        Start symbol: program. *)

  | MenhirState068 : ((('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_state
    (** State 068.
        Stack shape : FN IDENT loption(separated_nonempty_list(COMMA,param)).
        Start symbol: program. *)

  | MenhirState074 : (('s, _menhir_box_program) _menhir_cell1_fn_sig, _menhir_box_program) _menhir_state
    (** State 074.
        Stack shape : fn_sig.
        Start symbol: program. *)

  | MenhirState078 : (('s, _menhir_box_program) _menhir_cell1_STRUCT _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 078.
        Stack shape : STRUCT IDENT.
        Start symbol: program. *)

  | MenhirState080 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 080.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState086 : (('s, _menhir_box_program) _menhir_cell1_field, _menhir_box_program) _menhir_state
    (** State 086.
        Stack shape : field.
        Start symbol: program. *)

  | MenhirState092 : (('s, _menhir_box_program) _menhir_cell1_ROLE _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 092.
        Stack shape : ROLE IDENT.
        Start symbol: program. *)

  | MenhirState094 : (('s, 'r) _menhir_cell1_IDENT, 'r) _menhir_state
    (** State 094.
        Stack shape : IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState096 : (('s, 'r) _menhir_cell1_TRANSFER, 'r) _menhir_state
    (** State 096.
        Stack shape : TRANSFER.
        Start symbol: <undetermined>. *)

  | MenhirState099 : (('s, 'r) _menhir_cell1_OK, 'r) _menhir_state
    (** State 099.
        Stack shape : OK.
        Start symbol: <undetermined>. *)

  | MenhirState100 : (('s, 'r) _menhir_cell1_NOT, 'r) _menhir_state
    (** State 100.
        Stack shape : NOT.
        Start symbol: <undetermined>. *)

  | MenhirState101 : (('s, 'r) _menhir_cell1_MINUS, 'r) _menhir_state
    (** State 101.
        Stack shape : MINUS.
        Start symbol: <undetermined>. *)

  | MenhirState102 : (('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_state
    (** State 102.
        Stack shape : MATCH.
        Start symbol: <undetermined>. *)

  | MenhirState104 : (('s, 'r) _menhir_cell1_TRANSFER, 'r) _menhir_state
    (** State 104.
        Stack shape : TRANSFER.
        Start symbol: <undetermined>. *)

  | MenhirState105 : (('s, 'r) _menhir_cell1_LPAREN, 'r) _menhir_state
    (** State 105.
        Stack shape : LPAREN.
        Start symbol: <undetermined>. *)

  | MenhirState106 : (('s, 'r) _menhir_cell1_LBRACKET, 'r) _menhir_state
    (** State 106.
        Stack shape : LBRACKET.
        Start symbol: <undetermined>. *)

  | MenhirState119 : (('s, 'r) _menhir_cell1_IF, 'r) _menhir_state
    (** State 119.
        Stack shape : IF.
        Start symbol: <undetermined>. *)

  | MenhirState121 : (('s, 'r) _menhir_cell1_OK, 'r) _menhir_state
    (** State 121.
        Stack shape : OK.
        Start symbol: <undetermined>. *)

  | MenhirState123 : (('s, 'r) _menhir_cell1_IDENT, 'r) _menhir_state
    (** State 123.
        Stack shape : IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState125 : (('s, 'r) _menhir_cell1_GENERIC, 'r) _menhir_state
    (** State 125.
        Stack shape : GENERIC.
        Start symbol: <undetermined>. *)

  | MenhirState127 : ((('s, 'r) _menhir_cell1_GENERIC, 'r) _menhir_cell1_separated_nonempty_list_COMMA_typ_, 'r) _menhir_state
    (** State 127.
        Stack shape : GENERIC separated_nonempty_list(COMMA,typ).
        Start symbol: <undetermined>. *)

  | MenhirState130 : (('s, 'r) _menhir_cell1_ERR, 'r) _menhir_state
    (** State 130.
        Stack shape : ERR.
        Start symbol: <undetermined>. *)

  | MenhirState133 : (('s, 'r) _menhir_cell1_module_path, 'r) _menhir_state
    (** State 133.
        Stack shape : module_path.
        Start symbol: <undetermined>. *)

  | MenhirState140 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 140.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState142 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 142.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState144 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 144.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState148 : (('s, 'r) _menhir_cell1_expr _menhir_cell0_IDENT, 'r) _menhir_state
    (** State 148.
        Stack shape : expr IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState151 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 151.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState153 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 153.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState155 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 155.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState157 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 157.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState159 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 159.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState162 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 162.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState164 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 164.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState166 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 166.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState168 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 168.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState170 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 170.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState172 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 172.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState174 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 174.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState176 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 176.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState178 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 178.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState180 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 180.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState182 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 182.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState184 : (('s, 'r) _menhir_cell1_module_path, 'r) _menhir_state
    (** State 184.
        Stack shape : module_path.
        Start symbol: <undetermined>. *)

  | MenhirState189 : (('s, 'r) _menhir_cell1_field_init, 'r) _menhir_state
    (** State 189.
        Stack shape : field_init.
        Start symbol: <undetermined>. *)

  | MenhirState198 : (('s, 'r) _menhir_cell1_NOT, 'r) _menhir_state
    (** State 198.
        Stack shape : NOT.
        Start symbol: <undetermined>. *)

  | MenhirState199 : (('s, 'r) _menhir_cell1_MINUS, 'r) _menhir_state
    (** State 199.
        Stack shape : MINUS.
        Start symbol: <undetermined>. *)

  | MenhirState200 : (('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_state
    (** State 200.
        Stack shape : MATCH.
        Start symbol: <undetermined>. *)

  | MenhirState201 : (('s, 'r) _menhir_cell1_LPAREN, 'r) _menhir_state
    (** State 201.
        Stack shape : LPAREN.
        Start symbol: <undetermined>. *)

  | MenhirState204 : (('s, 'r) _menhir_cell1_LBRACKET, 'r) _menhir_state
    (** State 204.
        Stack shape : LBRACKET.
        Start symbol: <undetermined>. *)

  | MenhirState208 : (('s, 'r) _menhir_cell1_IF, 'r) _menhir_state
    (** State 208.
        Stack shape : IF.
        Start symbol: <undetermined>. *)

  | MenhirState210 : (('s, 'r) _menhir_cell1_IDENT, 'r) _menhir_state
    (** State 210.
        Stack shape : IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState214 : (('s, 'r) _menhir_cell1_GENERIC, 'r) _menhir_state
    (** State 214.
        Stack shape : GENERIC.
        Start symbol: <undetermined>. *)

  | MenhirState216 : ((('s, 'r) _menhir_cell1_GENERIC, 'r) _menhir_cell1_separated_nonempty_list_COMMA_typ_, 'r) _menhir_state
    (** State 216.
        Stack shape : GENERIC separated_nonempty_list(COMMA,typ).
        Start symbol: <undetermined>. *)

  | MenhirState219 : (('s, 'r) _menhir_cell1_ERR, 'r) _menhir_state
    (** State 219.
        Stack shape : ERR.
        Start symbol: <undetermined>. *)

  | MenhirState223 : (('s, 'r) _menhir_cell1_module_path, 'r) _menhir_state
    (** State 223.
        Stack shape : module_path.
        Start symbol: <undetermined>. *)

  | MenhirState227 : (((('s, 'r) _menhir_cell1_GENERIC, 'r) _menhir_cell1_separated_nonempty_list_COMMA_typ_, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 227.
        Stack shape : GENERIC separated_nonempty_list(COMMA,typ) expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState228 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_STAR, 'r) _menhir_state
    (** State 228.
        Stack shape : expr_no_struct STAR.
        Start symbol: <undetermined>. *)

  | MenhirState229 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_STAR, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 229.
        Stack shape : expr_no_struct STAR expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState230 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_LBRACKET, 'r) _menhir_state
    (** State 230.
        Stack shape : expr_no_struct LBRACKET.
        Start symbol: <undetermined>. *)

  | MenhirState235 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_DOT _menhir_cell0_IDENT, 'r) _menhir_state
    (** State 235.
        Stack shape : expr_no_struct DOT IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState238 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_AS, 'r) _menhir_state
    (** State 238.
        Stack shape : expr_no_struct AS.
        Start symbol: <undetermined>. *)

  | MenhirState241 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_SLASH, 'r) _menhir_state
    (** State 241.
        Stack shape : expr_no_struct SLASH.
        Start symbol: <undetermined>. *)

  | MenhirState242 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_SLASH, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 242.
        Stack shape : expr_no_struct SLASH expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState243 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_SHR, 'r) _menhir_state
    (** State 243.
        Stack shape : expr_no_struct SHR.
        Start symbol: <undetermined>. *)

  | MenhirState244 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_SHR, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 244.
        Stack shape : expr_no_struct SHR expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState245 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_PLUS, 'r) _menhir_state
    (** State 245.
        Stack shape : expr_no_struct PLUS.
        Start symbol: <undetermined>. *)

  | MenhirState246 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_PLUS, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 246.
        Stack shape : expr_no_struct PLUS expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState247 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_MINUS, 'r) _menhir_state
    (** State 247.
        Stack shape : expr_no_struct MINUS.
        Start symbol: <undetermined>. *)

  | MenhirState248 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_MINUS, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 248.
        Stack shape : expr_no_struct MINUS expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState249 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_SHL, 'r) _menhir_state
    (** State 249.
        Stack shape : expr_no_struct SHL.
        Start symbol: <undetermined>. *)

  | MenhirState250 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_SHL, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 250.
        Stack shape : expr_no_struct SHL expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState251 : ((('s, 'r) _menhir_cell1_IF, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 251.
        Stack shape : IF expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState252 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_OR, 'r) _menhir_state
    (** State 252.
        Stack shape : expr_no_struct OR.
        Start symbol: <undetermined>. *)

  | MenhirState253 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_OR, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 253.
        Stack shape : expr_no_struct OR expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState254 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_NEQ, 'r) _menhir_state
    (** State 254.
        Stack shape : expr_no_struct NEQ.
        Start symbol: <undetermined>. *)

  | MenhirState255 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_NEQ, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 255.
        Stack shape : expr_no_struct NEQ expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState256 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_LTE, 'r) _menhir_state
    (** State 256.
        Stack shape : expr_no_struct LTE.
        Start symbol: <undetermined>. *)

  | MenhirState257 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_LTE, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 257.
        Stack shape : expr_no_struct LTE expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState258 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_LT, 'r) _menhir_state
    (** State 258.
        Stack shape : expr_no_struct LT.
        Start symbol: <undetermined>. *)

  | MenhirState259 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_LT, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 259.
        Stack shape : expr_no_struct LT expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState260 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_GTE, 'r) _menhir_state
    (** State 260.
        Stack shape : expr_no_struct GTE.
        Start symbol: <undetermined>. *)

  | MenhirState261 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_GTE, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 261.
        Stack shape : expr_no_struct GTE expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState262 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_GT, 'r) _menhir_state
    (** State 262.
        Stack shape : expr_no_struct GT.
        Start symbol: <undetermined>. *)

  | MenhirState263 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_GT, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 263.
        Stack shape : expr_no_struct GT expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState264 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_EQEQ, 'r) _menhir_state
    (** State 264.
        Stack shape : expr_no_struct EQEQ.
        Start symbol: <undetermined>. *)

  | MenhirState265 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_EQEQ, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 265.
        Stack shape : expr_no_struct EQEQ expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState266 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_AND, 'r) _menhir_state
    (** State 266.
        Stack shape : expr_no_struct AND.
        Start symbol: <undetermined>. *)

  | MenhirState267 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_AND, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 267.
        Stack shape : expr_no_struct AND expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState268 : (('s, 'r) _menhir_cell1_LBRACE, 'r) _menhir_state
    (** State 268.
        Stack shape : LBRACE.
        Start symbol: <undetermined>. *)

  | MenhirState269 : (('s, 'r) _menhir_cell1_WHILE, 'r) _menhir_state
    (** State 269.
        Stack shape : WHILE.
        Start symbol: <undetermined>. *)

  | MenhirState270 : ((('s, 'r) _menhir_cell1_WHILE, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 270.
        Stack shape : WHILE expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState271 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_BITOR, 'r) _menhir_state
    (** State 271.
        Stack shape : expr_no_struct BITOR.
        Start symbol: <undetermined>. *)

  | MenhirState272 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_BITOR, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 272.
        Stack shape : expr_no_struct BITOR expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState273 : ((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_BITAND, 'r) _menhir_state
    (** State 273.
        Stack shape : expr_no_struct BITAND.
        Start symbol: <undetermined>. *)

  | MenhirState274 : (((('s, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_BITAND, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 274.
        Stack shape : expr_no_struct BITAND expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState278 : (('s, 'r) _menhir_cell1_VAR _menhir_cell0_IDENT, 'r) _menhir_state
    (** State 278.
        Stack shape : VAR IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState281 : (('s, 'r) _menhir_cell1_VAR _menhir_cell0_IDENT _menhir_cell0_option___anonymous_9_, 'r) _menhir_state
    (** State 281.
        Stack shape : VAR IDENT option(__anonymous_9).
        Start symbol: <undetermined>. *)

  | MenhirState284 : (('s, 'r) _menhir_cell1_RETURN, 'r) _menhir_state
    (** State 284.
        Stack shape : RETURN.
        Start symbol: <undetermined>. *)

  | MenhirState291 : (('s, 'r) _menhir_cell1_LET _menhir_cell0_IDENT, 'r) _menhir_state
    (** State 291.
        Stack shape : LET IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState294 : (('s, 'r) _menhir_cell1_LET _menhir_cell0_IDENT _menhir_cell0_option___anonymous_8_, 'r) _menhir_state
    (** State 294.
        Stack shape : LET IDENT option(__anonymous_8).
        Start symbol: <undetermined>. *)

  | MenhirState299 : (('s, 'r) _menhir_cell1_FOR _menhir_cell0_IDENT, 'r) _menhir_state
    (** State 299.
        Stack shape : FOR IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState300 : ((('s, 'r) _menhir_cell1_FOR _menhir_cell0_IDENT, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 300.
        Stack shape : FOR IDENT expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState304 : (('s, 'r) _menhir_cell1_CONST _menhir_cell0_IDENT, 'r) _menhir_state
    (** State 304.
        Stack shape : CONST IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState307 : (('s, 'r) _menhir_cell1_CONST _menhir_cell0_IDENT _menhir_cell0_option___anonymous_10_, 'r) _menhir_state
    (** State 307.
        Stack shape : CONST IDENT option(__anonymous_10).
        Start symbol: <undetermined>. *)

  | MenhirState310 : (('s, 'r) _menhir_cell1_stmt, 'r) _menhir_state
    (** State 310.
        Stack shape : stmt.
        Start symbol: <undetermined>. *)

  | MenhirState313 : (('s, 'r) _menhir_cell1_expr, 'r) _menhir_state
    (** State 313.
        Stack shape : expr.
        Start symbol: <undetermined>. *)

  | MenhirState319 : (((('s, 'r) _menhir_cell1_IF, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_block, 'r) _menhir_state
    (** State 319.
        Stack shape : IF expr_no_struct block.
        Start symbol: <undetermined>. *)

  | MenhirState320 : ((((('s, 'r) _menhir_cell1_IF, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_block, 'r) _menhir_cell1_ELSE, 'r) _menhir_state
    (** State 320.
        Stack shape : IF expr_no_struct block ELSE.
        Start symbol: <undetermined>. *)

  | MenhirState321 : (('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_state
    (** State 321.
        Stack shape : MATCH.
        Start symbol: <undetermined>. *)

  | MenhirState322 : ((('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 322.
        Stack shape : MATCH expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState323 : (((('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_LBRACE, 'r) _menhir_state
    (** State 323.
        Stack shape : MATCH expr_no_struct LBRACE.
        Start symbol: <undetermined>. *)

  | MenhirState327 : (('s, 'r) _menhir_cell1_IDENT, 'r) _menhir_state
    (** State 327.
        Stack shape : IDENT.
        Start symbol: <undetermined>. *)

  | MenhirState329 : ((('s, 'r) _menhir_cell1_IDENT, 'r) _menhir_cell1_module_path, 'r) _menhir_state
    (** State 329.
        Stack shape : IDENT module_path.
        Start symbol: <undetermined>. *)

  | MenhirState332 : (('s, 'r) _menhir_cell1_variant_ident, 'r) _menhir_state
    (** State 332.
        Stack shape : variant_ident.
        Start symbol: <undetermined>. *)

  | MenhirState335 : (('s, 'r) _menhir_cell1_pattern, 'r) _menhir_state
    (** State 335.
        Stack shape : pattern.
        Start symbol: <undetermined>. *)

  | MenhirState343 : (('s, 'r) _menhir_cell1_pattern, 'r) _menhir_state
    (** State 343.
        Stack shape : pattern.
        Start symbol: <undetermined>. *)

  | MenhirState348 : (('s, 'r) _menhir_cell1_match_arm, 'r) _menhir_state
    (** State 348.
        Stack shape : match_arm.
        Start symbol: <undetermined>. *)

  | MenhirState350 : (('s, 'r) _menhir_cell1_IF, 'r) _menhir_state
    (** State 350.
        Stack shape : IF.
        Start symbol: <undetermined>. *)

  | MenhirState351 : ((('s, 'r) _menhir_cell1_IF, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 351.
        Stack shape : IF expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState353 : (((('s, 'r) _menhir_cell1_IF, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_block, 'r) _menhir_state
    (** State 353.
        Stack shape : IF expr_no_struct block.
        Start symbol: <undetermined>. *)

  | MenhirState359 : ((('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 359.
        Stack shape : MATCH expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState360 : (((('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_LBRACE, 'r) _menhir_state
    (** State 360.
        Stack shape : MATCH expr_no_struct LBRACE.
        Start symbol: <undetermined>. *)

  | MenhirState365 : ((('s, 'r) _menhir_cell1_IF, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 365.
        Stack shape : IF expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState366 : (((('s, 'r) _menhir_cell1_IF, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_block, 'r) _menhir_state
    (** State 366.
        Stack shape : IF expr_no_struct block.
        Start symbol: <undetermined>. *)

  | MenhirState376 : ((('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_state
    (** State 376.
        Stack shape : MATCH expr_no_struct.
        Start symbol: <undetermined>. *)

  | MenhirState377 : (((('s, 'r) _menhir_cell1_MATCH, 'r) _menhir_cell1_expr_no_struct, 'r) _menhir_cell1_LBRACE, 'r) _menhir_state
    (** State 377.
        Stack shape : MATCH expr_no_struct LBRACE.
        Start symbol: <undetermined>. *)

  | MenhirState394 : (('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 394.
        Stack shape : PUB IDENT.
        Start symbol: program. *)

  | MenhirState399 : (('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 399.
        Stack shape : PUB IDENT.
        Start symbol: program. *)

  | MenhirState404 : (('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 404.
        Stack shape : PUB IDENT.
        Start symbol: program. *)

  | MenhirState406 : ((('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_typ, _menhir_box_program) _menhir_state
    (** State 406.
        Stack shape : PUB IDENT typ.
        Start symbol: program. *)

  | MenhirState411 : (('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 411.
        Stack shape : PUB IDENT.
        Start symbol: program. *)

  | MenhirState413 : ((('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_state
    (** State 413.
        Stack shape : PUB IDENT loption(separated_nonempty_list(COMMA,param)).
        Start symbol: program. *)

  | MenhirState416 : (((('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_, _menhir_box_program) _menhir_state
    (** State 416.
        Stack shape : PUB IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_3).
        Start symbol: program. *)

  | MenhirState418 : (((('s _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_, _menhir_box_program) _menhir_cell1_MINUS, _menhir_box_program) _menhir_state
    (** State 418.
        Stack shape : IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_3) MINUS.
        Start symbol: program. *)

  | MenhirState420 : ((((('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_, _menhir_box_program) _menhir_cell1_option___anonymous_4_, _menhir_box_program) _menhir_state
    (** State 420.
        Stack shape : PUB IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_3) option(__anonymous_4).
        Start symbol: program. *)

  | MenhirState425 : (('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 425.
        Stack shape : PUB IDENT.
        Start symbol: program. *)

  | MenhirState427 : ((('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_state
    (** State 427.
        Stack shape : PUB IDENT loption(separated_nonempty_list(COMMA,param)).
        Start symbol: program. *)

  | MenhirState430 : (((('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_1_, _menhir_box_program) _menhir_state
    (** State 430.
        Stack shape : PUB IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_1).
        Start symbol: program. *)

  | MenhirState432 : (((('s _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_1_, _menhir_box_program) _menhir_cell1_MINUS, _menhir_box_program) _menhir_state
    (** State 432.
        Stack shape : IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_1) MINUS.
        Start symbol: program. *)

  | MenhirState437 : (('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 437.
        Stack shape : PUB IDENT.
        Start symbol: program. *)

  | MenhirState438 : (('s _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_COLON, _menhir_box_program) _menhir_state
    (** State 438.
        Stack shape : IDENT COLON.
        Start symbol: program. *)

  | MenhirState440 : ((('s _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_COLON, _menhir_box_program) _menhir_cell1_base_type, _menhir_box_program) _menhir_state
    (** State 440.
        Stack shape : IDENT COLON base_type.
        Start symbol: program. *)

  | MenhirState444 : ((('s, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_option___anonymous_6_, _menhir_box_program) _menhir_state
    (** State 444.
        Stack shape : PUB IDENT option(__anonymous_6).
        Start symbol: program. *)

  | MenhirState447 : (('s, _menhir_box_program) _menhir_cell1_variant_ident, _menhir_box_program) _menhir_state
    (** State 447.
        Stack shape : variant_ident.
        Start symbol: program. *)

  | MenhirState452 : (('s, _menhir_box_program) _menhir_cell1_variant_ident _menhir_cell0_option___anonymous_7_, _menhir_box_program) _menhir_state
    (** State 452.
        Stack shape : variant_ident option(__anonymous_7).
        Start symbol: program. *)

  | MenhirState454 : (('s, _menhir_box_program) _menhir_cell1_variant_ident _menhir_cell0_option___anonymous_7_, _menhir_box_program) _menhir_state
    (** State 454.
        Stack shape : variant_ident option(__anonymous_7).
        Start symbol: program. *)

  | MenhirState462 : (('s, _menhir_box_program) _menhir_cell1_enum_member, _menhir_box_program) _menhir_state
    (** State 462.
        Stack shape : enum_member.
        Start symbol: program. *)

  | MenhirState466 : (('s, _menhir_box_program) _menhir_cell1_IMPL _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 466.
        Stack shape : IMPL IDENT.
        Start symbol: program. *)

  | MenhirState468 : ((('s, _menhir_box_program) _menhir_cell1_IMPL _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_typ, _menhir_box_program) _menhir_state
    (** State 468.
        Stack shape : IMPL IDENT typ.
        Start symbol: program. *)

  | MenhirState472 : (('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 472.
        Stack shape : FN IDENT.
        Start symbol: program. *)

  | MenhirState474 : ((('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_state
    (** State 474.
        Stack shape : FN IDENT loption(separated_nonempty_list(COMMA,param)).
        Start symbol: program. *)

  | MenhirState475 : (((('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_, _menhir_box_program) _menhir_state
    (** State 475.
        Stack shape : FN IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_3).
        Start symbol: program. *)

  | MenhirState476 : ((((('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_, _menhir_box_program) _menhir_cell1_option___anonymous_4_, _menhir_box_program) _menhir_state
    (** State 476.
        Stack shape : FN IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_3) option(__anonymous_4).
        Start symbol: program. *)

  | MenhirState481 : (('s, _menhir_box_program) _menhir_cell1_EXTERN _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 481.
        Stack shape : EXTERN IDENT.
        Start symbol: program. *)

  | MenhirState483 : ((('s, _menhir_box_program) _menhir_cell1_EXTERN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_state
    (** State 483.
        Stack shape : EXTERN IDENT loption(separated_nonempty_list(COMMA,param)).
        Start symbol: program. *)

  | MenhirState484 : (((('s, _menhir_box_program) _menhir_cell1_EXTERN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_1_, _menhir_box_program) _menhir_state
    (** State 484.
        Stack shape : EXTERN IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_1).
        Start symbol: program. *)

  | MenhirState489 : (('s, _menhir_box_program) _menhir_cell1_fn_decl, _menhir_box_program) _menhir_state
    (** State 489.
        Stack shape : fn_decl.
        Start symbol: program. *)

  | MenhirState493 : (('s, _menhir_box_program) _menhir_cell1_GLOBAL _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 493.
        Stack shape : GLOBAL IDENT.
        Start symbol: program. *)

  | MenhirState495 : ((('s, _menhir_box_program) _menhir_cell1_GLOBAL _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_typ, _menhir_box_program) _menhir_state
    (** State 495.
        Stack shape : GLOBAL IDENT typ.
        Start symbol: program. *)

  | MenhirState499 : (('s, _menhir_box_program) _menhir_cell1_GENERIC, _menhir_box_program) _menhir_state
    (** State 499.
        Stack shape : GENERIC.
        Start symbol: program. *)

  | MenhirState501 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 501.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState504 : ((('s, _menhir_box_program) _menhir_cell1_GENERIC, _menhir_box_program) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_, _menhir_box_program) _menhir_state
    (** State 504.
        Stack shape : GENERIC separated_nonempty_list(COMMA,IDENT).
        Start symbol: program. *)

  | MenhirState506 : (('s, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 506.
        Stack shape : ENUM IDENT.
        Start symbol: program. *)

  | MenhirState508 : ((('s, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_option___anonymous_6_, _menhir_box_program) _menhir_state
    (** State 508.
        Stack shape : ENUM IDENT option(__anonymous_6).
        Start symbol: program. *)

  | MenhirState519 : (('s, _menhir_box_program) _menhir_cell1_item, _menhir_box_program) _menhir_state
    (** State 519.
        Stack shape : item.
        Start symbol: program. *)

  | MenhirState521 : (('s, _menhir_box_program) _menhir_cell1_import_decl, _menhir_box_program) _menhir_state
    (** State 521.
        Stack shape : import_decl.
        Start symbol: program. *)

  | MenhirState523 : ('s, _menhir_box_standalone_expr) _menhir_state
    (** State 523.
        Stack shape : <empty>.
        Start symbol: standalone_expr. *)


and ('s, 'r) _menhir_cell1_base_type = 
  | MenhirCell1_base_type of 's * ('s, 'r) _menhir_state * (Ast.base_type)

and ('s, 'r) _menhir_cell1_block = 
  | MenhirCell1_block of 's * ('s, 'r) _menhir_state * (Ast.block)

and ('s, 'r) _menhir_cell1_enum_member = 
  | MenhirCell1_enum_member of 's * ('s, 'r) _menhir_state * (Ast.enum_member)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr)

and ('s, 'r) _menhir_cell1_expr_no_struct = 
  | MenhirCell1_expr_no_struct of 's * ('s, 'r) _menhir_state * (Ast.expr)

and ('s, 'r) _menhir_cell1_field = 
  | MenhirCell1_field of 's * ('s, 'r) _menhir_state * (Ast.field)

and ('s, 'r) _menhir_cell1_field_init = 
  | MenhirCell1_field_init of 's * ('s, 'r) _menhir_state * (string * Ast.expr)

and ('s, 'r) _menhir_cell1_fn_decl = 
  | MenhirCell1_fn_decl of 's * ('s, 'r) _menhir_state * (Ast.fn_decl)

and ('s, 'r) _menhir_cell1_fn_sig = 
  | MenhirCell1_fn_sig of 's * ('s, 'r) _menhir_state * (Ast.fn_sig)

and ('s, 'r) _menhir_cell1_import_decl = 
  | MenhirCell1_import_decl of 's * ('s, 'r) _menhir_state * (Ast.import_decl)

and ('s, 'r) _menhir_cell1_item = 
  | MenhirCell1_item of 's * ('s, 'r) _menhir_state * (Ast.item)

and ('s, 'r) _menhir_cell1_list_import_decl_ = 
  | MenhirCell1_list_import_decl_ of 's * ('s, 'r) _menhir_state * (Ast.import_decl list)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_param__ of 's * ('s, 'r) _menhir_state * (Ast.param list)

and ('s, 'r) _menhir_cell1_match_arm = 
  | MenhirCell1_match_arm of 's * ('s, 'r) _menhir_state * (Ast.pattern * Ast.expr)

and ('s, 'r) _menhir_cell1_module_path = 
  | MenhirCell1_module_path of 's * ('s, 'r) _menhir_state * (string list)

and ('s, 'r) _menhir_cell1_option___anonymous_1_ = 
  | MenhirCell1_option___anonymous_1_ of 's * ('s, 'r) _menhir_state * (string option)

and 's _menhir_cell0_option___anonymous_10_ = 
  | MenhirCell0_option___anonymous_10_ of 's * (Ast.typ option)

and ('s, 'r) _menhir_cell1_option___anonymous_3_ = 
  | MenhirCell1_option___anonymous_3_ of 's * ('s, 'r) _menhir_state * (string option)

and ('s, 'r) _menhir_cell1_option___anonymous_4_ = 
  | MenhirCell1_option___anonymous_4_ of 's * ('s, 'r) _menhir_state * (Ast.typ option)

and ('s, 'r) _menhir_cell1_option___anonymous_6_ = 
  | MenhirCell1_option___anonymous_6_ of 's * ('s, 'r) _menhir_state * ((Ast.base_type * Ast.expr) option)

and 's _menhir_cell0_option___anonymous_7_ = 
  | MenhirCell0_option___anonymous_7_ of 's * (Ast.typ list option)

and 's _menhir_cell0_option___anonymous_8_ = 
  | MenhirCell0_option___anonymous_8_ of 's * (Ast.typ option)

and 's _menhir_cell0_option___anonymous_9_ = 
  | MenhirCell0_option___anonymous_9_ of 's * (Ast.typ option)

and ('s, 'r) _menhir_cell1_param = 
  | MenhirCell1_param of 's * ('s, 'r) _menhir_state * (Ast.param)

and ('s, 'r) _menhir_cell1_pattern = 
  | MenhirCell1_pattern of 's * ('s, 'r) _menhir_state * (Ast.pattern)

and ('s, 'r) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_ = 
  | MenhirCell1_separated_nonempty_list_COMMA_IDENT_ of 's * ('s, 'r) _menhir_state * (string list)

and ('s, 'r) _menhir_cell1_separated_nonempty_list_COMMA_typ_ = 
  | MenhirCell1_separated_nonempty_list_COMMA_typ_ of 's * ('s, 'r) _menhir_state * (Ast.typ list)

and ('s, 'r) _menhir_cell1_stmt = 
  | MenhirCell1_stmt of 's * ('s, 'r) _menhir_state * (Ast.stmt)

and ('s, 'r) _menhir_cell1_typ = 
  | MenhirCell1_typ of 's * ('s, 'r) _menhir_state * (Ast.typ)

and ('s, 'r) _menhir_cell1_variant_ident = 
  | MenhirCell1_variant_ident of 's * ('s, 'r) _menhir_state * (string)

and ('s, 'r) _menhir_cell1_AND = 
  | MenhirCell1_AND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_AS = 
  | MenhirCell1_AS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_BITAND = 
  | MenhirCell1_BITAND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_BITOR = 
  | MenhirCell1_BITOR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_COLON = 
  | MenhirCell1_COLON of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CONST = 
  | MenhirCell1_CONST of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_DOT = 
  | MenhirCell1_DOT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ELSE = 
  | MenhirCell1_ELSE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ENUM = 
  | MenhirCell1_ENUM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_EQEQ = 
  | MenhirCell1_EQEQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ERR = 
  | MenhirCell1_ERR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_EXTERN = 
  | MenhirCell1_EXTERN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FN = 
  | MenhirCell1_FN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FOR = 
  | MenhirCell1_FOR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GENERIC = 
  | MenhirCell1_GENERIC of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GLOBAL = 
  | MenhirCell1_GLOBAL of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GT = 
  | MenhirCell1_GT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GTE = 
  | MenhirCell1_GTE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * 
# 9 "lib/parser.mly"
       (string)
# 1177 "lib/parser.ml"


and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * 
# 9 "lib/parser.mly"
       (string)
# 1184 "lib/parser.ml"


and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IMPL = 
  | MenhirCell1_IMPL of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IMPORT = 
  | MenhirCell1_IMPORT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_INT = 
  | MenhirCell1_INT of 's * ('s, 'r) _menhir_state * 
# 5 "lib/parser.mly"
       (int64)
# 1200 "lib/parser.ml"


and ('s, 'r) _menhir_cell1_LBRACE = 
  | MenhirCell1_LBRACE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LBRACKET = 
  | MenhirCell1_LBRACKET of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LET = 
  | MenhirCell1_LET of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAREN = 
  | MenhirCell1_LPAREN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LT = 
  | MenhirCell1_LT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LTE = 
  | MenhirCell1_LTE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MATCH = 
  | MenhirCell1_MATCH of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_MINUS = 
  | MenhirCell1_MINUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NEQ = 
  | MenhirCell1_NEQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_NOT = 
  | MenhirCell1_NOT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OK = 
  | MenhirCell1_OK of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_OR = 
  | MenhirCell1_OR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PLUS = 
  | MenhirCell1_PLUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PUB = 
  | MenhirCell1_PUB of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RESULT = 
  | MenhirCell1_RESULT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETURN = 
  | MenhirCell1_RETURN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ROLE = 
  | MenhirCell1_ROLE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SHL = 
  | MenhirCell1_SHL of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SHR = 
  | MenhirCell1_SHR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_SLASH = 
  | MenhirCell1_SLASH of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_STAR = 
  | MenhirCell1_STAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_STRUCT = 
  | MenhirCell1_STRUCT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TRAIT = 
  | MenhirCell1_TRAIT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_TRANSFER = 
  | MenhirCell1_TRANSFER of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_VAR = 
  | MenhirCell1_VAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state

and _menhir_box_standalone_expr = 
  | MenhirBox_standalone_expr of (Ast.expr) [@@unboxed]

and _menhir_box_program = 
  | MenhirBox_program of (Ast.program) [@@unboxed]

let _menhir_action_002 =
  fun () ->
    (
# 99 "lib/parser.mly"
       ( TU8 )
# 1292 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_003 =
  fun () ->
    (
# 99 "lib/parser.mly"
                     ( TU16 )
# 1300 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_004 =
  fun () ->
    (
# 99 "lib/parser.mly"
                                    ( TU32 )
# 1308 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_005 =
  fun () ->
    (
# 99 "lib/parser.mly"
                                                   ( TU64 )
# 1316 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_006 =
  fun () ->
    (
# 99 "lib/parser.mly"
                                                                    ( TUSize )
# 1324 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_007 =
  fun () ->
    (
# 100 "lib/parser.mly"
       ( TI8 )
# 1332 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_008 =
  fun () ->
    (
# 100 "lib/parser.mly"
                     ( TI16 )
# 1340 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_009 =
  fun () ->
    (
# 100 "lib/parser.mly"
                                    ( TI32 )
# 1348 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_010 =
  fun () ->
    (
# 100 "lib/parser.mly"
                                                   ( TI64 )
# 1356 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_011 =
  fun () ->
    (
# 100 "lib/parser.mly"
                                                                    ( TISize )
# 1364 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_012 =
  fun () ->
    (
# 101 "lib/parser.mly"
         ( TBool )
# 1372 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_013 =
  fun () ->
    (
# 101 "lib/parser.mly"
                         ( TStr )
# 1380 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_014 =
  fun id ->
    (
# 102 "lib/parser.mly"
             ( TCustom id )
# 1388 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_015 =
  fun args t ->
    (
# 103 "lib/parser.mly"
                                                                       ( TGenericApp (args, t) )
# 1396 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_016 =
  fun () ->
    (
# 119 "lib/parser.mly"
                  ( { stmts = []; ret_expr = None } )
# 1404 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_017 =
  fun b ->
    (
# 120 "lib/parser.mly"
                                ( b )
# 1412 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_018 =
  fun e ->
    (
# 123 "lib/parser.mly"
           ( { stmts = []; ret_expr = Some e } )
# 1420 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_019 =
  fun s ->
    (
# 124 "lib/parser.mly"
           ( { stmts = [s]; ret_expr = None } )
# 1428 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_020 =
  fun b s ->
    (
# 125 "lib/parser.mly"
                         ( { stmts = s :: b.stmts; ret_expr = b.ret_expr } )
# 1436 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_021 =
  fun b ->
    (
# 211 "lib/parser.mly"
            ( b )
# 1444 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_022 =
  fun cond els thn ->
    (
# 212 "lib/parser.mly"
                                                                        ( { stmts = []; ret_expr = Some (EIf (cond, thn, els)) } )
# 1452 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_023 =
  fun arms e ->
    (
# 213 "lib/parser.mly"
                                                                       ( { stmts = []; ret_expr = Some (EMatch (e, arms)) } )
# 1460 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_024 =
  fun base name xs ->
    let members = 
# 241 "<standard.mly>"
    ( xs )
# 1468 "lib/parser.ml"
     in
    let v = 
# 38 "lib/parser.mly"
        ( true )
# 1473 "lib/parser.ml"
     in
    (
# 107 "lib/parser.mly"
    ( let base_typ, iota_expr = match base with Some b -> b | None -> TU32, Ast.ELit (LInt (0L, Some TU32)) in
      { is_pub = v; name; base_typ; iota_expr; members } )
# 1479 "lib/parser.ml"
     : (Ast.enum_decl))

let _menhir_action_025 =
  fun base name xs ->
    let members = 
# 241 "<standard.mly>"
    ( xs )
# 1487 "lib/parser.ml"
     in
    let v = 
# 39 "lib/parser.mly"
                ( false )
# 1492 "lib/parser.ml"
     in
    (
# 107 "lib/parser.mly"
    ( let base_typ, iota_expr = match base with Some b -> b | None -> TU32, Ast.ELit (LInt (0L, Some TU32)) in
      { is_pub = v; name; base_typ; iota_expr; members } )
# 1498 "lib/parser.ml"
     : (Ast.enum_decl))

let _menhir_action_026 =
  fun name override payload ->
    (
# 116 "lib/parser.mly"
    ( { name; payload = Option.value payload ~default:[]; override; computed_val = ref None } )
# 1506 "lib/parser.ml"
     : (Ast.enum_member))

let _menhir_action_027 =
  fun e ->
    (
# 141 "lib/parser.mly"
                      ( e )
# 1514 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_028 =
  fun path xs ->
    let fields = 
# 241 "<standard.mly>"
    ( xs )
# 1522 "lib/parser.ml"
     in
    (
# 142 "lib/parser.mly"
                                                                            ( EStruct (List.hd (List.rev path), fields, None) )
# 1527 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_029 =
  fun e ->
    (
# 148 "lib/parser.mly"
            ( EUnOp (Not, e) )
# 1535 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_030 =
  fun e ->
    (
# 149 "lib/parser.mly"
                           ( EUnOp (Neg, e) )
# 1543 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_031 =
  fun e1 e2 ->
    (
# 150 "lib/parser.mly"
                   ( EBinOp (e1, Add, e2) )
# 1551 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_032 =
  fun e1 e2 ->
    (
# 151 "lib/parser.mly"
                    ( EBinOp (e1, Sub, e2) )
# 1559 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_033 =
  fun e1 e2 ->
    (
# 152 "lib/parser.mly"
                   ( EBinOp (e1, Mul, e2) )
# 1567 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_034 =
  fun e1 e2 ->
    (
# 153 "lib/parser.mly"
                    ( EBinOp (e1, Div, e2) )
# 1575 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_035 =
  fun e1 e2 ->
    (
# 154 "lib/parser.mly"
                  ( EBinOp (e1, Shl, e2) )
# 1583 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_036 =
  fun e1 e2 ->
    (
# 155 "lib/parser.mly"
                  ( EBinOp (e1, Shr, e2) )
# 1591 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_037 =
  fun e1 e2 ->
    (
# 156 "lib/parser.mly"
                     ( EBinOp (e1, BitAnd, e2) )
# 1599 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_038 =
  fun e1 e2 ->
    (
# 157 "lib/parser.mly"
                    ( EBinOp (e1, BitOr, e2) )
# 1607 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_039 =
  fun e1 e2 ->
    (
# 158 "lib/parser.mly"
                  ( EBinOp (e1, And, e2) )
# 1615 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_040 =
  fun e1 e2 ->
    (
# 159 "lib/parser.mly"
                 ( EBinOp (e1, Or, e2) )
# 1623 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_041 =
  fun e1 e2 ->
    (
# 160 "lib/parser.mly"
                   ( EBinOp (e1, Eq, e2) )
# 1631 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_042 =
  fun e1 e2 ->
    (
# 161 "lib/parser.mly"
                  ( EBinOp (e1, Neq, e2) )
# 1639 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_043 =
  fun e1 e2 ->
    (
# 162 "lib/parser.mly"
                 ( EBinOp (e1, Lt, e2) )
# 1647 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_044 =
  fun e1 e2 ->
    (
# 163 "lib/parser.mly"
                 ( EBinOp (e1, Gt, e2) )
# 1655 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_045 =
  fun e1 e2 ->
    (
# 164 "lib/parser.mly"
                  ( EBinOp (e1, Lte, e2) )
# 1663 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_046 =
  fun e1 e2 ->
    (
# 165 "lib/parser.mly"
                  ( EBinOp (e1, Gte, e2) )
# 1671 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_047 =
  fun e t ->
    (
# 166 "lib/parser.mly"
                 ( ECast (e, t) )
# 1679 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_048 =
  fun e ->
    (
# 167 "lib/parser.mly"
                            ( EOk (e, None) )
# 1687 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_049 =
  fun e ->
    (
# 168 "lib/parser.mly"
                             ( EErr (e, None) )
# 1695 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_050 =
  fun id xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 1703 "lib/parser.ml"
     in
    (
# 169 "lib/parser.mly"
                                                            ( ECall (id, args) )
# 1708 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_051 =
  fun () ->
    (
# 170 "lib/parser.mly"
         ( EVar "iota" )
# 1716 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_052 =
  fun cond els thn ->
    (
# 171 "lib/parser.mly"
                                                                        ( EIf (cond, thn, els) )
# 1724 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_053 =
  fun e1 id xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 1732 "lib/parser.ml"
     in
    (
# 172 "lib/parser.mly"
                                                                     ( EMethodCall (e1, id, args, ref None) )
# 1737 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_054 =
  fun e f ->
    (
# 173 "lib/parser.mly"
                    ( EField (e, f) )
# 1745 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_055 =
  fun arms e ->
    (
# 174 "lib/parser.mly"
                                                                       ( EMatch (e, arms) )
# 1753 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_056 =
  fun path xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 1761 "lib/parser.ml"
     in
    (
# 176 "lib/parser.mly"
    ( match path with
      | [id] -> ECall (id, args)
      | _ -> EPathCall (path, args) )
# 1768 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_057 =
  fun xs ->
    let elems = 
# 241 "<standard.mly>"
    ( xs )
# 1776 "lib/parser.ml"
     in
    (
# 179 "lib/parser.mly"
                                                        ( EArray elems )
# 1781 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_058 =
  fun e r ->
    (
# 180 "lib/parser.mly"
                                                ( ETransfer (e, r) )
# 1789 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_059 =
  fun e1 e2 ->
    (
# 181 "lib/parser.mly"
                                                  ( EIndex (e1, e2) )
# 1797 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_060 =
  fun args e ->
    (
# 182 "lib/parser.mly"
                                                               ( EGenericApp (args, e) )
# 1805 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_061 =
  fun l ->
    (
# 183 "lib/parser.mly"
              ( ELit l )
# 1813 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_062 =
  fun s ->
    (
# 184 "lib/parser.mly"
                  ( EFormatStr (ref s, ref []) )
# 1821 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_063 =
  fun path ->
    (
# 185 "lib/parser.mly"
                     ( match path with | [id] -> EVar id | _ -> EPathVar path )
# 1829 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_064 =
  fun e ->
    (
# 186 "lib/parser.mly"
                         ( e )
# 1837 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_065 =
  fun e ->
    (
# 148 "lib/parser.mly"
            ( EUnOp (Not, e) )
# 1845 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_066 =
  fun e ->
    (
# 149 "lib/parser.mly"
                           ( EUnOp (Neg, e) )
# 1853 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_067 =
  fun e1 e2 ->
    (
# 150 "lib/parser.mly"
                   ( EBinOp (e1, Add, e2) )
# 1861 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_068 =
  fun e1 e2 ->
    (
# 151 "lib/parser.mly"
                    ( EBinOp (e1, Sub, e2) )
# 1869 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_069 =
  fun e1 e2 ->
    (
# 152 "lib/parser.mly"
                   ( EBinOp (e1, Mul, e2) )
# 1877 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_070 =
  fun e1 e2 ->
    (
# 153 "lib/parser.mly"
                    ( EBinOp (e1, Div, e2) )
# 1885 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_071 =
  fun e1 e2 ->
    (
# 154 "lib/parser.mly"
                  ( EBinOp (e1, Shl, e2) )
# 1893 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_072 =
  fun e1 e2 ->
    (
# 155 "lib/parser.mly"
                  ( EBinOp (e1, Shr, e2) )
# 1901 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_073 =
  fun e1 e2 ->
    (
# 156 "lib/parser.mly"
                     ( EBinOp (e1, BitAnd, e2) )
# 1909 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_074 =
  fun e1 e2 ->
    (
# 157 "lib/parser.mly"
                    ( EBinOp (e1, BitOr, e2) )
# 1917 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_075 =
  fun e1 e2 ->
    (
# 158 "lib/parser.mly"
                  ( EBinOp (e1, And, e2) )
# 1925 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_076 =
  fun e1 e2 ->
    (
# 159 "lib/parser.mly"
                 ( EBinOp (e1, Or, e2) )
# 1933 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_077 =
  fun e1 e2 ->
    (
# 160 "lib/parser.mly"
                   ( EBinOp (e1, Eq, e2) )
# 1941 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_078 =
  fun e1 e2 ->
    (
# 161 "lib/parser.mly"
                  ( EBinOp (e1, Neq, e2) )
# 1949 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_079 =
  fun e1 e2 ->
    (
# 162 "lib/parser.mly"
                 ( EBinOp (e1, Lt, e2) )
# 1957 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_080 =
  fun e1 e2 ->
    (
# 163 "lib/parser.mly"
                 ( EBinOp (e1, Gt, e2) )
# 1965 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_081 =
  fun e1 e2 ->
    (
# 164 "lib/parser.mly"
                  ( EBinOp (e1, Lte, e2) )
# 1973 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_082 =
  fun e1 e2 ->
    (
# 165 "lib/parser.mly"
                  ( EBinOp (e1, Gte, e2) )
# 1981 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_083 =
  fun e t ->
    (
# 166 "lib/parser.mly"
                 ( ECast (e, t) )
# 1989 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_084 =
  fun e ->
    (
# 167 "lib/parser.mly"
                            ( EOk (e, None) )
# 1997 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_085 =
  fun e ->
    (
# 168 "lib/parser.mly"
                             ( EErr (e, None) )
# 2005 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_086 =
  fun id xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 2013 "lib/parser.ml"
     in
    (
# 169 "lib/parser.mly"
                                                            ( ECall (id, args) )
# 2018 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_087 =
  fun () ->
    (
# 170 "lib/parser.mly"
         ( EVar "iota" )
# 2026 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_088 =
  fun cond els thn ->
    (
# 171 "lib/parser.mly"
                                                                        ( EIf (cond, thn, els) )
# 2034 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_089 =
  fun e1 id xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 2042 "lib/parser.ml"
     in
    (
# 172 "lib/parser.mly"
                                                                     ( EMethodCall (e1, id, args, ref None) )
# 2047 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_090 =
  fun e f ->
    (
# 173 "lib/parser.mly"
                    ( EField (e, f) )
# 2055 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_091 =
  fun arms e ->
    (
# 174 "lib/parser.mly"
                                                                       ( EMatch (e, arms) )
# 2063 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_092 =
  fun path xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 2071 "lib/parser.ml"
     in
    (
# 176 "lib/parser.mly"
    ( match path with
      | [id] -> ECall (id, args)
      | _ -> EPathCall (path, args) )
# 2078 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_093 =
  fun xs ->
    let elems = 
# 241 "<standard.mly>"
    ( xs )
# 2086 "lib/parser.ml"
     in
    (
# 179 "lib/parser.mly"
                                                        ( EArray elems )
# 2091 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_094 =
  fun e r ->
    (
# 180 "lib/parser.mly"
                                                ( ETransfer (e, r) )
# 2099 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_095 =
  fun e1 e2 ->
    (
# 181 "lib/parser.mly"
                                                  ( EIndex (e1, e2) )
# 2107 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_096 =
  fun args e ->
    (
# 182 "lib/parser.mly"
                                                               ( EGenericApp (args, e) )
# 2115 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_097 =
  fun l ->
    (
# 183 "lib/parser.mly"
              ( ELit l )
# 2123 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_098 =
  fun s ->
    (
# 184 "lib/parser.mly"
                  ( EFormatStr (ref s, ref []) )
# 2131 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_099 =
  fun path ->
    (
# 185 "lib/parser.mly"
                     ( match path with | [id] -> EVar id | _ -> EPathVar path )
# 2139 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_100 =
  fun e ->
    (
# 186 "lib/parser.mly"
                         ( e )
# 2147 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_101 =
  fun e ->
    (
# 145 "lib/parser.mly"
                                ( e )
# 2155 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_102 =
  fun name typ ->
    (
# 75 "lib/parser.mly"
                             ( ({ name; typ } : Ast.field) )
# 2163 "lib/parser.ml"
     : (Ast.field))

let _menhir_action_103 =
  fun e name ->
    (
# 189 "lib/parser.mly"
                            ( (name, e) )
# 2171 "lib/parser.ml"
     : (string * Ast.expr))

let _menhir_action_104 =
  fun name ret role xs ->
    let params = 
# 241 "<standard.mly>"
    ( xs )
# 2179 "lib/parser.ml"
     in
    let v = 
# 38 "lib/parser.mly"
        ( true )
# 2184 "lib/parser.ml"
     in
    (
# 79 "lib/parser.mly"
    ( { is_pub = v; name; params; ret_typ = ret; role; is_extern = true; body = None } )
# 2189 "lib/parser.ml"
     : (Ast.fn_decl))

let _menhir_action_105 =
  fun name ret role xs ->
    let params = 
# 241 "<standard.mly>"
    ( xs )
# 2197 "lib/parser.ml"
     in
    let v = 
# 39 "lib/parser.mly"
                ( false )
# 2202 "lib/parser.ml"
     in
    (
# 79 "lib/parser.mly"
    ( { is_pub = v; name; params; ret_typ = ret; role; is_extern = true; body = None } )
# 2207 "lib/parser.ml"
     : (Ast.fn_decl))

let _menhir_action_106 =
  fun b name ret role xs ->
    let params = 
# 241 "<standard.mly>"
    ( xs )
# 2215 "lib/parser.ml"
     in
    let v = 
# 38 "lib/parser.mly"
        ( true )
# 2220 "lib/parser.ml"
     in
    (
# 81 "lib/parser.mly"
    ( { is_pub = v; name; params; ret_typ = ret; role; is_extern = false; body = Some b } )
# 2225 "lib/parser.ml"
     : (Ast.fn_decl))

let _menhir_action_107 =
  fun b name ret role xs ->
    let params = 
# 241 "<standard.mly>"
    ( xs )
# 2233 "lib/parser.ml"
     in
    let v = 
# 39 "lib/parser.mly"
                ( false )
# 2238 "lib/parser.ml"
     in
    (
# 81 "lib/parser.mly"
    ( { is_pub = v; name; params; ret_typ = ret; role; is_extern = false; body = Some b } )
# 2243 "lib/parser.ml"
     : (Ast.fn_decl))

let _menhir_action_108 =
  fun name ret xs ->
    let params = 
# 241 "<standard.mly>"
    ( xs )
# 2251 "lib/parser.ml"
     in
    (
# 85 "lib/parser.mly"
    ( { name; params; ret_typ = ret } )
# 2256 "lib/parser.ml"
     : (Ast.fn_sig))

let _menhir_action_109 =
  fun methods t trait_name ->
    (
# 72 "lib/parser.mly"
                                                                        ( { trait_name; for_typ = t; methods } )
# 2264 "lib/parser.ml"
     : (Ast.impl_decl))

let _menhir_action_110 =
  fun alias path ->
    (
# 48 "lib/parser.mly"
                                                                     ( { path; alias } )
# 2272 "lib/parser.ml"
     : (Ast.import_decl))

let _menhir_action_111 =
  fun () ->
    (
# 221 "lib/parser.mly"
       ( TU8 )
# 2280 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_112 =
  fun () ->
    (
# 221 "lib/parser.mly"
                     ( TU16 )
# 2288 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_113 =
  fun () ->
    (
# 221 "lib/parser.mly"
                                    ( TU32 )
# 2296 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_114 =
  fun () ->
    (
# 221 "lib/parser.mly"
                                                   ( TU64 )
# 2304 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_115 =
  fun () ->
    (
# 222 "lib/parser.mly"
       ( TI8 )
# 2312 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_116 =
  fun () ->
    (
# 222 "lib/parser.mly"
                     ( TI16 )
# 2320 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_117 =
  fun () ->
    (
# 222 "lib/parser.mly"
                                    ( TI32 )
# 2328 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_118 =
  fun () ->
    (
# 222 "lib/parser.mly"
                                                   ( TI64 )
# 2336 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_119 =
  fun f ->
    (
# 55 "lib/parser.mly"
              ( IFn f )
# 2344 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_120 =
  fun e ->
    (
# 56 "lib/parser.mly"
                ( IEnum e )
# 2352 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_121 =
  fun s ->
    (
# 57 "lib/parser.mly"
                  ( IStruct s )
# 2360 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_122 =
  fun t ->
    (
# 58 "lib/parser.mly"
                 ( ITrait t )
# 2368 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_123 =
  fun i ->
    (
# 59 "lib/parser.mly"
                ( IImpl i )
# 2376 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_124 =
  fun init name t ->
    let v = 
# 38 "lib/parser.mly"
        ( true )
# 2384 "lib/parser.ml"
     in
    (
# 60 "lib/parser.mly"
                                                                      ( IGlobal { is_pub = v; name; typ = t; init } )
# 2389 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_125 =
  fun init name t ->
    let v = 
# 39 "lib/parser.mly"
                ( false )
# 2397 "lib/parser.ml"
     in
    (
# 60 "lib/parser.mly"
                                                                      ( IGlobal { is_pub = v; name; typ = t; init } )
# 2402 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_126 =
  fun id ->
    (
# 61 "lib/parser.mly"
                               ( IRole { name = id; properties = [] } )
# 2410 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_127 =
  fun id xs ->
    let props = 
# 241 "<standard.mly>"
    ( xs )
# 2418 "lib/parser.ml"
     in
    (
# 62 "lib/parser.mly"
                                                                           ( IRole { name = id; properties = props } )
# 2423 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_128 =
  fun i params ->
    (
# 63 "lib/parser.mly"
                                                                      ( IGeneric (params, i) )
# 2431 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_129 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 2439 "lib/parser.ml"
     : (Ast.fn_decl list))

let _menhir_action_130 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 2447 "lib/parser.ml"
     : (Ast.fn_decl list))

let _menhir_action_131 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 2455 "lib/parser.ml"
     : (Ast.fn_sig list))

let _menhir_action_132 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 2463 "lib/parser.ml"
     : (Ast.fn_sig list))

let _menhir_action_133 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 2471 "lib/parser.ml"
     : (Ast.import_decl list))

let _menhir_action_134 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 2479 "lib/parser.ml"
     : (Ast.import_decl list))

let _menhir_action_135 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 2487 "lib/parser.ml"
     : (Ast.item list))

let _menhir_action_136 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 2495 "lib/parser.ml"
     : (Ast.item list))

let _menhir_action_137 =
  fun t v ->
    (
# 216 "lib/parser.mly"
                               ( LInt (v, t) )
# 2503 "lib/parser.ml"
     : (Ast.literal))

let _menhir_action_138 =
  fun v ->
    (
# 217 "lib/parser.mly"
               ( LBool v )
# 2511 "lib/parser.ml"
     : (Ast.literal))

let _menhir_action_139 =
  fun v ->
    (
# 218 "lib/parser.mly"
                 ( LStr v )
# 2519 "lib/parser.ml"
     : (Ast.literal))

let _menhir_action_140 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 2527 "lib/parser.ml"
     : (Ast.enum_member list))

let _menhir_action_141 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 2535 "lib/parser.ml"
     : (Ast.enum_member list))

let _menhir_action_142 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 2543 "lib/parser.ml"
     : (Ast.expr list))

let _menhir_action_143 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 2551 "lib/parser.ml"
     : (Ast.expr list))

let _menhir_action_144 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 2559 "lib/parser.ml"
     : (Ast.field list))

let _menhir_action_145 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 2567 "lib/parser.ml"
     : (Ast.field list))

let _menhir_action_146 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 2575 "lib/parser.ml"
     : ((string * Ast.expr) list))

let _menhir_action_147 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 2583 "lib/parser.ml"
     : ((string * Ast.expr) list))

let _menhir_action_148 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 2591 "lib/parser.ml"
     : (Ast.param list))

let _menhir_action_149 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 2599 "lib/parser.ml"
     : (Ast.param list))

let _menhir_action_150 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 2607 "lib/parser.ml"
     : (Ast.pattern list))

let _menhir_action_151 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 2615 "lib/parser.ml"
     : (Ast.pattern list))

let _menhir_action_152 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 2623 "lib/parser.ml"
     : (Ast.typ list))

let _menhir_action_153 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 2631 "lib/parser.ml"
     : (Ast.typ list))

let _menhir_action_154 =
  fun e p ->
    (
# 192 "lib/parser.mly"
                                    ( (p, e) )
# 2639 "lib/parser.ml"
     : (Ast.pattern * Ast.expr))

let _menhir_action_155 =
  fun e p ->
    (
# 193 "lib/parser.mly"
                              ( (p, e) )
# 2647 "lib/parser.ml"
     : (Ast.pattern * Ast.expr))

let _menhir_action_156 =
  fun id ->
    (
# 51 "lib/parser.mly"
                     ( [id] )
# 2655 "lib/parser.ml"
     : (string list))

let _menhir_action_157 =
  fun id rest ->
    (
# 52 "lib/parser.mly"
                                         ( id :: rest )
# 2663 "lib/parser.ml"
     : (string list))

let _menhir_action_158 =
  fun x ->
    (
# 228 "<standard.mly>"
    ( [ x ] )
# 2671 "lib/parser.ml"
     : ((Ast.pattern * Ast.expr) list))

let _menhir_action_159 =
  fun x xs ->
    (
# 231 "<standard.mly>"
    ( x :: xs )
# 2679 "lib/parser.ml"
     : ((Ast.pattern * Ast.expr) list))

let _menhir_action_160 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2687 "lib/parser.ml"
     : (string option))

let _menhir_action_161 =
  fun id ->
    let x = 
# 48 "lib/parser.mly"
                                                     (id)
# 2695 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2700 "lib/parser.ml"
     : (string option))

let _menhir_action_162 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2708 "lib/parser.ml"
     : (string option))

let _menhir_action_163 =
  fun r ->
    let x = 
# 78 "lib/parser.mly"
                                                                                                               (r)
# 2716 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2721 "lib/parser.ml"
     : (string option))

let _menhir_action_164 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2729 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_165 =
  fun t ->
    let x = 
# 132 "lib/parser.mly"
                                            (t)
# 2737 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2742 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_166 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2750 "lib/parser.ml"
     : (Ast.block option))

let _menhir_action_167 =
  fun e ->
    let x = 
# 171 "lib/parser.mly"
                                                                   (e)
# 2758 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2763 "lib/parser.ml"
     : (Ast.block option))

let _menhir_action_168 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2771 "lib/parser.ml"
     : (Ast.block option))

let _menhir_action_169 =
  fun e ->
    let x = 
# 212 "lib/parser.mly"
                                                                   (e)
# 2779 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2784 "lib/parser.ml"
     : (Ast.block option))

let _menhir_action_170 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2792 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_171 =
  fun t ->
    let x = 
# 78 "lib/parser.mly"
                                                                                                                                              (t)
# 2800 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2805 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_172 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2813 "lib/parser.ml"
     : (string option))

let _menhir_action_173 =
  fun r ->
    let x = 
# 80 "lib/parser.mly"
                                                                                                        (r)
# 2821 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2826 "lib/parser.ml"
     : (string option))

let _menhir_action_174 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2834 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_175 =
  fun t ->
    let x = 
# 80 "lib/parser.mly"
                                                                                                                                       (t)
# 2842 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2847 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_176 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2855 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_177 =
  fun t ->
    let x = 
# 84 "lib/parser.mly"
                                                                                              (t)
# 2863 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2868 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_178 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2876 "lib/parser.ml"
     : ((Ast.base_type * Ast.expr) option))

let _menhir_action_179 =
  fun e t ->
    let x = 
# 106 "lib/parser.mly"
                                                                                    ( (t, e) )
# 2884 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2889 "lib/parser.ml"
     : ((Ast.base_type * Ast.expr) option))

let _menhir_action_180 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2897 "lib/parser.ml"
     : (Ast.typ list option))

let _menhir_action_181 =
  fun xs ->
    let x =
      let types = 
# 241 "<standard.mly>"
    ( xs )
# 2906 "lib/parser.ml"
       in
      
# 115 "lib/parser.mly"
                                                                                     (types)
# 2911 "lib/parser.ml"
      
    in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2917 "lib/parser.ml"
     : (Ast.typ list option))

let _menhir_action_182 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2925 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_183 =
  fun t ->
    let x = 
# 128 "lib/parser.mly"
                                          (t)
# 2933 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2938 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_184 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2946 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_185 =
  fun t ->
    let x = 
# 130 "lib/parser.mly"
                                          (t)
# 2954 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 2959 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_186 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2967 "lib/parser.ml"
     : (Ast.expr option))

let _menhir_action_187 =
  fun x ->
    (
# 114 "<standard.mly>"
    ( Some x )
# 2975 "lib/parser.ml"
     : (Ast.expr option))

let _menhir_action_188 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2983 "lib/parser.ml"
     : (Ast.base_type option))

let _menhir_action_189 =
  fun x ->
    (
# 114 "<standard.mly>"
    ( Some x )
# 2991 "lib/parser.ml"
     : (Ast.base_type option))

let _menhir_action_190 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 2999 "lib/parser.ml"
     : ((Ast.override_kind * Ast.expr) option))

let _menhir_action_191 =
  fun x ->
    (
# 114 "<standard.mly>"
    ( Some x )
# 3007 "lib/parser.ml"
     : ((Ast.override_kind * Ast.expr) option))

let _menhir_action_192 =
  fun e ->
    (
# 111 "lib/parser.mly"
                 ( (Ast.IotaOverride, e) )
# 3015 "lib/parser.ml"
     : (Ast.override_kind * Ast.expr))

let _menhir_action_193 =
  fun e ->
    (
# 112 "lib/parser.mly"
                     ( (Ast.ValueOverride, e) )
# 3023 "lib/parser.ml"
     : (Ast.override_kind * Ast.expr))

let _menhir_action_194 =
  fun name typ ->
    (
# 88 "lib/parser.mly"
                             ( ({ name; typ } : Ast.param) )
# 3031 "lib/parser.ml"
     : (Ast.param))

let _menhir_action_195 =
  fun () ->
    (
# 201 "lib/parser.mly"
               ( PWildcard )
# 3039 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_196 =
  fun l ->
    (
# 202 "lib/parser.mly"
              ( PLit l )
# 3047 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_197 =
  fun _1 ->
    (
# 203 "lib/parser.mly"
          ( PIdent _1 )
# 3055 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_198 =
  fun id1 rest ->
    (
# 204 "lib/parser.mly"
                                          ( PVariant (List.hd (List.rev (id1 :: rest)), None) )
# 3063 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_199 =
  fun id1 rest xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 3071 "lib/parser.ml"
     in
    (
# 205 "lib/parser.mly"
                                                                                            ( PVariant (List.hd (List.rev (id1 :: rest)), Some args) )
# 3076 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_200 =
  fun () ->
    (
# 206 "lib/parser.mly"
       ( PVariant ("Ok", None) )
# 3084 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_201 =
  fun () ->
    (
# 207 "lib/parser.mly"
        ( PVariant ("Err", None) )
# 3092 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_202 =
  fun v xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 3100 "lib/parser.ml"
     in
    (
# 208 "lib/parser.mly"
                                                                      ( PVariant (v, Some args) )
# 3105 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_203 =
  fun imports items ->
    (
# 42 "lib/parser.mly"
                                                   ( { imports; items } )
# 3113 "lib/parser.ml"
     : (Ast.program))

let _menhir_action_204 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 3121 "lib/parser.ml"
     : (string list))

let _menhir_action_205 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 3129 "lib/parser.ml"
     : (string list))

let _menhir_action_206 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 3137 "lib/parser.ml"
     : (Ast.enum_member list))

let _menhir_action_207 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 3145 "lib/parser.ml"
     : (Ast.enum_member list))

let _menhir_action_208 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 3153 "lib/parser.ml"
     : (Ast.expr list))

let _menhir_action_209 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 3161 "lib/parser.ml"
     : (Ast.expr list))

let _menhir_action_210 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 3169 "lib/parser.ml"
     : (Ast.field list))

let _menhir_action_211 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 3177 "lib/parser.ml"
     : (Ast.field list))

let _menhir_action_212 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 3185 "lib/parser.ml"
     : ((string * Ast.expr) list))

let _menhir_action_213 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 3193 "lib/parser.ml"
     : ((string * Ast.expr) list))

let _menhir_action_214 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 3201 "lib/parser.ml"
     : (Ast.param list))

let _menhir_action_215 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 3209 "lib/parser.ml"
     : (Ast.param list))

let _menhir_action_216 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 3217 "lib/parser.ml"
     : (Ast.pattern list))

let _menhir_action_217 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 3225 "lib/parser.ml"
     : (Ast.pattern list))

let _menhir_action_218 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 3233 "lib/parser.ml"
     : (Ast.typ list))

let _menhir_action_219 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 3241 "lib/parser.ml"
     : (Ast.typ list))

let _menhir_action_220 =
  fun e ->
    (
# 45 "lib/parser.mly"
               ( e )
# 3249 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_221 =
  fun init name typ ->
    (
# 129 "lib/parser.mly"
    ( SDecl { kind = VLet; name; typ; init } )
# 3257 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_222 =
  fun init name typ ->
    (
# 131 "lib/parser.mly"
    ( SDecl { kind = VVar; name; typ; init } )
# 3265 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_223 =
  fun init name typ ->
    (
# 133 "lib/parser.mly"
    ( SDecl { kind = VConst; name; typ; init } )
# 3273 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_224 =
  fun e lhs ->
    (
# 134 "lib/parser.mly"
                                 ( SAssign (lhs, e) )
# 3281 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_225 =
  fun e ->
    (
# 135 "lib/parser.mly"
                                    ( SReturn e )
# 3289 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_226 =
  fun e ->
    (
# 136 "lib/parser.mly"
                     ( SExpr e )
# 3297 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_227 =
  fun b cond ->
    (
# 137 "lib/parser.mly"
                                      ( SWhile (cond, b) )
# 3305 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_228 =
  fun b e id ->
    (
# 138 "lib/parser.mly"
                                             ( SFor (id, e, b) )
# 3313 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_229 =
  fun name xs ->
    let fields = 
# 241 "<standard.mly>"
    ( xs )
# 3321 "lib/parser.ml"
     in
    let v = 
# 38 "lib/parser.mly"
        ( true )
# 3326 "lib/parser.ml"
     in
    (
# 66 "lib/parser.mly"
                                                                                     ( { is_pub = v; name; fields } )
# 3331 "lib/parser.ml"
     : (Ast.struct_decl))

let _menhir_action_230 =
  fun name xs ->
    let fields = 
# 241 "<standard.mly>"
    ( xs )
# 3339 "lib/parser.ml"
     in
    let v = 
# 39 "lib/parser.mly"
                ( false )
# 3344 "lib/parser.ml"
     in
    (
# 66 "lib/parser.mly"
                                                                                     ( { is_pub = v; name; fields } )
# 3349 "lib/parser.ml"
     : (Ast.struct_decl))

let _menhir_action_231 =
  fun methods name ->
    let v = 
# 38 "lib/parser.mly"
        ( true )
# 3357 "lib/parser.ml"
     in
    (
# 69 "lib/parser.mly"
                                                                     ( { is_pub = v; name; methods } )
# 3362 "lib/parser.ml"
     : (Ast.trait_decl))

let _menhir_action_232 =
  fun methods name ->
    let v = 
# 39 "lib/parser.mly"
                ( false )
# 3370 "lib/parser.ml"
     in
    (
# 69 "lib/parser.mly"
                                                                     ( { is_pub = v; name; methods } )
# 3375 "lib/parser.ml"
     : (Ast.trait_decl))

let _menhir_action_233 =
  fun b ->
    (
# 91 "lib/parser.mly"
                ( TBase b )
# 3383 "lib/parser.ml"
     : (Ast.typ))

let _menhir_action_234 =
  fun b role ->
    (
# 92 "lib/parser.mly"
                              ( TRole (TBase b, role) )
# 3391 "lib/parser.ml"
     : (Ast.typ))

let _menhir_action_235 =
  fun t1 t2 ->
    (
# 93 "lib/parser.mly"
                                     ( TResult (t1, t2) )
# 3399 "lib/parser.ml"
     : (Ast.typ))

let _menhir_action_236 =
  fun role t1 t2 ->
    (
# 94 "lib/parser.mly"
                                                   ( TRole (TResult (t1, t2), role) )
# 3407 "lib/parser.ml"
     : (Ast.typ))

let _menhir_action_237 =
  fun t ->
    (
# 95 "lib/parser.mly"
                            ( TArray t )
# 3415 "lib/parser.ml"
     : (Ast.typ))

let _menhir_action_238 =
  fun role t ->
    (
# 96 "lib/parser.mly"
                                          ( TRole (TArray t, role) )
# 3423 "lib/parser.ml"
     : (Ast.typ))

let _menhir_action_239 =
  fun _1 ->
    (
# 196 "lib/parser.mly"
          ( _1 )
# 3431 "lib/parser.ml"
     : (string))

let _menhir_action_240 =
  fun () ->
    (
# 197 "lib/parser.mly"
       ( "Ok" )
# 3439 "lib/parser.ml"
     : (string))

let _menhir_action_241 =
  fun () ->
    (
# 198 "lib/parser.mly"
        ( "Err" )
# 3447 "lib/parser.ml"
     : (string))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | WHILE ->
        "WHILE"
    | VAR ->
        "VAR"
    | USIZE ->
        "USIZE"
    | UNDERSCORE ->
        "UNDERSCORE"
    | U8 ->
        "U8"
    | U64 ->
        "U64"
    | U32 ->
        "U32"
    | U16 ->
        "U16"
    | TRANSFER ->
        "TRANSFER"
    | TRAIT ->
        "TRAIT"
    | STRUCT ->
        "STRUCT"
    | STRING_VAL _ ->
        "STRING_VAL"
    | STR ->
        "STR"
    | STAR ->
        "STAR"
    | SLASH ->
        "SLASH"
    | SHR ->
        "SHR"
    | SHL ->
        "SHL"
    | SEMICOLON ->
        "SEMICOLON"
    | RPAREN ->
        "RPAREN"
    | ROLE ->
        "ROLE"
    | RETURN ->
        "RETURN"
    | RESULT ->
        "RESULT"
    | RBRACKET ->
        "RBRACKET"
    | RBRACE ->
        "RBRACE"
    | PUB ->
        "PUB"
    | PLUS ->
        "PLUS"
    | OR ->
        "OR"
    | OK ->
        "OK"
    | NOT ->
        "NOT"
    | NEQ ->
        "NEQ"
    | MINUS ->
        "MINUS"
    | MATCH ->
        "MATCH"
    | LTE ->
        "LTE"
    | LT ->
        "LT"
    | LPAREN ->
        "LPAREN"
    | LET ->
        "LET"
    | LBRACKET ->
        "LBRACKET"
    | LBRACE ->
        "LBRACE"
    | ISIZE ->
        "ISIZE"
    | IOTA ->
        "IOTA"
    | INT _ ->
        "INT"
    | IN ->
        "IN"
    | IMPORT ->
        "IMPORT"
    | IMPL ->
        "IMPL"
    | IF ->
        "IF"
    | IDENT _ ->
        "IDENT"
    | I8 ->
        "I8"
    | I64 ->
        "I64"
    | I32 ->
        "I32"
    | I16 ->
        "I16"
    | GTE ->
        "GTE"
    | GT ->
        "GT"
    | GLOBAL ->
        "GLOBAL"
    | GENERIC ->
        "GENERIC"
    | FSTRING_VAL _ ->
        "FSTRING_VAL"
    | FOR ->
        "FOR"
    | FN ->
        "FN"
    | FATARROW ->
        "FATARROW"
    | EXTERN ->
        "EXTERN"
    | ERR ->
        "ERR"
    | EQEQ ->
        "EQEQ"
    | EQ ->
        "EQ"
    | EOF ->
        "EOF"
    | ENUM ->
        "ENUM"
    | ELSE ->
        "ELSE"
    | DOT ->
        "DOT"
    | DOLLAR_EQ ->
        "DOLLAR_EQ"
    | CONST ->
        "CONST"
    | COMMA ->
        "COMMA"
    | COLONCOLON ->
        "COLONCOLON"
    | COLON ->
        "COLON"
    | BOOL_VAL _ ->
        "BOOL_VAL"
    | BOOL ->
        "BOOL"
    | BITOR ->
        "BITOR"
    | BITAND ->
        "BITAND"
    | AT_EQ ->
        "AT_EQ"
    | AT ->
        "AT"
    | AS ->
        "AS"
    | AND ->
        "AND"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_517 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_list_import_decl_ -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_list_import_decl_ (_menhir_stack, _, imports) = _menhir_stack in
      let items = _v in
      let _v = _menhir_action_203 imports items in
      MenhirBox_program _v
  
  let rec _menhir_run_520 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_item -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_item (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_136 x xs in
      _menhir_goto_list_item_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_item_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState014 ->
          _menhir_run_517 _menhir_stack _v
      | MenhirState519 ->
          _menhir_run_520 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_001 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IMPORT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState001 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OK ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_002 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_240 () in
      _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_variant_ident : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState001 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState004 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState094 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState099 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState100 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState101 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState102 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState104 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState105 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState106 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState119 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState121 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState133 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState140 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState142 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState144 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState148 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState153 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState155 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState157 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState159 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState162 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState164 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState166 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState168 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState170 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState172 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState174 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState176 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState178 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState180 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState182 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState198 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState199 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState200 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState201 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState204 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState208 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState210 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState216 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState219 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState223 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState228 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState230 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState235 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState241 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState243 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState245 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState247 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState249 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState252 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState254 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState256 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState258 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState260 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState262 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState264 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState266 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState268 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState269 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState271 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState273 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState281 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState284 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState294 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState299 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState307 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState310 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState313 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState321 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState327 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState343 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState350 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState406 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState440 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState452 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState454 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState495 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState523 ->
          _menhir_run_006 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState323 ->
          _menhir_run_331 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState329 ->
          _menhir_run_331 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState332 ->
          _menhir_run_331 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState335 ->
          _menhir_run_331 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState348 ->
          _menhir_run_331 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState360 ->
          _menhir_run_331 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState377 ->
          _menhir_run_331 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState444 ->
          _menhir_run_446 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState462 ->
          _menhir_run_446 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState508 ->
          _menhir_run_446 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_006 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let id = _v in
      let _v = _menhir_action_156 id in
      _menhir_goto_module_path _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_module_path : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState004 ->
          _menhir_run_007 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState001 ->
          _menhir_run_008 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState094 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState099 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState100 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState101 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState104 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState105 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState106 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState121 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState133 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState140 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState142 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState144 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState148 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState153 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState155 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState157 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState159 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState162 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState164 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState166 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState168 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState170 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState172 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState174 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState176 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState178 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState180 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState182 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState201 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState204 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState210 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState219 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState223 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState230 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState235 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState268 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState281 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState284 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState294 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState307 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState310 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState313 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState343 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState406 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState440 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState452 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState454 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState495 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState523 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState102 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState119 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState198 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState199 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState200 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState208 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState216 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState228 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState241 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState243 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState245 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState247 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState249 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState252 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState254 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState256 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState258 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState260 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState262 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState264 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState266 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState269 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState271 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState273 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState299 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState321 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState350 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState327 ->
          _menhir_run_328 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_007 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
      let rest = _v in
      let _v = _menhir_action_157 id rest in
      _menhir_goto_module_path _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_008 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IMPORT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_module_path (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | AS ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let id = _v_0 in
              let _v = _menhir_action_161 id in
              _menhir_goto_option___anonymous_0_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | SEMICOLON ->
          let _v = _menhir_action_160 () in
          _menhir_goto_option___anonymous_0_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_0_ : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IMPORT, _menhir_box_program) _menhir_cell1_module_path -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_module_path (_menhir_stack, _, path) = _menhir_stack in
          let MenhirCell1_IMPORT (_menhir_stack, _menhir_s) = _menhir_stack in
          let alias = _v in
          let _v = _menhir_action_110 alias path in
          let _menhir_stack = MenhirCell1_import_decl (_menhir_stack, _menhir_s, _v) in
          (match (_tok : MenhirBasics.token) with
          | IMPORT ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState521
          | ENUM | EOF | EXTERN | FN | GENERIC | GLOBAL | IMPL | PUB | ROLE | STRUCT | TRAIT ->
              let _v_0 = _menhir_action_133 () in
              _menhir_run_522 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_522 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_import_decl -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_import_decl (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_134 x xs in
      _menhir_goto_list_import_decl_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_import_decl_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState000 ->
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState521 ->
          _menhir_run_522 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_014 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_import_decl_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRAIT ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | STRUCT ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | ROLE ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | PUB ->
          _menhir_run_391 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | IMPL ->
          _menhir_run_464 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | GLOBAL ->
          _menhir_run_491 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | GENERIC ->
          _menhir_run_498 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | FN ->
          _menhir_run_470 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | EXTERN ->
          _menhir_run_478 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | ENUM ->
          _menhir_run_505 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState014
      | EOF ->
          let _v_0 = _menhir_action_135 () in
          _menhir_run_517 _menhir_stack _v_0
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_015 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_TRAIT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | FN ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState017
              | RBRACE ->
                  let _v_0 = _menhir_action_131 () in
                  _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_018 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_0 ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState020
              | RPAREN ->
                  let _v_1 = _menhir_action_148 () in
                  _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState020
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_021 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState022 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_023 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_006 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_base_type : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState022 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState030 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState031 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState039 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState042 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState055 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState068 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState080 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState125 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState151 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState214 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState238 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState278 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState291 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState304 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState404 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState418 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState432 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState447 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState466 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState493 ->
          _menhir_run_044 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState048 ->
          _menhir_run_049 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState438 ->
          _menhir_run_439 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_044 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | AT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let (b, role) = (_v, _v_0) in
              let _v = _menhir_action_234 b role in
              _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let b = _v in
          let _v = _menhir_action_233 b in
          _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_typ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState039 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState042 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState125 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState214 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState447 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState031 ->
          _menhir_run_050 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState030 ->
          _menhir_run_054 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState055 ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState022 ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState068 ->
          _menhir_run_069 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState080 ->
          _menhir_run_081 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState151 ->
          _menhir_run_152 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState238 ->
          _menhir_run_239 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState278 ->
          _menhir_run_279 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState291 ->
          _menhir_run_292 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState304 ->
          _menhir_run_305 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState404 ->
          _menhir_run_405 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState418 ->
          _menhir_run_419 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState432 ->
          _menhir_run_433 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState466 ->
          _menhir_run_467 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState493 ->
          _menhir_run_494 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_041 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState042 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | GT | RPAREN ->
          let x = _v in
          let _v = _menhir_action_218 x in
          _menhir_goto_separated_nonempty_list_COMMA_typ_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_024 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_002 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_025 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_005 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_026 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_004 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_027 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_003 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_028 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_013 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_029 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RESULT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LT ->
          let _menhir_s = MenhirState030 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_031 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState031 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | USIZE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U8 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U64 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U32 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U16 ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STR ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | RESULT ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ISIZE ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | I8 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I32 ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I16 ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | GENERIC ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_032 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_011 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_033 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let id = _v in
      let _v = _menhir_action_014 id in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_034 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_007 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_035 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_010 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_036 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_009 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_037 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_008 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_038 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GENERIC (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LT ->
          let _menhir_s = MenhirState039 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_040 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_012 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_separated_nonempty_list_COMMA_typ_ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState042 ->
          _menhir_run_043 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState039 ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState125 ->
          _menhir_run_126 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState214 ->
          _menhir_run_215 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState447 ->
          _menhir_run_448 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_043 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_typ -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_typ (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_219 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_typ_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_047 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_GENERIC as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_separated_nonempty_list_COMMA_typ_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | GT ->
          let _menhir_s = MenhirState048 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_126 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_GENERIC as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_separated_nonempty_list_COMMA_typ_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | GT ->
          let _menhir_s = MenhirState127 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_095 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_TRANSFER (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState096 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_097 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let v = _v in
      let _v = _menhir_action_139 v in
      _menhir_goto_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_literal : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState094 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState099 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState100 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState101 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState104 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState105 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState106 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState121 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState133 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState140 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState142 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState144 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState148 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState153 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState155 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState157 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState159 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState162 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState164 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState166 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState168 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState170 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState172 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState174 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState176 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState178 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState180 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState182 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState201 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState204 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState210 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState219 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState223 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState230 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState235 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState268 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState281 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState284 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState294 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState307 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState310 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState313 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState343 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState406 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState440 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState452 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState454 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState495 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState523 ->
          _menhir_run_137 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState102 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState119 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState198 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState199 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState200 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState208 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState216 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState228 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState241 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState243 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState245 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState247 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState249 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState252 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState254 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState256 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState258 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState260 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState262 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState264 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState266 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState269 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState271 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState273 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState299 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState321 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState350 ->
          _menhir_run_226 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState323 ->
          _menhir_run_337 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState329 ->
          _menhir_run_337 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState332 ->
          _menhir_run_337 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState335 ->
          _menhir_run_337 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState348 ->
          _menhir_run_337 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState360 ->
          _menhir_run_337 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState377 ->
          _menhir_run_337 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_137 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let l = _v in
      let _v = _menhir_action_061 l in
      _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr_base_expr_ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let e = _v in
      let _v = _menhir_action_027 e in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState106 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState133 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState148 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState182 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState204 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState210 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState223 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState235 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState140 ->
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState142 ->
          _menhir_run_143 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState144 ->
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState153 ->
          _menhir_run_154 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState155 ->
          _menhir_run_156 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState157 ->
          _menhir_run_158 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState159 ->
          _menhir_run_160 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState162 ->
          _menhir_run_163 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState164 ->
          _menhir_run_165 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState166 ->
          _menhir_run_167 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState168 ->
          _menhir_run_169 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState170 ->
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState172 ->
          _menhir_run_173 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState174 ->
          _menhir_run_175 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState176 ->
          _menhir_run_177 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState178 ->
          _menhir_run_179 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState180 ->
          _menhir_run_181 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState130 ->
          _menhir_run_191 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState127 ->
          _menhir_run_193 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState121 ->
          _menhir_run_196 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState201 ->
          _menhir_run_202 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState219 ->
          _menhir_run_220 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState230 ->
          _menhir_run_231 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState281 ->
          _menhir_run_282 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState284 ->
          _menhir_run_287 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState294 ->
          _menhir_run_295 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState307 ->
          _menhir_run_308 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState268 ->
          _menhir_run_311 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState310 ->
          _menhir_run_311 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState313 ->
          _menhir_run_314 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState343 ->
          _menhir_run_344 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState105 ->
          _menhir_run_370 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState104 ->
          _menhir_run_372 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState101 ->
          _menhir_run_380 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState100 ->
          _menhir_run_381 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState099 ->
          _menhir_run_382 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_384 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState094 ->
          _menhir_run_388 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState406 ->
          _menhir_run_407 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState440 ->
          _menhir_run_441 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState452 ->
          _menhir_run_453 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState454 ->
          _menhir_run_455 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState495 ->
          _menhir_run_496 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState523 ->
          _menhir_run_525 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_139 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState182 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RBRACKET | RPAREN ->
          let x = _v in
          let _v = _menhir_action_208 x in
          _menhir_goto_separated_nonempty_list_COMMA_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_140 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState140 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_098 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_OK (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState099 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let _v = _menhir_action_240 () in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_100 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NOT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState100 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_101 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState101 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_102 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MATCH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState102 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_103 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_TRANSFER (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState104 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_105 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState105 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_106 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState106
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState106
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState106
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState106
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState106
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState106
      | RBRACKET ->
          let _v = _menhir_action_142 () in
          _menhir_run_368 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_107 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_051 () in
      _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_108 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_INT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | U8 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_111 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | U64 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_114 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | U32 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_113 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | U16 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_112 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | I8 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_115 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | I64 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_118 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | I32 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_117 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | I16 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_116 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | FATARROW | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let _v = _menhir_action_188 () in
          _menhir_goto_option_int_suffix_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_int_suffix : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_INT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_189 x in
      _menhir_goto_option_int_suffix_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_option_int_suffix_ : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_INT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_INT (_menhir_stack, _menhir_s, v) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_137 t v in
      _menhir_goto_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_119 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState119 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_120 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_OK (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState121 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AND | AS | BITAND | BITOR | DOT | EQEQ | GT | GTE | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR | SLASH | STAR ->
          let _v = _menhir_action_240 () in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_122 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | STRING_VAL _v_0 ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState123
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | INT _v_1 ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState123
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | IDENT _v_2 ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState123
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | FSTRING_VAL _v_3 ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState123
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState123
          | BOOL_VAL _v_4 ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState123
          | RPAREN ->
              let _v_5 = _menhir_action_142 () in
              _menhir_run_194 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 _tok
          | _ ->
              _eRR ())
      | COLONCOLON ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let _1 = _v in
          let _v = _menhir_action_239 _1 in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_124 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GENERIC (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LT ->
          let _menhir_s = MenhirState125 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_128 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let s = _v in
      let _v = _menhir_action_062 s in
      _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_129 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ERR (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState130 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let _v = _menhir_action_241 () in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_131 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let v = _v in
      let _v = _menhir_action_138 v in
      _menhir_goto_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_194 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_050 id xs in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_004 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_IDENT -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState004 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | OK ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_003 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLONCOLON ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | FATARROW | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LPAREN | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let _1 = _v in
          let _v = _menhir_action_239 _1 in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_005 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_241 () in
      _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_198 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NOT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState198 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_199 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState199 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_200 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MATCH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState200 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_201 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState201 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_204 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState204
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState204
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState204
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState204
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState204
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState204
      | RBRACKET ->
          let _v = _menhir_action_142 () in
          _menhir_run_205 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_205 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_LBRACKET -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_093 xs in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_expr_base_expr_no_struct_ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let e = _v in
      let _v = _menhir_action_101 e in
      _menhir_goto_expr_no_struct _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr_no_struct : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState216 ->
          _menhir_run_227 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState228 ->
          _menhir_run_229 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState241 ->
          _menhir_run_242 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState243 ->
          _menhir_run_244 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState245 ->
          _menhir_run_246 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState247 ->
          _menhir_run_248 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState249 ->
          _menhir_run_250 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState208 ->
          _menhir_run_251 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState252 ->
          _menhir_run_253 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState254 ->
          _menhir_run_255 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState256 ->
          _menhir_run_257 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState258 ->
          _menhir_run_259 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState260 ->
          _menhir_run_261 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState262 ->
          _menhir_run_263 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState264 ->
          _menhir_run_265 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState266 ->
          _menhir_run_267 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState269 ->
          _menhir_run_270 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState271 ->
          _menhir_run_272 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState273 ->
          _menhir_run_274 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState299 ->
          _menhir_run_300 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState321 ->
          _menhir_run_322 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState350 ->
          _menhir_run_351 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState200 ->
          _menhir_run_359 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState199 ->
          _menhir_run_363 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState198 ->
          _menhir_run_364 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState119 ->
          _menhir_run_365 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState102 ->
          _menhir_run_376 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_227 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_GENERIC, ttv_result) _menhir_cell1_separated_nonempty_list_COMMA_typ_ as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState227
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR ->
          let MenhirCell1_separated_nonempty_list_COMMA_typ_ (_menhir_stack, _, args) = _menhir_stack in
          let MenhirCell1_GENERIC (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_096 args e in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_228 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STAR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState228 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_207 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_087 () in
      _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_208 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState208 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_209 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | STRING_VAL _v_0 ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState210
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | INT _v_1 ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState210
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | IDENT _v_2 ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState210
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | FSTRING_VAL _v_3 ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState210
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState210
          | BOOL_VAL _v_4 ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState210
          | RPAREN ->
              let _v_5 = _menhir_action_142 () in
              _menhir_run_211 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 _tok
          | _ ->
              _eRR ())
      | COLONCOLON ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | AS | BITAND | BITOR | DOT | EQEQ | GT | GTE | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR | SLASH | STAR ->
          let _1 = _v in
          let _v = _menhir_action_239 _1 in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_211 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_086 id xs in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_213 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GENERIC (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LT ->
          let _menhir_s = MenhirState214 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_217 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let s = _v in
      let _v = _menhir_action_098 s in
      _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_218 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_ERR (_menhir_stack, _menhir_s) in
          let _menhir_s = MenhirState219 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AND | AS | BITAND | BITOR | DOT | EQEQ | GT | GTE | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR | SLASH | STAR ->
          let _v = _menhir_action_241 () in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_241 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SLASH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState241 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_243 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SHR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState243 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_249 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SHL (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState249 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_245 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PLUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState245 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_247 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState247 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_230 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState230 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_233 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _menhir_stack = MenhirCell1_DOT (_menhir_stack, _menhir_s) in
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRANSFER ->
                  _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | STRING_VAL _v_0 ->
                  _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState235
              | OK ->
                  _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | NOT ->
                  _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | MINUS ->
                  _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | MATCH ->
                  _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | LPAREN ->
                  _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | LBRACKET ->
                  _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | IOTA ->
                  _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | INT _v_1 ->
                  _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState235
              | IF ->
                  _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | IDENT _v_2 ->
                  _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState235
              | GENERIC ->
                  _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | FSTRING_VAL _v_3 ->
                  _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState235
              | ERR ->
                  _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState235
              | BOOL_VAL _v_4 ->
                  _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState235
              | RPAREN ->
                  let _v_5 = _menhir_action_142 () in
                  _menhir_run_236 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 _tok
              | _ ->
                  _eRR ())
          | AND | AS | BITAND | BITOR | DOT | EQEQ | GT | GTE | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR | SLASH | STAR ->
              let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e) = _menhir_stack in
              let f = _v in
              let _v = _menhir_action_090 e f in
              _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_236 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_DOT _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
          let MenhirCell1_DOT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_089 e1 id xs in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_238 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_AS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState238 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | USIZE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U8 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U64 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U32 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U16 ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STR ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | RESULT ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ISIZE ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | I8 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I32 ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I16 ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | GENERIC ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_229 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState229
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR | SLASH | STAR ->
          let MenhirCell1_STAR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_069 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_242 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_SLASH as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState242
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState242
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState242
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR | SLASH | STAR ->
          let MenhirCell1_SLASH (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_070 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_244 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_SHR as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState244
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR | SHL | SHR ->
          let MenhirCell1_SHR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_072 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_246 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_PLUS as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState246
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState246
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState246
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState246
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState246
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR ->
          let MenhirCell1_PLUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_067 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_248 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_MINUS as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState248
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState248
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState248
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState248
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState248
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR ->
          let MenhirCell1_MINUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_068 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_250 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_SHL as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState250
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState250
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState250
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState250
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState250
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState250
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState250
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR | SHL | SHR ->
          let MenhirCell1_SHL (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_071 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_251 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | SLASH ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | SHR ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | SHL ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | PLUS ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | OR ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | NEQ ->
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | MINUS ->
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | LTE ->
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | LT ->
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | LBRACKET ->
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | LBRACE ->
          _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | GTE ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | GT ->
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | EQEQ ->
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | DOT ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | BITOR ->
          _menhir_run_271 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | BITAND ->
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | AS ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | AND ->
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState251
      | _ ->
          _eRR ()
  
  and _menhir_run_252 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_OR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState252 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_254 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NEQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState254 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_256 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LTE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState256 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_258 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState258 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_268 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_269 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | VAR ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_276 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | TRANSFER ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | STRING_VAL _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState268
      | RETURN ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_284 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | RBRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_016 () in
          _menhir_goto_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | OK ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | NOT ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | MINUS ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | MATCH ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | LPAREN ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | LET ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_289 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | IOTA ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | INT _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState268
      | IF ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | IDENT _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState268
      | GENERIC ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | FSTRING_VAL _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState268
      | FOR ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_297 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | ERR ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | CONST ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_302 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState268
      | BOOL_VAL _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState268
      | _ ->
          _eRR ()
  
  and _menhir_run_269 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState269 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_276 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState278 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | USIZE ->
                  _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U8 ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACKET ->
                  _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ISIZE ->
                  _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | GENERIC ->
                  _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | EQ ->
              let _v = _menhir_action_184 () in
              _menhir_goto_option___anonymous_9_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_9_ : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_VAR _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option___anonymous_9_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState281 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_284 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RETURN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState284 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | SEMICOLON ->
          let _v = _menhir_action_186 () in
          _menhir_goto_option_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_goto_option_expr_ : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_RETURN -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_RETURN (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_225 e in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_stmt : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_269 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | VAR ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_276 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | TRANSFER ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | STRING_VAL _v_0 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState310
      | RETURN ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_284 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | OK ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | NOT ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | MINUS ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | MATCH ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | LPAREN ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | LET ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_289 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | IOTA ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | INT _v_1 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState310
      | IF ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | IDENT _v_2 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState310
      | GENERIC ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | FSTRING_VAL _v_3 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState310
      | FOR ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_297 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | ERR ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | CONST ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_302 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState310
      | BOOL_VAL _v_4 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState310
      | RBRACE ->
          let s = _v in
          let _v = _menhir_action_019 s in
          _menhir_goto_block_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_289 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LET (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState291 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | USIZE ->
                  _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U8 ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACKET ->
                  _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ISIZE ->
                  _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | GENERIC ->
                  _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | EQ ->
              let _v = _menhir_action_182 () in
              _menhir_goto_option___anonymous_8_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_8_ : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_LET _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option___anonymous_8_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState294 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_297 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FOR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IN ->
              let _menhir_s = MenhirState299 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRANSFER ->
                  _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STRING_VAL _v ->
                  _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | OK ->
                  _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | NOT ->
                  _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | MINUS ->
                  _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | MATCH ->
                  _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LPAREN ->
                  _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACKET ->
                  _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IOTA ->
                  _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT _v ->
                  _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | IF ->
                  _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | GENERIC ->
                  _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | FSTRING_VAL _v ->
                  _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | ERR ->
                  _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL_VAL _v ->
                  _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_302 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CONST (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState304 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | USIZE ->
                  _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U8 ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACKET ->
                  _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ISIZE ->
                  _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | GENERIC ->
                  _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | EQ ->
              let _v = _menhir_action_164 () in
              _menhir_goto_option___anonymous_10_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_10_ : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_CONST _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option___anonymous_10_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState307 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_block_stmts : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState310 ->
          _menhir_run_316 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState268 ->
          _menhir_run_317 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_316 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_stmt -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_stmt (_menhir_stack, _menhir_s, s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_020 b s in
      _menhir_goto_block_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_317 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_LBRACE -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_017 b in
      _menhir_goto_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_block : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState270 ->
          _menhir_run_275 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState300 ->
          _menhir_run_301 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState251 ->
          _menhir_run_319 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState351 ->
          _menhir_run_352 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState320 ->
          _menhir_run_355 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState353 ->
          _menhir_run_355 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState365 ->
          _menhir_run_366 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState420 ->
          _menhir_run_421 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState476 ->
          _menhir_run_477 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_275 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_WHILE, ttv_result) _menhir_cell1_expr_no_struct -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr_no_struct (_menhir_stack, _, cond) = _menhir_stack in
      let MenhirCell1_WHILE (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_227 b cond in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_301 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_FOR _menhir_cell0_IDENT, ttv_result) _menhir_cell1_expr_no_struct -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr_no_struct (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
      let MenhirCell1_FOR (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_228 b e id in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_319 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_block (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          _menhir_run_320 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState319
      | AND | AS | BITAND | BITOR | DOT | EQEQ | GT | GTE | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR | SLASH | STAR ->
          let _v_0 = _menhir_action_166 () in
          _menhir_run_358 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_320 : type  ttv_stack ttv_result. ((((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_block as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ELSE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState320 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MATCH ->
          _menhir_run_321 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACE ->
          _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IF ->
          _menhir_run_350 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_321 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MATCH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState321 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_350 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState350 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_358 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_block -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_block (_menhir_stack, _, thn) = _menhir_stack in
      let MenhirCell1_expr_no_struct (_menhir_stack, _, cond) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let els = _v in
      let _v = _menhir_action_088 cond els thn in
      _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_352 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_block (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _menhir_s = MenhirState353 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | MATCH ->
              _menhir_run_321 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACE ->
              _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_350 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let _v = _menhir_action_168 () in
          _menhir_goto_option___anonymous_12_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_12_ : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_block -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_block (_menhir_stack, _, thn) = _menhir_stack in
      let MenhirCell1_expr_no_struct (_menhir_stack, _, cond) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let els = _v in
      let _v = _menhir_action_022 cond els thn in
      _menhir_goto_else_branch _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_else_branch : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState353 ->
          _menhir_run_354 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState320 ->
          _menhir_run_357 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_354 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_block -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let e = _v in
      let _v = _menhir_action_169 e in
      _menhir_goto_option___anonymous_12_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_357 : type  ttv_stack ttv_result. ((((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_block, ttv_result) _menhir_cell1_ELSE -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_ELSE (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_167 e in
      _menhir_goto_option___anonymous_11_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_option___anonymous_11_ : type  ttv_stack ttv_result. ((((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_block as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState319 ->
          _menhir_run_358 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState366 ->
          _menhir_run_367 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_367 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_block -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_block (_menhir_stack, _, thn) = _menhir_stack in
      let MenhirCell1_expr_no_struct (_menhir_stack, _, cond) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let els = _v in
      let _v = _menhir_action_052 cond els thn in
      _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_355 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let b = _v in
      let _v = _menhir_action_021 b in
      _menhir_goto_else_branch _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_366 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_IF, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_block (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          _menhir_run_320 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState366
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let _v_0 = _menhir_action_166 () in
          _menhir_run_367 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_421 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_, _menhir_box_program) _menhir_cell1_option___anonymous_4_ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_option___anonymous_4_ (_menhir_stack, _, ret) = _menhir_stack in
      let MenhirCell1_option___anonymous_3_ (_menhir_stack, _, role) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _, xs) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_PUB (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_106 b name ret role xs in
      _menhir_goto_fn_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_fn_decl : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState468 ->
          _menhir_run_489 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState489 ->
          _menhir_run_489 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState014 ->
          _menhir_run_515 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState504 ->
          _menhir_run_515 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState519 ->
          _menhir_run_515 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_489 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_fn_decl (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | PUB ->
          _menhir_run_469 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState489
      | FN ->
          _menhir_run_470 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState489
      | EXTERN ->
          _menhir_run_478 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState489
      | RBRACE ->
          let _v_0 = _menhir_action_129 () in
          _menhir_run_490 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0
      | _ ->
          _eRR ()
  
  and _menhir_run_469 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PUB (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | FN ->
          _menhir_run_409 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EXTERN ->
          _menhir_run_422 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_409 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_PUB -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_0 ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState411
              | RPAREN ->
                  let _v_1 = _menhir_action_148 () in
                  _menhir_run_412 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState411
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_412 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AT ->
          _menhir_run_414 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState413
      | LBRACE | MINUS ->
          let _v_0 = _menhir_action_172 () in
          _menhir_run_416 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState413 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_414 : type  ttv_stack. ((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let r = _v in
          let _v = _menhir_action_173 r in
          _menhir_goto_option___anonymous_3_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_3_ : type  ttv_stack. ((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState413 ->
          _menhir_run_416 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState474 ->
          _menhir_run_475 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_416 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option___anonymous_3_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_417 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState416
      | LBRACE ->
          let _v_0 = _menhir_action_174 () in
          _menhir_run_420 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState416 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_417 : type  ttv_stack. (((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_ as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | GT ->
          let _menhir_s = MenhirState418 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_420 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option___anonymous_4_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState420
      | _ ->
          _eRR ()
  
  and _menhir_run_475 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option___anonymous_3_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_417 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState475
      | LBRACE ->
          let _v_0 = _menhir_action_174 () in
          _menhir_run_476 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState475 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_476 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option___anonymous_4_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState476
      | _ ->
          _eRR ()
  
  and _menhir_run_422 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_PUB -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | FN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | LPAREN ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | IDENT _v_0 ->
                      _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState425
                  | RPAREN ->
                      let _v_1 = _menhir_action_148 () in
                      _menhir_run_426 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState425
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_426 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AT ->
          _menhir_run_428 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState427
      | MINUS | SEMICOLON ->
          let _v_0 = _menhir_action_162 () in
          _menhir_run_430 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState427 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_428 : type  ttv_stack. ((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let r = _v in
          let _v = _menhir_action_163 r in
          _menhir_goto_option___anonymous_1_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_1_ : type  ttv_stack. ((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState427 ->
          _menhir_run_430 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState483 ->
          _menhir_run_484 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_430 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option___anonymous_1_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_431 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState430
      | SEMICOLON ->
          let _v_0 = _menhir_action_170 () in
          _menhir_run_434 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_431 : type  ttv_stack. (((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_1_ as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | GT ->
          let _menhir_s = MenhirState432 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_434 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_1_ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_option___anonymous_1_ (_menhir_stack, _, role) = _menhir_stack in
          let MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _, xs) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_PUB (_menhir_stack, _menhir_s) = _menhir_stack in
          let ret = _v in
          let _v = _menhir_action_104 name ret role xs in
          _menhir_goto_fn_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_484 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_EXTERN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option___anonymous_1_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          _menhir_run_431 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState484
      | SEMICOLON ->
          let _v_0 = _menhir_action_170 () in
          _menhir_run_485 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_485 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_EXTERN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_1_ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_option___anonymous_1_ (_menhir_stack, _, role) = _menhir_stack in
          let MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _, xs) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_EXTERN (_menhir_stack, _menhir_s) = _menhir_stack in
          let ret = _v in
          let _v = _menhir_action_105 name ret role xs in
          _menhir_goto_fn_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_470 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_0 ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState472
              | RPAREN ->
                  let _v_1 = _menhir_action_148 () in
                  _menhir_run_473 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState472
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_473 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AT ->
          _menhir_run_414 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState474
      | LBRACE | MINUS ->
          let _v_0 = _menhir_action_172 () in
          _menhir_run_475 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState474 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_478 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_EXTERN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | FN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | LPAREN ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | IDENT _v_0 ->
                      _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState481
                  | RPAREN ->
                      let _v_1 = _menhir_action_148 () in
                      _menhir_run_482 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState481
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_482 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_EXTERN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AT ->
          _menhir_run_428 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState483
      | MINUS | SEMICOLON ->
          let _v_0 = _menhir_action_162 () in
          _menhir_run_484 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState483 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_490 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_fn_decl -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_fn_decl (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_130 x xs in
      _menhir_goto_list_fn_decl_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_fn_decl_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState468 ->
          _menhir_run_487 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState489 ->
          _menhir_run_490 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_487 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IMPL _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_typ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_typ (_menhir_stack, _, t) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, trait_name) = _menhir_stack in
      let MenhirCell1_IMPL (_menhir_stack, _menhir_s) = _menhir_stack in
      let methods = _v in
      let _v = _menhir_action_109 methods t trait_name in
      let i = _v in
      let _v = _menhir_action_123 i in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_item : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState504 ->
          _menhir_run_513 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState014 ->
          _menhir_run_519 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState519 ->
          _menhir_run_519 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_513 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_GENERIC, _menhir_box_program) _menhir_cell1_separated_nonempty_list_COMMA_IDENT_ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_separated_nonempty_list_COMMA_IDENT_ (_menhir_stack, _, params) = _menhir_stack in
      let MenhirCell1_GENERIC (_menhir_stack, _menhir_s) = _menhir_stack in
      let i = _v in
      let _v = _menhir_action_128 i params in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_519 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_item (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | TRAIT ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | STRUCT ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | ROLE ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | PUB ->
          _menhir_run_391 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | IMPL ->
          _menhir_run_464 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | GLOBAL ->
          _menhir_run_491 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | GENERIC ->
          _menhir_run_498 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | FN ->
          _menhir_run_470 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | EXTERN ->
          _menhir_run_478 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | ENUM ->
          _menhir_run_505 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState519
      | EOF ->
          let _v_0 = _menhir_action_135 () in
          _menhir_run_520 _menhir_stack _v_0
      | _ ->
          _eRR ()
  
  and _menhir_run_076 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STRUCT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACE ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_0 ->
                  _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState078
              | RBRACE ->
                  let _v_1 = _menhir_action_144 () in
                  _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_079 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState080 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_083 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_STRUCT _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_STRUCT (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_230 name xs in
      _menhir_goto_struct_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_struct_decl : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let s = _v in
      let _v = _menhir_action_121 s in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_088 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | AT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | SEMICOLON ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let id = _v in
                  let _v = _menhir_action_126 id in
                  _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | LBRACE ->
                  let _menhir_stack = MenhirCell1_ROLE (_menhir_stack, _menhir_s) in
                  let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | IDENT _v_0 ->
                      _menhir_run_093 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState092
                  | RBRACE ->
                      let _v_1 = _menhir_action_146 () in
                      _menhir_run_389 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_093 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState094 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_389 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_ROLE _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
      let MenhirCell1_ROLE (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_127 id xs in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_391 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PUB (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRAIT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | LBRACE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | FN ->
                      _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState394
                  | RBRACE ->
                      let _v_0 = _menhir_action_131 () in
                      _menhir_run_395 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | STRUCT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | LBRACE ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | IDENT _v_1 ->
                      _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState399
                  | RBRACE ->
                      let _v_2 = _menhir_action_144 () in
                      _menhir_run_400 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | GLOBAL ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | COLON ->
                  let _menhir_s = MenhirState404 in
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  (match (_tok : MenhirBasics.token) with
                  | USIZE ->
                      _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | U8 ->
                      _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | U64 ->
                      _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | U32 ->
                      _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | U16 ->
                      _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | STR ->
                      _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | RESULT ->
                      _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | LBRACKET ->
                      _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | ISIZE ->
                      _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | IDENT _v ->
                      _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
                  | I8 ->
                      _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I64 ->
                      _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I32 ->
                      _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | I16 ->
                      _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | GENERIC ->
                      _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | BOOL ->
                      _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
                  | _ ->
                      _eRR ())
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | FN ->
          _menhir_run_409 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EXTERN ->
          _menhir_run_422 _menhir_stack _menhir_lexbuf _menhir_lexer
      | ENUM ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | COLON ->
                  _menhir_run_438 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState437
              | LBRACE ->
                  let _v_4 = _menhir_action_178 () in
                  _menhir_run_443 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState437 _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_395 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_PUB (_menhir_stack, _menhir_s) = _menhir_stack in
      let methods = _v in
      let _v = _menhir_action_231 methods name in
      _menhir_goto_trait_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_trait_decl : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let t = _v in
      let _v = _menhir_action_122 t in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_400 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_PUB (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_229 name xs in
      _menhir_goto_struct_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_438 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_COLON (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState438 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | USIZE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U8 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U64 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U32 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U16 ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STR ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ISIZE ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | I8 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I32 ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I16 ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | GENERIC ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_443 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option___anonymous_6_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | OK ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState444
          | IDENT _v_0 ->
              _menhir_run_445 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState444
          | ERR ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState444
          | RBRACE ->
              let _v_1 = _menhir_action_140 () in
              _menhir_run_459 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_445 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _1 = _v in
      let _v = _menhir_action_239 _1 in
      _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_459 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_option___anonymous_6_ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_option___anonymous_6_ (_menhir_stack, _, base) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_PUB (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_024 base name xs in
      _menhir_goto_enum_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_enum_decl : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let e = _v in
      let _v = _menhir_action_120 e in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_464 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IMPL (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | FOR ->
              let _menhir_s = MenhirState466 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | USIZE ->
                  _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U8 ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACKET ->
                  _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ISIZE ->
                  _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | GENERIC ->
                  _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_491 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GLOBAL (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState493 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | USIZE ->
                  _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U8 ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACKET ->
                  _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ISIZE ->
                  _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | GENERIC ->
                  _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_498 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GENERIC (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LT ->
          let _menhir_s = MenhirState499 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_500 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_500 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState501 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_500 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | GT ->
          let x = _v in
          let _v = _menhir_action_204 x in
          _menhir_goto_separated_nonempty_list_COMMA_IDENT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_IDENT_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState501 ->
          _menhir_run_502 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState499 ->
          _menhir_run_503 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_502 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_205 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_IDENT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_503 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_GENERIC as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_separated_nonempty_list_COMMA_IDENT_ (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState504 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRAIT ->
          _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRUCT ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ROLE ->
          _menhir_run_088 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | PUB ->
          _menhir_run_391 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IMPL ->
          _menhir_run_464 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | GLOBAL ->
          _menhir_run_491 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | GENERIC ->
          _menhir_run_498 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FN ->
          _menhir_run_470 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | EXTERN ->
          _menhir_run_478 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ENUM ->
          _menhir_run_505 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_505 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ENUM (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              _menhir_run_438 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState506
          | LBRACE ->
              let _v_0 = _menhir_action_178 () in
              _menhir_run_507 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState506 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_507 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_option___anonymous_6_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | OK ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState508
          | IDENT _v_0 ->
              _menhir_run_445 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState508
          | ERR ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState508
          | RBRACE ->
              let _v_1 = _menhir_action_140 () in
              _menhir_run_509 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_509 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_option___anonymous_6_ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_option___anonymous_6_ (_menhir_stack, _, base) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_ENUM (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_025 base name xs in
      _menhir_goto_enum_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_515 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let f = _v in
      let _v = _menhir_action_119 f in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_477 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_, _menhir_box_program) _menhir_cell1_option___anonymous_4_ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_option___anonymous_4_ (_menhir_stack, _, ret) = _menhir_stack in
      let MenhirCell1_option___anonymous_3_ (_menhir_stack, _, role) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _, xs) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_FN (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_107 b name ret role xs in
      _menhir_goto_fn_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_260 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GTE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState260 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_262 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState262 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_264 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_EQEQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState264 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_271 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_BITOR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState271 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_273 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_BITAND (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState273 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_266 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct as 'stack) -> _ -> _ -> ('stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_AND (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState266 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_253 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_OR as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | LTE ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | LT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | GTE ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | GT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | AND ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState253
      | BITAND | BITOR | LBRACE | OR ->
          let MenhirCell1_OR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_076 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_255 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_NEQ as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState255
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR ->
          let MenhirCell1_NEQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_078 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_257 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_LTE as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState257
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR ->
          let MenhirCell1_LTE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_081 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_259 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_LT as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState259
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR ->
          let MenhirCell1_LT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_079 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_261 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_GTE as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState261
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR ->
          let MenhirCell1_GTE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_082 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_263 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_GT as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState263
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR ->
          let MenhirCell1_GT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_080 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_265 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_EQEQ as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState265
      | AND | BITAND | BITOR | EQEQ | GT | GTE | LBRACE | LT | LTE | NEQ | OR ->
          let MenhirCell1_EQEQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_077 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_267 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_AND as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | LTE ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | LT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | GTE ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | GT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState267
      | AND | BITAND | BITOR | LBRACE | OR ->
          let MenhirCell1_AND (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_075 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_270 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_WHILE as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | SLASH ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | SHR ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | SHL ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | PLUS ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | OR ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | NEQ ->
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | MINUS ->
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | LTE ->
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | LT ->
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | LBRACKET ->
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | LBRACE ->
          _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | GTE ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | GT ->
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | EQEQ ->
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | DOT ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | BITOR ->
          _menhir_run_271 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | BITAND ->
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | AS ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | AND ->
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState270
      | _ ->
          _eRR ()
  
  and _menhir_run_272 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_BITOR as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | OR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | LTE ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | LT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | GTE ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | GT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | AND ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState272
      | BITOR | LBRACE ->
          let MenhirCell1_BITOR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_074 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_274 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_BITAND as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | SHR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | SHL ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | OR ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | LTE ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | LT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | GTE ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | GT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | DOT ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | AS ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | AND ->
          let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState274
      | BITAND | BITOR | LBRACE ->
          let MenhirCell1_BITAND (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_073 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_300 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_FOR _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | SLASH ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | SHR ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | SHL ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | PLUS ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | OR ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | NEQ ->
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | MINUS ->
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | LTE ->
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | LT ->
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | LBRACKET ->
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | LBRACE ->
          _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | GTE ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | GT ->
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | EQEQ ->
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | DOT ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | BITOR ->
          _menhir_run_271 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | BITAND ->
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | AS ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | AND ->
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState300
      | _ ->
          _eRR ()
  
  and _menhir_run_322 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_MATCH as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | SLASH ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | SHR ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | SHL ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | PLUS ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | OR ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | NEQ ->
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | MINUS ->
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | LTE ->
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | LT ->
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | LBRACKET ->
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | LBRACE ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, MenhirState322) in
          let _menhir_s = MenhirState323 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UNDERSCORE ->
              _menhir_run_324 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_325 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_326 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_330 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | GTE ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | GT ->
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | EQEQ ->
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | DOT ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | BITOR ->
          _menhir_run_271 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | BITAND ->
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | AS ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | AND ->
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState322
      | _ ->
          _eRR ()
  
  and _menhir_run_324 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_195 () in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_pattern : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState329 ->
          _menhir_run_334 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState332 ->
          _menhir_run_334 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState335 ->
          _menhir_run_334 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState323 ->
          _menhir_run_342 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState348 ->
          _menhir_run_342 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState360 ->
          _menhir_run_342 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState377 ->
          _menhir_run_342 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_334 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_pattern (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState335 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UNDERSCORE ->
              _menhir_run_324 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_325 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_326 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_330 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let x = _v in
          let _v = _menhir_action_216 x in
          _menhir_goto_separated_nonempty_list_COMMA_pattern_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_325 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA | FATARROW | RPAREN ->
          let _v = _menhir_action_200 () in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let _v = _menhir_action_240 () in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_326 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLONCOLON ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState327 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | OK ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | COMMA | FATARROW | RPAREN ->
          let _1 = _v in
          let _v = _menhir_action_197 _1 in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let _1 = _v in
          let _v = _menhir_action_239 _1 in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_330 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA | FATARROW | RPAREN ->
          let _v = _menhir_action_201 () in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let _v = _menhir_action_241 () in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_pattern_ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState329 ->
          _menhir_run_333 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState332 ->
          _menhir_run_333 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState335 ->
          _menhir_run_336 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_333 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_151 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_pattern__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_pattern__ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState332 ->
          _menhir_run_338 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState329 ->
          _menhir_run_340 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_338 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_variant_ident -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_variant_ident (_menhir_stack, _menhir_s, v) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_202 v xs in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_340 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_IDENT, ttv_result) _menhir_cell1_module_path -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_module_path (_menhir_stack, _, rest) = _menhir_stack in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id1) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_199 id1 rest xs in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_336 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_pattern -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_pattern (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_217 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_pattern_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_342 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_pattern (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | FATARROW ->
          let _menhir_s = MenhirState343 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_351 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | SLASH ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | SHR ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | SHL ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | PLUS ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | OR ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | NEQ ->
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | MINUS ->
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | LTE ->
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | LT ->
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | LBRACKET ->
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | LBRACE ->
          _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | GTE ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | GT ->
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | EQEQ ->
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | DOT ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | BITOR ->
          _menhir_run_271 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | BITAND ->
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | AS ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | AND ->
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState351
      | _ ->
          _eRR ()
  
  and _menhir_run_359 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_MATCH as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | SLASH ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | SHR ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | SHL ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | PLUS ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | OR ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | NEQ ->
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | MINUS ->
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | LTE ->
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | LT ->
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | LBRACKET ->
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | LBRACE ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, MenhirState359) in
          let _menhir_s = MenhirState360 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UNDERSCORE ->
              _menhir_run_324 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_325 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_326 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_330 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | GTE ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | GT ->
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | EQEQ ->
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | DOT ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | BITOR ->
          _menhir_run_271 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | BITAND ->
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | AS ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | AND ->
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState359
      | _ ->
          _eRR ()
  
  and _menhir_run_363 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_MINUS -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_066 e in
      _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_364 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_NOT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NOT (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_065 e in
      _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_365 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | SLASH ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | SHR ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | SHL ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | PLUS ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | OR ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | NEQ ->
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | MINUS ->
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | LTE ->
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | LT ->
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | LBRACKET ->
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | LBRACE ->
          _menhir_run_268 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | GTE ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | GT ->
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | EQEQ ->
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | DOT ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | BITOR ->
          _menhir_run_271 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | BITAND ->
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | AS ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | AND ->
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState365
      | _ ->
          _eRR ()
  
  and _menhir_run_376 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_MATCH as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_228 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | SLASH ->
          _menhir_run_241 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | SHR ->
          _menhir_run_243 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | SHL ->
          _menhir_run_249 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | PLUS ->
          _menhir_run_245 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | OR ->
          _menhir_run_252 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | NEQ ->
          _menhir_run_254 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | MINUS ->
          _menhir_run_247 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | LTE ->
          _menhir_run_256 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | LT ->
          _menhir_run_258 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | LBRACKET ->
          _menhir_run_230 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | LBRACE ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, MenhirState376) in
          let _menhir_s = MenhirState377 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UNDERSCORE ->
              _menhir_run_324 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_325 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IDENT _v ->
              _menhir_run_326 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_330 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | GTE ->
          _menhir_run_260 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | GT ->
          _menhir_run_262 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | EQEQ ->
          _menhir_run_264 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | DOT ->
          _menhir_run_233 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | BITOR ->
          _menhir_run_271 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | BITAND ->
          _menhir_run_273 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | AS ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | AND ->
          _menhir_run_266 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState376
      | _ ->
          _eRR ()
  
  and _menhir_run_368 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_LBRACKET -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_057 xs in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_144 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState144 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_153 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState153 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_159 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState159 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_155 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState155 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_162 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState162 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_164 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState164 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_157 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState157 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_166 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState166 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_168 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState168 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_142 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState142 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_170 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState170 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_172 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState172 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_174 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState174 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_146 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | TRANSFER ->
                  _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | STRING_VAL _v_0 ->
                  _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState148
              | OK ->
                  _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | NOT ->
                  _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | MINUS ->
                  _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | MATCH ->
                  _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | LPAREN ->
                  _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | LBRACKET ->
                  _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | IOTA ->
                  _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | INT _v_1 ->
                  _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState148
              | IF ->
                  _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | IDENT _v_2 ->
                  _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState148
              | GENERIC ->
                  _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | FSTRING_VAL _v_3 ->
                  _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState148
              | ERR ->
                  _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState148
              | BOOL_VAL _v_4 ->
                  _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState148
              | RPAREN ->
                  let _v_5 = _menhir_action_142 () in
                  _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 _tok
              | _ ->
                  _eRR ())
          | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
              let MenhirCell1_expr (_menhir_stack, _menhir_s, e) = _menhir_stack in
              let f = _v in
              let _v = _menhir_action_054 e f in
              _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_149 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_053 e1 id xs in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_178 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState178 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_180 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState180 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_151 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState151 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | USIZE ->
          _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U8 ->
          _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U64 ->
          _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U32 ->
          _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | U16 ->
          _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STR ->
          _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | RESULT ->
          _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | ISIZE ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | I8 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I64 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I32 ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | I16 ->
          _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | GENERIC ->
          _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL ->
          _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_176 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState176 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_expr_ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState106 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState123 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState133 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState148 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState204 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState210 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState223 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState235 ->
          _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState182 ->
          _menhir_run_183 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_134 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let x = _v in
      let _v = _menhir_action_143 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_expr__ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState133 ->
          _menhir_run_135 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState148 ->
          _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState123 ->
          _menhir_run_194 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState204 ->
          _menhir_run_205 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState210 ->
          _menhir_run_211 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState223 ->
          _menhir_run_224 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState235 ->
          _menhir_run_236 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState106 ->
          _menhir_run_368 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_135 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_module_path -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_module_path (_menhir_stack, _menhir_s, path) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_056 path xs in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_224 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_module_path -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_module_path (_menhir_stack, _menhir_s, path) = _menhir_stack in
          let xs = _v in
          let _v = _menhir_action_092 path xs in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_183 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_209 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_141 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_033 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_143 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_059 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_145 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_034 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_154 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_036 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_156 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_031 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_158 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_032 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_160 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_035 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_163 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | ERR | IDENT _ | INT _ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_040 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_165 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_042 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_167 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_045 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_169 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_043 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_171 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_046 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_173 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_044 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_175 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_041 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_177 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | ERR | IDENT _ | INT _ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_039 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_179 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | ERR | IDENT _ | INT _ | OK | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_038 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_181 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | ERR | IDENT _ | INT _ | OK | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_037 e1 e2 in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_191 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_ERR as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_ERR (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_049 e in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_193 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_GENERIC, ttv_result) _menhir_cell1_separated_nonempty_list_COMMA_typ_ as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND | BITAND | BITOR | BOOL_VAL _ | COMMA | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LT | LTE | NEQ | OK | OR | RBRACE | RBRACKET | RPAREN | SEMICOLON | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_separated_nonempty_list_COMMA_typ_ (_menhir_stack, _, args) = _menhir_stack in
          let MenhirCell1_GENERIC (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_060 args e in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_196 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_OK as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_OK (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_084 e in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_202 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_100 e in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_220 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_ERR as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_ERR (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_085 e in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_231 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_LBRACKET as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LBRACKET (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_095 e1 e2 in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_282 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_VAR _menhir_cell0_IDENT _menhir_cell0_option___anonymous_9_ as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_option___anonymous_9_ (_menhir_stack, typ) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_VAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let init = _v in
          let _v = _menhir_action_222 init name typ in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_287 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_RETURN as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let x = _v in
          let _v = _menhir_action_187 x in
          _menhir_goto_option_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_295 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_LET _menhir_cell0_IDENT _menhir_cell0_option___anonymous_8_ as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_option___anonymous_8_ (_menhir_stack, typ) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_LET (_menhir_stack, _menhir_s) = _menhir_stack in
          let init = _v in
          let _v = _menhir_action_221 init name typ in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_308 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_CONST _menhir_cell0_IDENT _menhir_cell0_option___anonymous_10_ as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_option___anonymous_10_ (_menhir_stack, typ) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_CONST (_menhir_stack, _menhir_s) = _menhir_stack in
          let init = _v in
          let _v = _menhir_action_223 init name typ in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_311 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_226 e in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState313 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RBRACE ->
          let e = _v in
          let _v = _menhir_action_018 e in
          _menhir_goto_block_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_314 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, lhs) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_224 e lhs in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_344 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_pattern as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_pattern (_menhir_stack, _menhir_s, p) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_154 e p in
          _menhir_goto_match_arm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BOOL_VAL _ | ERR | IDENT _ | INT _ | OK | RBRACE | STRING_VAL _ | UNDERSCORE ->
          let MenhirCell1_pattern (_menhir_stack, _menhir_s, p) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_155 e p in
          _menhir_goto_match_arm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_match_arm : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UNDERSCORE ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_324 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState348
      | STRING_VAL _v_0 ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState348
      | OK ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_325 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState348
      | INT _v_1 ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState348
      | IDENT _v_2 ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_326 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState348
      | ERR ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_330 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState348
      | BOOL_VAL _v_3 ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState348
      | RBRACE ->
          let x = _v in
          let _v = _menhir_action_158 x in
          _menhir_goto_nonempty_list_match_arm_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_nonempty_list_match_arm_ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState323 ->
          _menhir_run_346 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState348 ->
          _menhir_run_349 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState360 ->
          _menhir_run_361 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState377 ->
          _menhir_run_378 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_346 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_MATCH, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_LBRACE -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr_no_struct (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell1_MATCH (_menhir_stack, _menhir_s) = _menhir_stack in
      let arms = _v in
      let _v = _menhir_action_023 arms e in
      _menhir_goto_else_branch _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_349 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_match_arm -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_match_arm (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_159 x xs in
      _menhir_goto_nonempty_list_match_arm_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_361 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_MATCH, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_LBRACE -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr_no_struct (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell1_MATCH (_menhir_stack, _menhir_s) = _menhir_stack in
      let arms = _v in
      let _v = _menhir_action_091 arms e in
      _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_378 : type  ttv_stack ttv_result. (((ttv_stack, ttv_result) _menhir_cell1_MATCH, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_LBRACE -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr_no_struct (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell1_MATCH (_menhir_stack, _menhir_s) = _menhir_stack in
      let arms = _v in
      let _v = _menhir_action_055 arms e in
      _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_370 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_064 e in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_372 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_TRANSFER as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | RPAREN ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let MenhirCell1_TRANSFER (_menhir_stack, _menhir_s) = _menhir_stack in
                  let (e, r) = (_v, _v_0) in
                  let _v = _menhir_action_094 e r in
                  _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_380 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_MINUS -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_030 e in
      _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_381 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_NOT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_NOT (_menhir_stack, _menhir_s) = _menhir_stack in
      let e = _v in
      let _v = _menhir_action_029 e in
      _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_382 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_OK as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_OK (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_048 e in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_384 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_TRANSFER as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | RPAREN ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let MenhirCell1_TRANSFER (_menhir_stack, _menhir_s) = _menhir_stack in
                  let (e, r) = (_v, _v_0) in
                  let _v = _menhir_action_058 e r in
                  _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_388 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | RBRACE ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_103 e name in
          (match (_tok : MenhirBasics.token) with
          | COMMA ->
              let _menhir_stack = MenhirCell1_field_init (_menhir_stack, _menhir_s, _v) in
              let _menhir_s = MenhirState189 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_093 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | RBRACE ->
              let x = _v in
              let _v = _menhir_action_212 x in
              _menhir_goto_separated_nonempty_list_COMMA_field_init_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _menhir_fail ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_field_init_ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState092 ->
          _menhir_run_185 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState184 ->
          _menhir_run_185 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState189 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_185 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_147 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_field_init__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_field_init__ : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState184 ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState092 ->
          _menhir_run_389 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_186 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_module_path -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_module_path (_menhir_stack, _menhir_s, path) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_028 path xs in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_190 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_field_init -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_field_init (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_213 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_field_init_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_407 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_typ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_typ (_menhir_stack, _, t) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_PUB (_menhir_stack, _menhir_s) = _menhir_stack in
          let init = _v in
          let _v = _menhir_action_124 init name t in
          _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_441 : type  ttv_stack. (((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_COLON, _menhir_box_program) _menhir_cell1_base_type as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_base_type (_menhir_stack, _, t) = _menhir_stack in
          let MenhirCell1_COLON (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_179 e t in
          _menhir_goto_option___anonymous_6_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_6_ : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState437 ->
          _menhir_run_443 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState506 ->
          _menhir_run_507 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_453 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident _menhir_cell0_option___anonymous_7_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | RBRACE ->
          let e = _v in
          let _v = _menhir_action_193 e in
          _menhir_goto_override _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_override : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident _menhir_cell0_option___anonymous_7_ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_191 x in
      _menhir_goto_option_override_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_option_override_ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident _menhir_cell0_option___anonymous_7_ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_option___anonymous_7_ (_menhir_stack, payload) = _menhir_stack in
      let MenhirCell1_variant_ident (_menhir_stack, _menhir_s, name) = _menhir_stack in
      let override = _v in
      let _v = _menhir_action_026 name override payload in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_enum_member (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState462 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | OK ->
              _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_445 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RBRACE ->
          let x = _v in
          let _v = _menhir_action_206 x in
          _menhir_goto_separated_nonempty_list_COMMA_enum_member_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_enum_member_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState444 ->
          _menhir_run_458 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState508 ->
          _menhir_run_458 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState462 ->
          _menhir_run_463 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_458 : type  ttv_stack. ((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_option___anonymous_6_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_141 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_enum_member__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_enum_member__ : type  ttv_stack. ((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_option___anonymous_6_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState444 ->
          _menhir_run_459 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState508 ->
          _menhir_run_509 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_463 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_enum_member -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_enum_member (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_207 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_enum_member_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_455 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident _menhir_cell0_option___anonymous_7_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | RBRACE ->
          let e = _v in
          let _v = _menhir_action_192 e in
          _menhir_goto_override _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_496 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_GLOBAL _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_typ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_typ (_menhir_stack, _, t) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_GLOBAL (_menhir_stack, _menhir_s) = _menhir_stack in
          let init = _v in
          let _v = _menhir_action_125 init name t in
          _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_525 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_standalone_expr) _menhir_state -> _ -> _menhir_box_standalone_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_140 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_144 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_155 _menhir_stack _menhir_lexbuf _menhir_lexer
      | OR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_162 _menhir_stack _menhir_lexbuf _menhir_lexer
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_164 _menhir_stack _menhir_lexbuf _menhir_lexer
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_157 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_168 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LBRACKET ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_142 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_172 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EOF ->
          let e = _v in
          let _v = _menhir_action_220 e in
          MenhirBox_standalone_expr _v
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_146 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_178 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_151 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_176 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_226 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let l = _v in
      let _v = _menhir_action_097 l in
      _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_337 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let l = _v in
      let _v = _menhir_action_196 l in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_215 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_GENERIC as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_separated_nonempty_list_COMMA_typ_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | GT ->
          let _menhir_s = MenhirState216 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_198 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_199 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_201 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_204 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_207 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_213 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_218 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_448 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let x = _v in
      let _v = _menhir_action_153 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_typ__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_typ__ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let xs = _v in
          let _v = _menhir_action_181 xs in
          _menhir_goto_option___anonymous_7_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_7_ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option___anonymous_7_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | DOLLAR_EQ ->
          let _menhir_s = MenhirState452 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | AT_EQ ->
          let _menhir_s = MenhirState454 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | COMMA | RBRACE ->
          let _v = _menhir_action_190 () in
          _menhir_goto_option_override_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_050 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_LBRACKET -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | RBRACKET ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | AT ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) = _menhir_stack in
                  let (t, role) = (_v, _v_0) in
                  let _v = _menhir_action_238 role t in
                  _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
              let MenhirCell1_LBRACKET (_menhir_stack, _menhir_s) = _menhir_stack in
              let t = _v in
              let _v = _menhir_action_237 t in
              _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_054 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_RESULT as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_s = MenhirState055 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_056 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_RESULT, ttv_result) _menhir_cell1_typ -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | GT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | AT ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v_0 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let MenhirCell1_typ (_menhir_stack, _, t1) = _menhir_stack in
                  let MenhirCell1_RESULT (_menhir_stack, _menhir_s) = _menhir_stack in
                  let (role, t2) = (_v_0, _v) in
                  let _v = _menhir_action_236 role t1 t2 in
                  _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
              | _ ->
                  _eRR ())
          | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
              let MenhirCell1_typ (_menhir_stack, _, t1) = _menhir_stack in
              let MenhirCell1_RESULT (_menhir_stack, _menhir_s) = _menhir_stack in
              let t2 = _v in
              let _v = _menhir_action_235 t1 t2 in
              _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_060 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
      let typ = _v in
      let _v = _menhir_action_194 name typ in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_param (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState063 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let x = _v in
          let _v = _menhir_action_214 x in
          _menhir_goto_separated_nonempty_list_COMMA_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_param_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState020 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState411 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState425 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState472 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState481 ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState063 ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_061 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_149 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_param__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_param__ : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState020 ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState411 ->
          _menhir_run_412 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState425 ->
          _menhir_run_426 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState472 ->
          _menhir_run_473 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState481 ->
          _menhir_run_482 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_065 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | GT ->
              let _menhir_s = MenhirState068 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | USIZE ->
                  _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U8 ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LBRACKET ->
                  _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | ISIZE ->
                  _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | GENERIC ->
                  _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | SEMICOLON ->
          let _v = _menhir_action_176 () in
          _menhir_goto_option___anonymous_5_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_5_ : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _, xs) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_FN (_menhir_stack, _menhir_s) = _menhir_stack in
          let ret = _v in
          let _v = _menhir_action_108 name ret xs in
          let _menhir_stack = MenhirCell1_fn_sig (_menhir_stack, _menhir_s, _v) in
          (match (_tok : MenhirBasics.token) with
          | FN ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState074
          | RBRACE ->
              let _v_0 = _menhir_action_131 () in
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_075 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_fn_sig -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_fn_sig (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_132 x xs in
      _menhir_goto_list_fn_sig_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_fn_sig_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState017 ->
          _menhir_run_072 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState074 ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState394 ->
          _menhir_run_395 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_072 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_TRAIT _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_TRAIT (_menhir_stack, _menhir_s) = _menhir_stack in
      let methods = _v in
      let _v = _menhir_action_232 methods name in
      _menhir_goto_trait_decl _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_064 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_param -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_param (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_215 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_069 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let t = _v in
      let _v = _menhir_action_177 t in
      _menhir_goto_option___anonymous_5_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_081 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
      let typ = _v in
      let _v = _menhir_action_102 name typ in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_field (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState086 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_079 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RBRACE ->
          let x = _v in
          let _v = _menhir_action_210 x in
          _menhir_goto_separated_nonempty_list_COMMA_field_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_field_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState078 ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState399 ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState086 ->
          _menhir_run_087 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_082 : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_145 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_field__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_field__ : type  ttv_stack. (ttv_stack _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState078 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState399 ->
          _menhir_run_400 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_087 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_field -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_field (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_211 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_field_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_152 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _menhir_s, e) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_047 e t in
      _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_239 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_expr_no_struct, ttv_result) _menhir_cell1_AS -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_AS (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr_no_struct (_menhir_stack, _menhir_s, e) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_083 e t in
      _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_279 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_VAR _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let t = _v in
      let _v = _menhir_action_185 t in
      _menhir_goto_option___anonymous_9_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_292 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_LET _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let t = _v in
      let _v = _menhir_action_183 t in
      _menhir_goto_option___anonymous_8_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_305 : type  ttv_stack ttv_result. (ttv_stack, ttv_result) _menhir_cell1_CONST _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let t = _v in
      let _v = _menhir_action_165 t in
      _menhir_goto_option___anonymous_10_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_405 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_PUB _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState406 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_419 : type  ttv_stack. (((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_, _menhir_box_program) _menhir_cell1_MINUS -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_175 t in
      _menhir_goto_option___anonymous_4_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_option___anonymous_4_ : type  ttv_stack. (((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_3_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState416 ->
          _menhir_run_420 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState475 ->
          _menhir_run_476 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_433 : type  ttv_stack. (((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_1_, _menhir_box_program) _menhir_cell1_MINUS -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_MINUS (_menhir_stack, _menhir_s) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_171 t in
      _menhir_goto_option___anonymous_2_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_option___anonymous_2_ : type  ttv_stack. (((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_cell1_option___anonymous_1_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState430 ->
          _menhir_run_434 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState484 ->
          _menhir_run_485 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_467 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IMPL _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | PUB ->
              _menhir_run_469 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState468
          | FN ->
              _menhir_run_470 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState468
          | EXTERN ->
              _menhir_run_478 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState468
          | RBRACE ->
              let _v_0 = _menhir_action_129 () in
              _menhir_run_487 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_494 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_GLOBAL _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState495 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_049 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_GENERIC, ttv_result) _menhir_cell1_separated_nonempty_list_COMMA_typ_ -> _ -> _ -> _ -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_separated_nonempty_list_COMMA_typ_ (_menhir_stack, _, args) = _menhir_stack in
      let MenhirCell1_GENERIC (_menhir_stack, _menhir_s) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_015 args t in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_439 : type  ttv_stack. ((ttv_stack _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_COLON as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_base_type (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState440 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STRING_VAL _v ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | FSTRING_VAL _v ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_132 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_module_path (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | STRING_VAL _v_0 ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState133
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | INT _v_1 ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState133
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | IDENT _v_2 ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState133
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | FSTRING_VAL _v_3 ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState133
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState133
          | BOOL_VAL _v_4 ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState133
          | RPAREN ->
              let _v_5 = _menhir_action_142 () in
              _menhir_run_135 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 _tok
          | _ ->
              _eRR ())
      | LBRACE ->
          let _menhir_stack = MenhirCell1_module_path (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_6 ->
              _menhir_run_093 _menhir_stack _menhir_lexbuf _menhir_lexer _v_6 MenhirState184
          | RBRACE ->
              let _v_7 = _menhir_action_146 () in
              _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer _v_7
          | _ ->
              _eRR ())
      | AND | AS | BITAND | BITOR | BOOL_VAL _ | COMMA | DOT | EOF | EQ | EQEQ | ERR | GT | GTE | IDENT _ | INT _ | LBRACKET | LT | LTE | MINUS | NEQ | OK | OR | PLUS | RBRACE | RBRACKET | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | STRING_VAL _ | UNDERSCORE ->
          let path = _v in
          let _v = _menhir_action_063 path in
          _menhir_goto_expr_base_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_222 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_module_path (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | TRANSFER ->
              _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | STRING_VAL _v_0 ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState223
          | OK ->
              _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | NOT ->
              _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | MINUS ->
              _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | MATCH ->
              _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | LPAREN ->
              _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | LBRACKET ->
              _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | IOTA ->
              _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | INT _v_1 ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState223
          | IF ->
              _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | IDENT _v_2 ->
              _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState223
          | GENERIC ->
              _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | FSTRING_VAL _v_3 ->
              _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState223
          | ERR ->
              _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState223
          | BOOL_VAL _v_4 ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4 MenhirState223
          | RPAREN ->
              let _v_5 = _menhir_action_142 () in
              _menhir_run_224 _menhir_stack _menhir_lexbuf _menhir_lexer _v_5 _tok
          | _ ->
              _eRR ())
      | AND | AS | BITAND | BITOR | DOT | EQEQ | GT | GTE | LBRACE | LBRACKET | LT | LTE | MINUS | NEQ | OR | PLUS | SHL | SHR | SLASH | STAR ->
          let path = _v in
          let _v = _menhir_action_099 path in
          _menhir_goto_expr_base_expr_no_struct_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_328 : type  ttv_stack ttv_result. ((ttv_stack, ttv_result) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_stack = MenhirCell1_module_path (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UNDERSCORE ->
              _menhir_run_324 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState329
          | STRING_VAL _v_0 ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState329
          | OK ->
              _menhir_run_325 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState329
          | INT _v_1 ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState329
          | IDENT _v_2 ->
              _menhir_run_326 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState329
          | ERR ->
              _menhir_run_330 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState329
          | BOOL_VAL _v_3 ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState329
          | RPAREN ->
              let _v_4 = _menhir_action_150 () in
              _menhir_run_340 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4
          | _ ->
              _eRR ())
      | COMMA | FATARROW | RPAREN ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id1) = _menhir_stack in
          let rest = _v in
          let _v = _menhir_action_198 id1 rest in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_331 : type  ttv_stack ttv_result. ttv_stack -> _ -> _ -> _ -> (ttv_stack, ttv_result) _menhir_state -> _ -> ttv_result =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_variant_ident (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UNDERSCORE ->
              _menhir_run_324 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState332
          | STRING_VAL _v_0 ->
              _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState332
          | OK ->
              _menhir_run_325 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState332
          | INT _v_1 ->
              _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState332
          | IDENT _v_2 ->
              _menhir_run_326 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState332
          | ERR ->
              _menhir_run_330 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState332
          | BOOL_VAL _v_3 ->
              _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState332
          | RPAREN ->
              let _v_4 = _menhir_action_150 () in
              _menhir_run_338 _menhir_stack _menhir_lexbuf _menhir_lexer _v_4
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_446 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_variant_ident (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState447 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | USIZE ->
              _menhir_run_023 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U8 ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LBRACKET ->
              _menhir_run_031 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | ISIZE ->
              _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_033 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_037 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | GENERIC ->
              _menhir_run_038 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_040 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RPAREN ->
              let _v = _menhir_action_152 () in
              _menhir_goto_loption_separated_nonempty_list_COMMA_typ__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | AT_EQ | COMMA | DOLLAR_EQ | RBRACE ->
          let _v = _menhir_action_180 () in
          _menhir_goto_option___anonymous_7_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IMPORT ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | ENUM | EOF | EXTERN | FN | GENERIC | GLOBAL | IMPL | PUB | ROLE | STRUCT | TRAIT ->
          let _v = _menhir_action_133 () in
          _menhir_run_014 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState000 _tok
      | _ ->
          _eRR ()
  
  let _menhir_run_523 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_standalone_expr =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState523 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | TRANSFER ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | STRING_VAL _v ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | NOT ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MINUS ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LBRACKET ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IOTA ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | GENERIC ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | FSTRING_VAL _v ->
          _menhir_run_128 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_129 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
end

let standalone_expr =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_standalone_expr v = _menhir_run_523 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
