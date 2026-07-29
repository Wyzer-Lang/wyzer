
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WHILE
    | VAR
    | UNDERSCORE
    | U8
    | U64
    | U32
    | U16
    | STRUCT
    | STRING_VAL of 
# 7 "lib/parser.mly"
       (string)
# 23 "lib/parser.ml"
  
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
    | INT of 
# 5 "lib/parser.mly"
       (int64)
# 47 "lib/parser.ml"
  
    | IN
    | IMPORT
    | IF
    | IDENT of 
# 8 "lib/parser.mly"
       (string)
# 55 "lib/parser.ml"
  
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
    | BOOL_VAL of 
# 6 "lib/parser.mly"
       (bool)
# 80 "lib/parser.ml"
  
    | BOOL
    | BITOR
    | BITAND
    | AT
    | AS
  
end

include MenhirBasics

# 1 "lib/parser.mly"
  
open Ast

# 96 "lib/parser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState000 : ('s, _menhir_box_program) _menhir_state
    (** State 000.
        Stack shape : <empty>.
        Start symbol: program. *)

  | MenhirState001 : (('s, _menhir_box_program) _menhir_cell1_IMPORT, _menhir_box_program) _menhir_state
    (** State 001.
        Stack shape : IMPORT.
        Start symbol: program. *)

  | MenhirState003 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 003.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState011 : (('s, _menhir_box_program) _menhir_cell1_list_import_decl_, _menhir_box_program) _menhir_state
    (** State 011.
        Stack shape : list(import_decl).
        Start symbol: program. *)

  | MenhirState014 : (('s, _menhir_box_program) _menhir_cell1_STRUCT _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 014.
        Stack shape : STRUCT IDENT.
        Start symbol: program. *)

  | MenhirState016 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 016.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState023 : (('s, _menhir_box_program) _menhir_cell1_RESULT, _menhir_box_program) _menhir_state
    (** State 023.
        Stack shape : RESULT.
        Start symbol: program. *)

  | MenhirState031 : ((('s, _menhir_box_program) _menhir_cell1_RESULT, _menhir_box_program) _menhir_cell1_typ, _menhir_box_program) _menhir_state
    (** State 031.
        Stack shape : RESULT typ.
        Start symbol: program. *)

  | MenhirState040 : (('s, _menhir_box_program) _menhir_cell1_field, _menhir_box_program) _menhir_state
    (** State 040.
        Stack shape : field.
        Start symbol: program. *)

  | MenhirState044 : (('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 044.
        Stack shape : FN IDENT.
        Start symbol: program. *)

  | MenhirState046 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 046.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState050 : (('s, _menhir_box_program) _menhir_cell1_param, _menhir_box_program) _menhir_state
    (** State 050.
        Stack shape : param.
        Start symbol: program. *)

  | MenhirState055 : ((('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__, _menhir_box_program) _menhir_state
    (** State 055.
        Stack shape : FN IDENT loption(separated_nonempty_list(COMMA,param)).
        Start symbol: program. *)

  | MenhirState057 : ((('s, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ _menhir_cell0_option___anonymous_1_, _menhir_box_program) _menhir_state
    (** State 057.
        Stack shape : FN IDENT loption(separated_nonempty_list(COMMA,param)) option(__anonymous_1).
        Start symbol: program. *)

  | MenhirState058 : (('s, _menhir_box_program) _menhir_cell1_LBRACE, _menhir_box_program) _menhir_state
    (** State 058.
        Stack shape : LBRACE.
        Start symbol: program. *)

  | MenhirState059 : (('s, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_state
    (** State 059.
        Stack shape : WHILE.
        Start symbol: program. *)

  | MenhirState062 : (('s, _menhir_box_program) _menhir_cell1_OK, _menhir_box_program) _menhir_state
    (** State 062.
        Stack shape : OK.
        Start symbol: program. *)

  | MenhirState063 : (('s, _menhir_box_program) _menhir_cell1_MATCH, _menhir_box_program) _menhir_state
    (** State 063.
        Stack shape : MATCH.
        Start symbol: program. *)

  | MenhirState064 : (('s, _menhir_box_program) _menhir_cell1_LPAREN, _menhir_box_program) _menhir_state
    (** State 064.
        Stack shape : LPAREN.
        Start symbol: program. *)

  | MenhirState075 : (('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_state
    (** State 075.
        Stack shape : IF.
        Start symbol: program. *)

  | MenhirState077 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 077.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState079 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 079.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState081 : (('s, _menhir_box_program) _menhir_cell1_ERR, _menhir_box_program) _menhir_state
    (** State 081.
        Stack shape : ERR.
        Start symbol: program. *)

  | MenhirState084 : (('s, _menhir_box_program) _menhir_cell1_module_path, _menhir_box_program) _menhir_state
    (** State 084.
        Stack shape : module_path.
        Start symbol: program. *)

  | MenhirState089 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 089.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState090 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_STAR, _menhir_box_program) _menhir_state
    (** State 090.
        Stack shape : expr STAR.
        Start symbol: program. *)

  | MenhirState091 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_STAR, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 091.
        Stack shape : expr STAR expr.
        Start symbol: program. *)

  | MenhirState094 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SLASH, _menhir_box_program) _menhir_state
    (** State 094.
        Stack shape : expr SLASH.
        Start symbol: program. *)

  | MenhirState095 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SLASH, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 095.
        Stack shape : expr SLASH expr.
        Start symbol: program. *)

  | MenhirState096 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SHR, _menhir_box_program) _menhir_state
    (** State 096.
        Stack shape : expr SHR.
        Start symbol: program. *)

  | MenhirState097 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SHR, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 097.
        Stack shape : expr SHR expr.
        Start symbol: program. *)

  | MenhirState098 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_PLUS, _menhir_box_program) _menhir_state
    (** State 098.
        Stack shape : expr PLUS.
        Start symbol: program. *)

  | MenhirState099 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_PLUS, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 099.
        Stack shape : expr PLUS expr.
        Start symbol: program. *)

  | MenhirState100 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_MINUS, _menhir_box_program) _menhir_state
    (** State 100.
        Stack shape : expr MINUS.
        Start symbol: program. *)

  | MenhirState101 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_MINUS, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 101.
        Stack shape : expr MINUS expr.
        Start symbol: program. *)

  | MenhirState102 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SHL, _menhir_box_program) _menhir_state
    (** State 102.
        Stack shape : expr SHL.
        Start symbol: program. *)

  | MenhirState103 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SHL, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 103.
        Stack shape : expr SHL expr.
        Start symbol: program. *)

  | MenhirState104 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_NEQ, _menhir_box_program) _menhir_state
    (** State 104.
        Stack shape : expr NEQ.
        Start symbol: program. *)

  | MenhirState105 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_NEQ, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 105.
        Stack shape : expr NEQ expr.
        Start symbol: program. *)

  | MenhirState106 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_LTE, _menhir_box_program) _menhir_state
    (** State 106.
        Stack shape : expr LTE.
        Start symbol: program. *)

  | MenhirState107 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_LTE, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 107.
        Stack shape : expr LTE expr.
        Start symbol: program. *)

  | MenhirState108 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_LT, _menhir_box_program) _menhir_state
    (** State 108.
        Stack shape : expr LT.
        Start symbol: program. *)

  | MenhirState109 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_LT, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 109.
        Stack shape : expr LT expr.
        Start symbol: program. *)

  | MenhirState110 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_GTE, _menhir_box_program) _menhir_state
    (** State 110.
        Stack shape : expr GTE.
        Start symbol: program. *)

  | MenhirState111 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_GTE, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 111.
        Stack shape : expr GTE expr.
        Start symbol: program. *)

  | MenhirState112 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_GT, _menhir_box_program) _menhir_state
    (** State 112.
        Stack shape : expr GT.
        Start symbol: program. *)

  | MenhirState113 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_GT, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 113.
        Stack shape : expr GT expr.
        Start symbol: program. *)

  | MenhirState114 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_EQEQ, _menhir_box_program) _menhir_state
    (** State 114.
        Stack shape : expr EQEQ.
        Start symbol: program. *)

  | MenhirState115 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_EQEQ, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 115.
        Stack shape : expr EQEQ expr.
        Start symbol: program. *)

  | MenhirState116 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_COMMA, _menhir_box_program) _menhir_state
    (** State 116.
        Stack shape : expr COMMA.
        Start symbol: program. *)

  | MenhirState118 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_BITOR, _menhir_box_program) _menhir_state
    (** State 118.
        Stack shape : expr BITOR.
        Start symbol: program. *)

  | MenhirState119 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_BITOR, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 119.
        Stack shape : expr BITOR expr.
        Start symbol: program. *)

  | MenhirState120 : ((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_BITAND, _menhir_box_program) _menhir_state
    (** State 120.
        Stack shape : expr BITAND.
        Start symbol: program. *)

  | MenhirState121 : (((('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_BITAND, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 121.
        Stack shape : expr BITAND expr.
        Start symbol: program. *)

  | MenhirState122 : ((('s, _menhir_box_program) _menhir_cell1_ERR, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 122.
        Stack shape : ERR expr.
        Start symbol: program. *)

  | MenhirState124 : ((('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 124.
        Stack shape : IDENT expr.
        Start symbol: program. *)

  | MenhirState129 : (('s, _menhir_box_program) _menhir_cell1_field_init, _menhir_box_program) _menhir_state
    (** State 129.
        Stack shape : field_init.
        Start symbol: program. *)

  | MenhirState131 : ((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 131.
        Stack shape : IF expr.
        Start symbol: program. *)

  | MenhirState133 : (((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_state
    (** State 133.
        Stack shape : IF expr block.
        Start symbol: program. *)

  | MenhirState134 : ((((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_state
    (** State 134.
        Stack shape : IF expr block IF.
        Start symbol: program. *)

  | MenhirState135 : (((((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 135.
        Stack shape : IF expr block IF expr.
        Start symbol: program. *)

  | MenhirState137 : ((((((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_state
    (** State 137.
        Stack shape : IF expr block IF expr block.
        Start symbol: program. *)

  | MenhirState143 : ((('s, _menhir_box_program) _menhir_cell1_LPAREN, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 143.
        Stack shape : LPAREN expr.
        Start symbol: program. *)

  | MenhirState145 : ((('s, _menhir_box_program) _menhir_cell1_MATCH, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 145.
        Stack shape : MATCH expr.
        Start symbol: program. *)

  | MenhirState146 : (((('s, _menhir_box_program) _menhir_cell1_MATCH, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_LBRACE, _menhir_box_program) _menhir_state
    (** State 146.
        Stack shape : MATCH expr LBRACE.
        Start symbol: program. *)

  | MenhirState152 : (('s, _menhir_box_program) _menhir_cell1_variant_ident, _menhir_box_program) _menhir_state
    (** State 152.
        Stack shape : variant_ident.
        Start symbol: program. *)

  | MenhirState155 : (('s, _menhir_box_program) _menhir_cell1_pattern, _menhir_box_program) _menhir_state
    (** State 155.
        Stack shape : pattern.
        Start symbol: program. *)

  | MenhirState160 : (('s, _menhir_box_program) _menhir_cell1_pattern, _menhir_box_program) _menhir_state
    (** State 160.
        Stack shape : pattern.
        Start symbol: program. *)

  | MenhirState161 : ((('s, _menhir_box_program) _menhir_cell1_pattern, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 161.
        Stack shape : pattern expr.
        Start symbol: program. *)

  | MenhirState165 : (('s, _menhir_box_program) _menhir_cell1_match_arm, _menhir_box_program) _menhir_state
    (** State 165.
        Stack shape : match_arm.
        Start symbol: program. *)

  | MenhirState167 : ((('s, _menhir_box_program) _menhir_cell1_OK, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 167.
        Stack shape : OK expr.
        Start symbol: program. *)

  | MenhirState169 : ((('s, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 169.
        Stack shape : WHILE expr.
        Start symbol: program. *)

  | MenhirState173 : (('s, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 173.
        Stack shape : VAR IDENT.
        Start symbol: program. *)

  | MenhirState176 : (('s, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_IDENT _menhir_cell0_option___anonymous_4_, _menhir_box_program) _menhir_state
    (** State 176.
        Stack shape : VAR IDENT option(__anonymous_4).
        Start symbol: program. *)

  | MenhirState177 : ((('s, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_IDENT _menhir_cell0_option___anonymous_4_, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 177.
        Stack shape : VAR IDENT option(__anonymous_4) expr.
        Start symbol: program. *)

  | MenhirState182 : (('s, _menhir_box_program) _menhir_cell1_LET _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 182.
        Stack shape : LET IDENT.
        Start symbol: program. *)

  | MenhirState185 : (('s, _menhir_box_program) _menhir_cell1_LET _menhir_cell0_IDENT _menhir_cell0_option___anonymous_3_, _menhir_box_program) _menhir_state
    (** State 185.
        Stack shape : LET IDENT option(__anonymous_3).
        Start symbol: program. *)

  | MenhirState186 : ((('s, _menhir_box_program) _menhir_cell1_LET _menhir_cell0_IDENT _menhir_cell0_option___anonymous_3_, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 186.
        Stack shape : LET IDENT option(__anonymous_3) expr.
        Start symbol: program. *)

  | MenhirState189 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 189.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState190 : ((('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 190.
        Stack shape : IDENT expr.
        Start symbol: program. *)

  | MenhirState194 : (('s, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 194.
        Stack shape : FOR IDENT.
        Start symbol: program. *)

  | MenhirState195 : ((('s, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 195.
        Stack shape : FOR IDENT expr.
        Start symbol: program. *)

  | MenhirState199 : (('s, _menhir_box_program) _menhir_cell1_CONST _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 199.
        Stack shape : CONST IDENT.
        Start symbol: program. *)

  | MenhirState202 : (('s, _menhir_box_program) _menhir_cell1_CONST _menhir_cell0_IDENT _menhir_cell0_option___anonymous_5_, _menhir_box_program) _menhir_state
    (** State 202.
        Stack shape : CONST IDENT option(__anonymous_5).
        Start symbol: program. *)

  | MenhirState203 : ((('s, _menhir_box_program) _menhir_cell1_CONST _menhir_cell0_IDENT _menhir_cell0_option___anonymous_5_, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 203.
        Stack shape : CONST IDENT option(__anonymous_5) expr.
        Start symbol: program. *)

  | MenhirState205 : (('s, _menhir_box_program) _menhir_cell1_stmt, _menhir_box_program) _menhir_state
    (** State 205.
        Stack shape : stmt.
        Start symbol: program. *)

  | MenhirState206 : (('s, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 206.
        Stack shape : expr.
        Start symbol: program. *)

  | MenhirState214 : (('s, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 214.
        Stack shape : ENUM IDENT.
        Start symbol: program. *)

  | MenhirState216 : ((('s, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_base_type, _menhir_box_program) _menhir_state
    (** State 216.
        Stack shape : ENUM IDENT base_type.
        Start symbol: program. *)

  | MenhirState217 : (((('s, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_base_type, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 217.
        Stack shape : ENUM IDENT base_type expr.
        Start symbol: program. *)

  | MenhirState219 : ((((('s, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_base_type, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_RPAREN, _menhir_box_program) _menhir_state
    (** State 219.
        Stack shape : ENUM IDENT base_type expr RPAREN.
        Start symbol: program. *)

  | MenhirState221 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 221.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState222 : ((('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_state
    (** State 222.
        Stack shape : IDENT expr.
        Start symbol: program. *)

  | MenhirState228 : (('s, _menhir_box_program) _menhir_cell1_enum_member, _menhir_box_program) _menhir_state
    (** State 228.
        Stack shape : enum_member.
        Start symbol: program. *)

  | MenhirState233 : (('s, _menhir_box_program) _menhir_cell1_item, _menhir_box_program) _menhir_state
    (** State 233.
        Stack shape : item.
        Start symbol: program. *)

  | MenhirState237 : (('s, _menhir_box_program) _menhir_cell1_import_decl, _menhir_box_program) _menhir_state
    (** State 237.
        Stack shape : import_decl.
        Start symbol: program. *)


and ('s, 'r) _menhir_cell1_base_type = 
  | MenhirCell1_base_type of 's * ('s, 'r) _menhir_state * (Ast.base_type)

and ('s, 'r) _menhir_cell1_block = 
  | MenhirCell1_block of 's * ('s, 'r) _menhir_state * (Ast.block)

and ('s, 'r) _menhir_cell1_enum_member = 
  | MenhirCell1_enum_member of 's * ('s, 'r) _menhir_state * (Ast.enum_member)

and ('s, 'r) _menhir_cell1_expr = 
  | MenhirCell1_expr of 's * ('s, 'r) _menhir_state * (Ast.expr)

and ('s, 'r) _menhir_cell1_field = 
  | MenhirCell1_field of 's * ('s, 'r) _menhir_state * (Ast.field)

and ('s, 'r) _menhir_cell1_field_init = 
  | MenhirCell1_field_init of 's * ('s, 'r) _menhir_state * (string * Ast.expr)

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

and 's _menhir_cell0_option___anonymous_1_ = 
  | MenhirCell0_option___anonymous_1_ of 's * (Ast.typ option)

and 's _menhir_cell0_option___anonymous_3_ = 
  | MenhirCell0_option___anonymous_3_ of 's * (Ast.typ option)

and 's _menhir_cell0_option___anonymous_4_ = 
  | MenhirCell0_option___anonymous_4_ of 's * (Ast.typ option)

and 's _menhir_cell0_option___anonymous_5_ = 
  | MenhirCell0_option___anonymous_5_ of 's * (Ast.typ option)

and ('s, 'r) _menhir_cell1_param = 
  | MenhirCell1_param of 's * ('s, 'r) _menhir_state * (Ast.param)

and ('s, 'r) _menhir_cell1_pattern = 
  | MenhirCell1_pattern of 's * ('s, 'r) _menhir_state * (Ast.pattern)

and ('s, 'r) _menhir_cell1_stmt = 
  | MenhirCell1_stmt of 's * ('s, 'r) _menhir_state * (Ast.stmt)

and ('s, 'r) _menhir_cell1_typ = 
  | MenhirCell1_typ of 's * ('s, 'r) _menhir_state * (Ast.typ)

and ('s, 'r) _menhir_cell1_variant_ident = 
  | MenhirCell1_variant_ident of 's * ('s, 'r) _menhir_state * (string)

and ('s, 'r) _menhir_cell1_BITAND = 
  | MenhirCell1_BITAND of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_BITOR = 
  | MenhirCell1_BITOR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_COMMA = 
  | MenhirCell1_COMMA of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_CONST = 
  | MenhirCell1_CONST of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ENUM = 
  | MenhirCell1_ENUM of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_EQEQ = 
  | MenhirCell1_EQEQ of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_ERR = 
  | MenhirCell1_ERR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FN = 
  | MenhirCell1_FN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_FOR = 
  | MenhirCell1_FOR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GT = 
  | MenhirCell1_GT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_GTE = 
  | MenhirCell1_GTE of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * 
# 8 "lib/parser.mly"
       (string)
# 680 "lib/parser.ml"


and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * 
# 8 "lib/parser.mly"
       (string)
# 687 "lib/parser.ml"


and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IMPORT = 
  | MenhirCell1_IMPORT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_INT = 
  | MenhirCell1_INT of 's * ('s, 'r) _menhir_state * 
# 5 "lib/parser.mly"
       (int64)
# 700 "lib/parser.ml"


and ('s, 'r) _menhir_cell1_LBRACE = 
  | MenhirCell1_LBRACE of 's * ('s, 'r) _menhir_state

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

and ('s, 'r) _menhir_cell1_OK = 
  | MenhirCell1_OK of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PLUS = 
  | MenhirCell1_PLUS of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RESULT = 
  | MenhirCell1_RESULT of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RPAREN = 
  | MenhirCell1_RPAREN of 's * ('s, 'r) _menhir_state

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

and ('s, 'r) _menhir_cell1_VAR = 
  | MenhirCell1_VAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state

and _menhir_box_program = 
  | MenhirBox_program of (Ast.program) [@@unboxed]

let _menhir_action_001 =
  fun () ->
    (
# 61 "lib/parser.mly"
       ( TU8 )
# 768 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_002 =
  fun () ->
    (
# 61 "lib/parser.mly"
                     ( TU16 )
# 776 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_003 =
  fun () ->
    (
# 61 "lib/parser.mly"
                                    ( TU32 )
# 784 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_004 =
  fun () ->
    (
# 61 "lib/parser.mly"
                                                   ( TU64 )
# 792 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_005 =
  fun () ->
    (
# 62 "lib/parser.mly"
       ( TI8 )
# 800 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_006 =
  fun () ->
    (
# 62 "lib/parser.mly"
                     ( TI16 )
# 808 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_007 =
  fun () ->
    (
# 62 "lib/parser.mly"
                                    ( TI32 )
# 816 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_008 =
  fun () ->
    (
# 62 "lib/parser.mly"
                                                   ( TI64 )
# 824 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_009 =
  fun () ->
    (
# 63 "lib/parser.mly"
         ( TBool )
# 832 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_010 =
  fun () ->
    (
# 63 "lib/parser.mly"
                         ( TStr )
# 840 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_011 =
  fun id ->
    (
# 64 "lib/parser.mly"
             ( TCustom id )
# 848 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_012 =
  fun () ->
    (
# 74 "lib/parser.mly"
                  ( { stmts = []; ret_expr = None } )
# 856 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_013 =
  fun b ->
    (
# 75 "lib/parser.mly"
                                ( b )
# 864 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_014 =
  fun e ->
    (
# 78 "lib/parser.mly"
           ( { stmts = []; ret_expr = Some e } )
# 872 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_015 =
  fun s ->
    (
# 79 "lib/parser.mly"
           ( { stmts = [s]; ret_expr = None } )
# 880 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_016 =
  fun b s ->
    (
# 80 "lib/parser.mly"
                         ( { stmts = s :: b.stmts; ret_expr = b.ret_expr } )
# 888 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_017 =
  fun b ->
    (
# 143 "lib/parser.mly"
            ( b )
# 896 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_018 =
  fun cond els thn ->
    (
# 144 "lib/parser.mly"
                                                              ( { stmts = []; ret_expr = Some (EIf (cond, thn, els)) } )
# 904 "lib/parser.ml"
     : (Ast.block))

let _menhir_action_019 =
  fun base_typ iota_expr name xs ->
    let members = 
# 241 "<standard.mly>"
    ( xs )
# 912 "lib/parser.ml"
     in
    (
# 68 "lib/parser.mly"
    ( { name; base_typ; iota_expr; members } )
# 917 "lib/parser.ml"
     : (Ast.enum_decl))

let _menhir_action_020 =
  fun const_expr name ->
    (
# 71 "lib/parser.mly"
                                                ( { name; const_expr } )
# 925 "lib/parser.ml"
     : (Ast.enum_member))

let _menhir_action_021 =
  fun e1 e2 ->
    (
# 95 "lib/parser.mly"
                         ( EBinOp (e1, Add, e2) )
# 933 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_022 =
  fun e1 e2 ->
    (
# 96 "lib/parser.mly"
                          ( EBinOp (e1, Sub, e2) )
# 941 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_023 =
  fun e1 e2 ->
    (
# 97 "lib/parser.mly"
                         ( EBinOp (e1, Mul, e2) )
# 949 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_024 =
  fun e1 e2 ->
    (
# 98 "lib/parser.mly"
                          ( EBinOp (e1, Div, e2) )
# 957 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_025 =
  fun e1 e2 ->
    (
# 99 "lib/parser.mly"
                        ( EBinOp (e1, Shl, e2) )
# 965 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_026 =
  fun e1 e2 ->
    (
# 100 "lib/parser.mly"
                        ( EBinOp (e1, Shr, e2) )
# 973 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_027 =
  fun e1 e2 ->
    (
# 101 "lib/parser.mly"
                           ( EBinOp (e1, BitAnd, e2) )
# 981 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_028 =
  fun e1 e2 ->
    (
# 102 "lib/parser.mly"
                          ( EBinOp (e1, BitOr, e2) )
# 989 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_029 =
  fun e1 e2 ->
    (
# 103 "lib/parser.mly"
                         ( EBinOp (e1, Eq, e2) )
# 997 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_030 =
  fun e1 e2 ->
    (
# 104 "lib/parser.mly"
                        ( EBinOp (e1, Neq, e2) )
# 1005 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_031 =
  fun e1 e2 ->
    (
# 105 "lib/parser.mly"
                       ( EBinOp (e1, Lt, e2) )
# 1013 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_032 =
  fun e1 e2 ->
    (
# 106 "lib/parser.mly"
                       ( EBinOp (e1, Gt, e2) )
# 1021 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_033 =
  fun e1 e2 ->
    (
# 107 "lib/parser.mly"
                        ( EBinOp (e1, Lte, e2) )
# 1029 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_034 =
  fun e1 e2 ->
    (
# 108 "lib/parser.mly"
                        ( EBinOp (e1, Gte, e2) )
# 1037 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_035 =
  fun e ->
    (
# 109 "lib/parser.mly"
                            ( EOk e )
# 1045 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_036 =
  fun e ->
    (
# 110 "lib/parser.mly"
                             ( EErr e )
# 1053 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_037 =
  fun cond els thn ->
    (
# 111 "lib/parser.mly"
                                                              ( EIf (cond, thn, els) )
# 1061 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_038 =
  fun e f ->
    (
# 112 "lib/parser.mly"
                       ( EField (e, f) )
# 1069 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_039 =
  fun name xs ->
    let fields = 
# 241 "<standard.mly>"
    ( xs )
# 1077 "lib/parser.ml"
     in
    (
# 113 "lib/parser.mly"
                                                                      ( EStruct (name, fields) )
# 1082 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_040 =
  fun arms e ->
    (
# 114 "lib/parser.mly"
                                                             ( EMatch (e, arms) )
# 1090 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_041 =
  fun path xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 1098 "lib/parser.ml"
     in
    (
# 116 "lib/parser.mly"
    ( match path with
      | [id] -> ECall (id, args)
      | _ -> EPathCall (path, args) )
# 1105 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_042 =
  fun l ->
    (
# 119 "lib/parser.mly"
              ( ELit l )
# 1113 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_043 =
  fun id ->
    (
# 120 "lib/parser.mly"
             ( EVar id )
# 1121 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_044 =
  fun e ->
    (
# 121 "lib/parser.mly"
                         ( e )
# 1129 "lib/parser.ml"
     : (Ast.expr))

let _menhir_action_045 =
  fun name typ ->
    (
# 47 "lib/parser.mly"
                             ( ({ name; typ } : Ast.field) )
# 1137 "lib/parser.ml"
     : (Ast.field))

let _menhir_action_046 =
  fun e name ->
    (
# 124 "lib/parser.mly"
                            ( (name, e) )
# 1145 "lib/parser.ml"
     : (string * Ast.expr))

let _menhir_action_047 =
  fun body name ret_typ xs ->
    let params = 
# 241 "<standard.mly>"
    ( xs )
# 1153 "lib/parser.ml"
     in
    (
# 51 "lib/parser.mly"
    ( { name; params; ret_typ = Option.value ret_typ ~default:(TBase TUnit); body } )
# 1158 "lib/parser.ml"
     : (Ast.fn_decl))

let _menhir_action_048 =
  fun alias path ->
    (
# 32 "lib/parser.mly"
                                                                     ( { path; alias } )
# 1166 "lib/parser.ml"
     : (Ast.import_decl))

let _menhir_action_049 =
  fun () ->
    (
# 152 "lib/parser.mly"
       ( TU8 )
# 1174 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_050 =
  fun () ->
    (
# 152 "lib/parser.mly"
                     ( TU16 )
# 1182 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_051 =
  fun () ->
    (
# 152 "lib/parser.mly"
                                    ( TU32 )
# 1190 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_052 =
  fun () ->
    (
# 152 "lib/parser.mly"
                                                   ( TU64 )
# 1198 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_053 =
  fun () ->
    (
# 153 "lib/parser.mly"
       ( TI8 )
# 1206 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_054 =
  fun () ->
    (
# 153 "lib/parser.mly"
                     ( TI16 )
# 1214 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_055 =
  fun () ->
    (
# 153 "lib/parser.mly"
                                    ( TI32 )
# 1222 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_056 =
  fun () ->
    (
# 153 "lib/parser.mly"
                                                   ( TI64 )
# 1230 "lib/parser.ml"
     : (Ast.base_type))

let _menhir_action_057 =
  fun f ->
    (
# 39 "lib/parser.mly"
              ( IFn f )
# 1238 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_058 =
  fun e ->
    (
# 40 "lib/parser.mly"
                ( IEnum e )
# 1246 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_059 =
  fun t ->
    (
# 41 "lib/parser.mly"
                ( t )
# 1254 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_060 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 1262 "lib/parser.ml"
     : (Ast.import_decl list))

let _menhir_action_061 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 1270 "lib/parser.ml"
     : (Ast.import_decl list))

let _menhir_action_062 =
  fun () ->
    (
# 216 "<standard.mly>"
    ( [] )
# 1278 "lib/parser.ml"
     : (Ast.item list))

let _menhir_action_063 =
  fun x xs ->
    (
# 219 "<standard.mly>"
    ( x :: xs )
# 1286 "lib/parser.ml"
     : (Ast.item list))

let _menhir_action_064 =
  fun t v ->
    (
# 147 "lib/parser.mly"
                       ( LInt (v, t) )
# 1294 "lib/parser.ml"
     : (Ast.literal))

let _menhir_action_065 =
  fun v ->
    (
# 148 "lib/parser.mly"
               ( LBool v )
# 1302 "lib/parser.ml"
     : (Ast.literal))

let _menhir_action_066 =
  fun v ->
    (
# 149 "lib/parser.mly"
                 ( LStr v )
# 1310 "lib/parser.ml"
     : (Ast.literal))

let _menhir_action_067 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1318 "lib/parser.ml"
     : (Ast.enum_member list))

let _menhir_action_068 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1326 "lib/parser.ml"
     : (Ast.enum_member list))

let _menhir_action_069 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1334 "lib/parser.ml"
     : (Ast.expr list))

let _menhir_action_070 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1342 "lib/parser.ml"
     : (Ast.expr list))

let _menhir_action_071 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1350 "lib/parser.ml"
     : (Ast.field list))

let _menhir_action_072 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1358 "lib/parser.ml"
     : (Ast.field list))

let _menhir_action_073 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1366 "lib/parser.ml"
     : ((string * Ast.expr) list))

let _menhir_action_074 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1374 "lib/parser.ml"
     : ((string * Ast.expr) list))

let _menhir_action_075 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1382 "lib/parser.ml"
     : (Ast.param list))

let _menhir_action_076 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1390 "lib/parser.ml"
     : (Ast.param list))

let _menhir_action_077 =
  fun () ->
    (
# 145 "<standard.mly>"
    ( [] )
# 1398 "lib/parser.ml"
     : (Ast.pattern list))

let _menhir_action_078 =
  fun x ->
    (
# 148 "<standard.mly>"
    ( x )
# 1406 "lib/parser.ml"
     : (Ast.pattern list))

let _menhir_action_079 =
  fun e p ->
    (
# 127 "lib/parser.mly"
                                    ( (p, e) )
# 1414 "lib/parser.ml"
     : (Ast.pattern * Ast.expr))

let _menhir_action_080 =
  fun e p ->
    (
# 128 "lib/parser.mly"
                              ( (p, e) )
# 1422 "lib/parser.ml"
     : (Ast.pattern * Ast.expr))

let _menhir_action_081 =
  fun id ->
    (
# 35 "lib/parser.mly"
             ( [id] )
# 1430 "lib/parser.ml"
     : (string list))

let _menhir_action_082 =
  fun id rest ->
    (
# 36 "lib/parser.mly"
                                         ( id :: rest )
# 1438 "lib/parser.ml"
     : (string list))

let _menhir_action_083 =
  fun x ->
    (
# 228 "<standard.mly>"
    ( [ x ] )
# 1446 "lib/parser.ml"
     : ((Ast.pattern * Ast.expr) list))

let _menhir_action_084 =
  fun x xs ->
    (
# 231 "<standard.mly>"
    ( x :: xs )
# 1454 "lib/parser.ml"
     : ((Ast.pattern * Ast.expr) list))

let _menhir_action_085 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1462 "lib/parser.ml"
     : (string option))

let _menhir_action_086 =
  fun id ->
    let x = 
# 32 "lib/parser.mly"
                                                     (id)
# 1470 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1475 "lib/parser.ml"
     : (string option))

let _menhir_action_087 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1483 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_088 =
  fun t ->
    let x = 
# 50 "lib/parser.mly"
                                                                                                  (t)
# 1491 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1496 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_089 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1504 "lib/parser.ml"
     : (Ast.expr option))

let _menhir_action_090 =
  fun e ->
    let x = 
# 71 "lib/parser.mly"
                                           (e)
# 1512 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1517 "lib/parser.ml"
     : (Ast.expr option))

let _menhir_action_091 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1525 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_092 =
  fun t ->
    let x = 
# 83 "lib/parser.mly"
                                          (t)
# 1533 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1538 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_093 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1546 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_094 =
  fun t ->
    let x = 
# 85 "lib/parser.mly"
                                          (t)
# 1554 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1559 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_095 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1567 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_096 =
  fun t ->
    let x = 
# 87 "lib/parser.mly"
                                            (t)
# 1575 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1580 "lib/parser.ml"
     : (Ast.typ option))

let _menhir_action_097 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1588 "lib/parser.ml"
     : (Ast.block option))

let _menhir_action_098 =
  fun e ->
    let x = 
# 111 "lib/parser.mly"
                                                         (e)
# 1596 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1601 "lib/parser.ml"
     : (Ast.block option))

let _menhir_action_099 =
  fun () ->
    (
# 111 "<standard.mly>"
    ( None )
# 1609 "lib/parser.ml"
     : (Ast.block option))

let _menhir_action_100 =
  fun e ->
    let x = 
# 144 "lib/parser.mly"
                                                         (e)
# 1617 "lib/parser.ml"
     in
    (
# 114 "<standard.mly>"
    ( Some x )
# 1622 "lib/parser.ml"
     : (Ast.block option))

let _menhir_action_101 =
  fun name typ ->
    (
# 54 "lib/parser.mly"
                             ( ({ name; typ } : Ast.param) )
# 1630 "lib/parser.ml"
     : (Ast.param))

let _menhir_action_102 =
  fun () ->
    (
# 136 "lib/parser.mly"
               ( PWildcard )
# 1638 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_103 =
  fun _1 ->
    (
# 137 "lib/parser.mly"
          ( PIdent _1 )
# 1646 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_104 =
  fun () ->
    (
# 138 "lib/parser.mly"
       ( PVariant ("Ok", None) )
# 1654 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_105 =
  fun () ->
    (
# 139 "lib/parser.mly"
        ( PVariant ("Err", None) )
# 1662 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_106 =
  fun v xs ->
    let args = 
# 241 "<standard.mly>"
    ( xs )
# 1670 "lib/parser.ml"
     in
    (
# 140 "lib/parser.mly"
                                                                      ( PVariant (v, Some args) )
# 1675 "lib/parser.ml"
     : (Ast.pattern))

let _menhir_action_107 =
  fun imports items ->
    (
# 29 "lib/parser.mly"
                                                   ( { imports; items } )
# 1683 "lib/parser.ml"
     : (Ast.program))

let _menhir_action_108 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1691 "lib/parser.ml"
     : (Ast.enum_member list))

let _menhir_action_109 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1699 "lib/parser.ml"
     : (Ast.enum_member list))

let _menhir_action_110 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1707 "lib/parser.ml"
     : (Ast.expr list))

let _menhir_action_111 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1715 "lib/parser.ml"
     : (Ast.expr list))

let _menhir_action_112 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1723 "lib/parser.ml"
     : (Ast.field list))

let _menhir_action_113 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1731 "lib/parser.ml"
     : (Ast.field list))

let _menhir_action_114 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1739 "lib/parser.ml"
     : ((string * Ast.expr) list))

let _menhir_action_115 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1747 "lib/parser.ml"
     : ((string * Ast.expr) list))

let _menhir_action_116 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1755 "lib/parser.ml"
     : (Ast.param list))

let _menhir_action_117 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1763 "lib/parser.ml"
     : (Ast.param list))

let _menhir_action_118 =
  fun x ->
    (
# 250 "<standard.mly>"
    ( [ x ] )
# 1771 "lib/parser.ml"
     : (Ast.pattern list))

let _menhir_action_119 =
  fun x xs ->
    (
# 253 "<standard.mly>"
    ( x :: xs )
# 1779 "lib/parser.ml"
     : (Ast.pattern list))

let _menhir_action_120 =
  fun init name typ ->
    (
# 84 "lib/parser.mly"
    ( SDecl { kind = VLet; name; typ; init } )
# 1787 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_121 =
  fun init name typ ->
    (
# 86 "lib/parser.mly"
    ( SDecl { kind = VVar; name; typ; init } )
# 1795 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_122 =
  fun init name typ ->
    (
# 88 "lib/parser.mly"
    ( SDecl { kind = VConst; name; typ; init } )
# 1803 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_123 =
  fun e name ->
    (
# 89 "lib/parser.mly"
                                   ( SAssign (name, e) )
# 1811 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_124 =
  fun e ->
    (
# 90 "lib/parser.mly"
                     ( SExpr e )
# 1819 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_125 =
  fun b cond ->
    (
# 91 "lib/parser.mly"
                            ( SWhile (cond, b) )
# 1827 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_126 =
  fun b e id ->
    (
# 92 "lib/parser.mly"
                                   ( SFor (id, e, b) )
# 1835 "lib/parser.ml"
     : (Ast.stmt))

let _menhir_action_127 =
  fun b ->
    (
# 57 "lib/parser.mly"
                ( TBase b )
# 1843 "lib/parser.ml"
     : (Ast.typ))

let _menhir_action_128 =
  fun t1 t2 ->
    (
# 58 "lib/parser.mly"
                                     ( TResult (t1, t2) )
# 1851 "lib/parser.ml"
     : (Ast.typ))

let _menhir_action_129 =
  fun name xs ->
    let fields = 
# 241 "<standard.mly>"
    ( xs )
# 1859 "lib/parser.ml"
     in
    (
# 44 "lib/parser.mly"
                                                                        ( IStruct { name; fields } )
# 1864 "lib/parser.ml"
     : (Ast.item))

let _menhir_action_130 =
  fun _1 ->
    (
# 131 "lib/parser.mly"
          ( _1 )
# 1872 "lib/parser.ml"
     : (string))

let _menhir_action_131 =
  fun () ->
    (
# 132 "lib/parser.mly"
       ( "Ok" )
# 1880 "lib/parser.ml"
     : (string))

let _menhir_action_132 =
  fun () ->
    (
# 133 "lib/parser.mly"
        ( "Err" )
# 1888 "lib/parser.ml"
     : (string))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | WHILE ->
        "WHILE"
    | VAR ->
        "VAR"
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
    | RESULT ->
        "RESULT"
    | RBRACE ->
        "RBRACE"
    | PLUS ->
        "PLUS"
    | OK ->
        "OK"
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
    | LBRACE ->
        "LBRACE"
    | INT _ ->
        "INT"
    | IN ->
        "IN"
    | IMPORT ->
        "IMPORT"
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
    | FOR ->
        "FOR"
    | FN ->
        "FN"
    | FATARROW ->
        "FATARROW"
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
    | AT ->
        "AT"
    | AS ->
        "AS"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37"]
  
  let _menhir_run_231 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_list_import_decl_ -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_list_import_decl_ (_menhir_stack, _, imports) = _menhir_stack in
      let items = _v in
      let _v = _menhir_action_107 imports items in
      MenhirBox_program _v
  
  let rec _menhir_run_234 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_item -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_item (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_063 x xs in
      _menhir_goto_list_item_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_item_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState011 ->
          _menhir_run_231 _menhir_stack _v
      | MenhirState233 ->
          _menhir_run_234 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_001 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IMPORT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState001 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_002 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLONCOLON ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer
      | AS | LPAREN | SEMICOLON ->
          let id = _v in
          let _v = _menhir_action_081 id in
          _menhir_goto_module_path _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_003 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState003 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_002 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_module_path : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState003 ->
          _menhir_run_004 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState001 ->
          _menhir_run_005 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState058 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState063 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState075 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState079 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState081 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState084 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState094 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState098 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState100 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState102 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState104 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState106 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState108 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState110 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState112 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState114 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState116 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState118 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState120 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState134 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState160 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState176 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState185 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState189 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState194 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState202 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState205 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState216 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState221 ->
          _menhir_run_083 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_004 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
      let rest = _v in
      let _v = _menhir_action_082 id rest in
      _menhir_goto_module_path _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_005 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IMPORT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_module_path (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | AS ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v_0 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let id = _v_0 in
              let _v = _menhir_action_086 id in
              _menhir_goto_option___anonymous_0_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | SEMICOLON ->
          let _v = _menhir_action_085 () in
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
          let _v = _menhir_action_048 alias path in
          let _menhir_stack = MenhirCell1_import_decl (_menhir_stack, _menhir_s, _v) in
          (match (_tok : MenhirBasics.token) with
          | IMPORT ->
              _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState237
          | ENUM | EOF | FN | STRUCT ->
              let _v_0 = _menhir_action_060 () in
              _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_238 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_import_decl -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_import_decl (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_061 x xs in
      _menhir_goto_list_import_decl_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_import_decl_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState000 ->
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState237 ->
          _menhir_run_238 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_011 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_import_decl_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STRUCT ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState011
      | FN ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState011
      | ENUM ->
          _menhir_run_212 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState011
      | EOF ->
          let _v_0 = _menhir_action_062 () in
          _menhir_run_231 _menhir_stack _v_0
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_012 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STRUCT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACE ->
              let _menhir_s = MenhirState014 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | RBRACE ->
                  let _v = _menhir_action_071 () in
                  _menhir_goto_loption_separated_nonempty_list_COMMA_field__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_015 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState016 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | U8 ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_017 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_001 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_base_type : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState016 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState023 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState031 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState046 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState055 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState173 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState182 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState199 ->
          _menhir_run_034 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState214 ->
          _menhir_run_215 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_034 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let b = _v in
      let _v = _menhir_action_127 b in
      _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_typ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState023 ->
          _menhir_run_030 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState031 ->
          _menhir_run_032 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState016 ->
          _menhir_run_035 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState046 ->
          _menhir_run_047 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState055 ->
          _menhir_run_056 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState173 ->
          _menhir_run_174 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState182 ->
          _menhir_run_183 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState199 ->
          _menhir_run_200 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_030 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_RESULT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_typ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_s = MenhirState031 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | U8 ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_018 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_004 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_019 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_003 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_020 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_002 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_021 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_010 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_022 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RESULT (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LT ->
          let _menhir_s = MenhirState023 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | U8 ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_024 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let id = _v in
      let _v = _menhir_action_011 id in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_025 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_005 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_026 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_008 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_027 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_007 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_028 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_006 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_029 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_009 () in
      _menhir_goto_base_type _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_032 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_RESULT, _menhir_box_program) _menhir_cell1_typ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      match (_tok : MenhirBasics.token) with
      | GT ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_typ (_menhir_stack, _, t1) = _menhir_stack in
          let MenhirCell1_RESULT (_menhir_stack, _menhir_s) = _menhir_stack in
          let t2 = _v in
          let _v = _menhir_action_128 t1 t2 in
          _menhir_goto_typ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_035 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
      let typ = _v in
      let _v = _menhir_action_045 name typ in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_field (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState040 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_015 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RBRACE ->
          let x = _v in
          let _v = _menhir_action_112 x in
          _menhir_goto_separated_nonempty_list_COMMA_field_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_field_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState014 ->
          _menhir_run_036 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState040 ->
          _menhir_run_041 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_036 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_STRUCT _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_072 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_field__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_field__ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_STRUCT _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_STRUCT (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_129 name xs in
      let t = _v in
      let _v = _menhir_action_059 t in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_item : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_item (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STRUCT ->
          _menhir_run_012 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | FN ->
          _menhir_run_042 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | ENUM ->
          _menhir_run_212 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState233
      | EOF ->
          let _v_0 = _menhir_action_062 () in
          _menhir_run_234 _menhir_stack _v_0
      | _ ->
          _eRR ()
  
  and _menhir_run_042 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAREN ->
              let _menhir_s = MenhirState044 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | RPAREN ->
                  let _v = _menhir_action_075 () in
                  _menhir_goto_loption_separated_nonempty_list_COMMA_param__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_045 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState046 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | U8 ->
              _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U64 ->
              _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U32 ->
              _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | U16 ->
              _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | STR ->
              _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | RESULT ->
              _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | I8 ->
              _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I64 ->
              _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I32 ->
              _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | I16 ->
              _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL ->
              _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_param__ : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | MINUS ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | GT ->
              let _menhir_s = MenhirState055 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | U8 ->
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | LBRACE ->
          let _v = _menhir_action_087 () in
          _menhir_goto_option___anonymous_1_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_1_ : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option___anonymous_1_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState057
      | _ ->
          _eRR ()
  
  and _menhir_run_058 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | VAR ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | STRING_VAL _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState058
      | RBRACE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_012 () in
          _menhir_goto_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | OK ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | MATCH ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | LPAREN ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | LET ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | INT _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState058
      | IF ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | IDENT _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_188 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState058
      | FOR ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_192 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | ERR ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | CONST ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_197 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState058
      | BOOL_VAL _v ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, _menhir_s) in
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState058
      | _ ->
          _eRR ()
  
  and _menhir_run_059 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState059 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_060 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let v = _v in
      let _v = _menhir_action_066 v in
      _menhir_goto_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_literal : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let l = _v in
      let _v = _menhir_action_042 l in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expr : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState084 ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState116 ->
          _menhir_run_089 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState090 ->
          _menhir_run_091 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState094 ->
          _menhir_run_095 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState096 ->
          _menhir_run_097 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState098 ->
          _menhir_run_099 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState100 ->
          _menhir_run_101 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState102 ->
          _menhir_run_103 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState104 ->
          _menhir_run_105 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState106 ->
          _menhir_run_107 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState108 ->
          _menhir_run_109 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState110 ->
          _menhir_run_111 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState112 ->
          _menhir_run_113 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState114 ->
          _menhir_run_115 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState118 ->
          _menhir_run_119 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState120 ->
          _menhir_run_121 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState081 ->
          _menhir_run_122 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState079 ->
          _menhir_run_124 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState075 ->
          _menhir_run_131 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState134 ->
          _menhir_run_135 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState064 ->
          _menhir_run_143 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState063 ->
          _menhir_run_145 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState160 ->
          _menhir_run_161 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState062 ->
          _menhir_run_167 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState059 ->
          _menhir_run_169 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState176 ->
          _menhir_run_177 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState185 ->
          _menhir_run_186 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState189 ->
          _menhir_run_190 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState194 ->
          _menhir_run_195 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState202 ->
          _menhir_run_203 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState058 ->
          _menhir_run_206 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState205 ->
          _menhir_run_206 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState216 ->
          _menhir_run_217 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState221 ->
          _menhir_run_222 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_089 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          let _menhir_stack = MenhirCell1_COMMA (_menhir_stack, MenhirState089) in
          let _menhir_s = MenhirState116 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState089
      | RPAREN ->
          let x = _v in
          let _v = _menhir_action_110 x in
          _menhir_goto_separated_nonempty_list_COMMA_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_090 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_STAR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState090 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_061 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_OK (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState062 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_063 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MATCH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState063 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_064 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAREN (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState064 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_065 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_INT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | U8 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_049 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | U64 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_052 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | U32 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_051 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | U16 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_050 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | I8 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_053 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | I64 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_056 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | I32 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_055 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | I16 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let _v = _menhir_action_054 () in
          _menhir_goto_int_suffix _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_int_suffix : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_INT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_INT (_menhir_stack, _menhir_s, v) = _menhir_stack in
      let t = _v in
      let _v = _menhir_action_064 t v in
      _menhir_goto_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_075 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState075 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_076 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COLONCOLON ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | DOT | EQEQ | ERR | GT | GTE | IDENT _ | LT | LTE | MINUS | NEQ | OK | PLUS | RBRACE | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | UNDERSCORE ->
          let id = _v in
          let _v = _menhir_action_043 id in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let id = _v in
          let _v = _menhir_action_081 id in
          _menhir_goto_module_path _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_077 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _menhir_s = MenhirState077 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | RBRACE ->
          let _v = _menhir_action_073 () in
          _menhir_goto_loption_separated_nonempty_list_COMMA_field_init__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_078 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COLON ->
          let _menhir_s = MenhirState079 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_080 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ERR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState081 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_082 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let v = _v in
      let _v = _menhir_action_065 v in
      _menhir_goto_literal _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_field_init__ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_039 name xs in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_094 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SLASH (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState094 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_096 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SHR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState096 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_102 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_SHL (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState102 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_098 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PLUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState098 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_104 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_NEQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState104 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_100 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_MINUS (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState100 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_106 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LTE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState106 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_108 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState108 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_110 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GTE (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState110 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_112 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_GT (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState112 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_114 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_EQEQ (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState114 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_092 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e) = _menhir_stack in
          let f = _v in
          let _v = _menhir_action_038 e f in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_118 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_BITOR (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState118 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_120 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_BITAND (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState120 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_expr_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState084 ->
          _menhir_run_085 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState116 ->
          _menhir_run_117 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_085 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_module_path -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_070 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_expr__ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_module_path -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_module_path (_menhir_stack, _menhir_s, path) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_041 path xs in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_117 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_COMMA -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_COMMA (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_111 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_expr_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_091 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_STAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | MINUS | NEQ | OK | PLUS | RBRACE | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | UNDERSCORE ->
          let MenhirCell1_STAR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_023 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_095 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SLASH as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | MINUS | NEQ | OK | PLUS | RBRACE | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | UNDERSCORE ->
          let MenhirCell1_SLASH (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_024 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_097 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SHR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState097
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | NEQ | OK | RBRACE | RPAREN | SEMICOLON | SHL | SHR | UNDERSCORE ->
          let MenhirCell1_SHR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_026 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_099 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_PLUS as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState099
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState099
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | MINUS | NEQ | OK | PLUS | RBRACE | RPAREN | SEMICOLON | SHL | SHR | UNDERSCORE ->
          let MenhirCell1_PLUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_021 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_101 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_MINUS as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState101
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | MINUS | NEQ | OK | PLUS | RBRACE | RPAREN | SEMICOLON | SHL | SHR | UNDERSCORE ->
          let MenhirCell1_MINUS (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_022 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_103 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_SHL as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState103
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState103
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState103
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState103
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | NEQ | OK | RBRACE | RPAREN | SEMICOLON | SHL | SHR | UNDERSCORE ->
          let MenhirCell1_SHL (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_025 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_105 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_NEQ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState105
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | NEQ | OK | RBRACE | RPAREN | SEMICOLON | UNDERSCORE ->
          let MenhirCell1_NEQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_030 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_107 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_LTE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState107
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | NEQ | OK | RBRACE | RPAREN | SEMICOLON | UNDERSCORE ->
          let MenhirCell1_LTE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_033 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_109 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_LT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState109
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState109
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState109
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState109
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState109
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState109
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | NEQ | OK | RBRACE | RPAREN | SEMICOLON | UNDERSCORE ->
          let MenhirCell1_LT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_031 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_111 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_GTE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState111
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState111
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState111
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState111
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState111
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState111
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | NEQ | OK | RBRACE | RPAREN | SEMICOLON | UNDERSCORE ->
          let MenhirCell1_GTE (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_034 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_113 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_GT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState113
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | NEQ | OK | RBRACE | RPAREN | SEMICOLON | UNDERSCORE ->
          let MenhirCell1_GT (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_032 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_115 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_EQEQ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState115
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState115
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState115
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState115
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState115
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState115
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | NEQ | OK | RBRACE | RPAREN | SEMICOLON | UNDERSCORE ->
          let MenhirCell1_EQEQ (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_029 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_119 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_BITOR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState119
      | BITOR | COMMA | ERR | IDENT _ | LBRACE | OK | RBRACE | RPAREN | SEMICOLON | UNDERSCORE ->
          let MenhirCell1_BITOR (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_028 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_121 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_BITAND as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState121
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | COMMA | ERR | IDENT _ | LBRACE | OK | RBRACE | RPAREN | SEMICOLON | UNDERSCORE ->
          let MenhirCell1_BITAND (_menhir_stack, _) = _menhir_stack in
          let MenhirCell1_expr (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_027 e1 e2 in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_122 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_ERR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_ERR (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_036 e in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState122
      | _ ->
          _eRR ()
  
  and _menhir_run_124 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState124
      | COMMA | RBRACE ->
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_046 e name in
          (match (_tok : MenhirBasics.token) with
          | COMMA ->
              let _menhir_stack = MenhirCell1_field_init (_menhir_stack, _menhir_s, _v) in
              let _menhir_s = MenhirState129 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_078 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | RBRACE ->
              let x = _v in
              let _v = _menhir_action_114 x in
              _menhir_goto_separated_nonempty_list_COMMA_field_init_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _menhir_fail ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_field_init_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState077 ->
          _menhir_run_125 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState129 ->
          _menhir_run_130 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_125 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_074 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_field_init__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_130 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_field_init -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_field_init (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_115 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_field_init_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_131 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | SLASH ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | SHR ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | SHL ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | PLUS ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | NEQ ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | MINUS ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | LTE ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | LT ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | LBRACE ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | GTE ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | GT ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | EQEQ ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | DOT ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | BITAND ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState131
      | _ ->
          _eRR ()
  
  and _menhir_run_135 : type  ttv_stack. (((((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | SLASH ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | SHR ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | SHL ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | PLUS ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | NEQ ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | MINUS ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | LTE ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | LT ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | LBRACE ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | GTE ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | GT ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | EQEQ ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | DOT ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | BITAND ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState135
      | _ ->
          _eRR ()
  
  and _menhir_run_143 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LPAREN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAREN (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_044 e in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState143
      | _ ->
          _eRR ()
  
  and _menhir_run_145 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_MATCH as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | SLASH ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | SHR ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | SHL ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | PLUS ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | NEQ ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | MINUS ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | LTE ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | LT ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | LBRACE ->
          let _menhir_stack = MenhirCell1_LBRACE (_menhir_stack, MenhirState145) in
          let _menhir_s = MenhirState146 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UNDERSCORE ->
              _menhir_run_147 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | OK ->
              _menhir_run_148 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | GTE ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | GT ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | EQEQ ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | DOT ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | BITAND ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState145
      | _ ->
          _eRR ()
  
  and _menhir_run_147 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let _v = _menhir_action_102 () in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_pattern : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState152 ->
          _menhir_run_154 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState155 ->
          _menhir_run_154 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState146 ->
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState165 ->
          _menhir_run_159 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_154 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_pattern (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState155 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | UNDERSCORE ->
              _menhir_run_147 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | OK ->
              _menhir_run_148 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let x = _v in
          let _v = _menhir_action_118 x in
          _menhir_goto_separated_nonempty_list_COMMA_pattern_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_148 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA | FATARROW | RPAREN ->
          let _v = _menhir_action_104 () in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let _v = _menhir_action_131 () in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_variant_ident : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_variant_ident (_menhir_stack, _menhir_s, _v) in
      let _menhir_s = MenhirState152 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | UNDERSCORE ->
          _menhir_run_147 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | OK ->
          _menhir_run_148 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | RPAREN ->
          let _v = _menhir_action_077 () in
          _menhir_goto_loption_separated_nonempty_list_COMMA_pattern__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_149 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA | FATARROW | RPAREN ->
          let _1 = _v in
          let _v = _menhir_action_103 _1 in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let _1 = _v in
          let _v = _menhir_action_130 _1 in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_150 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA | FATARROW | RPAREN ->
          let _v = _menhir_action_105 () in
          _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let _v = _menhir_action_132 () in
          _menhir_goto_variant_ident _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_pattern__ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_variant_ident (_menhir_stack, _menhir_s, v) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_106 v xs in
      _menhir_goto_pattern _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_separated_nonempty_list_COMMA_pattern_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState152 ->
          _menhir_run_153 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState155 ->
          _menhir_run_156 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_153 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_variant_ident -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_078 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_pattern__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_156 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_pattern -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_pattern (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_119 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_pattern_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_159 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_pattern (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | FATARROW ->
          let _menhir_s = MenhirState160 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_161 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_pattern as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_pattern (_menhir_stack, _menhir_s, p) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_079 e p in
          _menhir_goto_match_arm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState161
      | ERR | IDENT _ | OK | RBRACE | UNDERSCORE ->
          let MenhirCell1_pattern (_menhir_stack, _menhir_s, p) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_080 e p in
          _menhir_goto_match_arm _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_match_arm : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | UNDERSCORE ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_147 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState165
      | OK ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_148 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState165
      | IDENT _v_0 ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_149 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState165
      | ERR ->
          let _menhir_stack = MenhirCell1_match_arm (_menhir_stack, _menhir_s, _v) in
          _menhir_run_150 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState165
      | RBRACE ->
          let x = _v in
          let _v = _menhir_action_083 x in
          _menhir_goto_nonempty_list_match_arm_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_nonempty_list_match_arm_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState146 ->
          _menhir_run_163 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState165 ->
          _menhir_run_166 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_163 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_MATCH, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_LBRACE -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell1_MATCH (_menhir_stack, _menhir_s) = _menhir_stack in
      let arms = _v in
      let _v = _menhir_action_040 arms e in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_166 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_match_arm -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_match_arm (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_084 x xs in
      _menhir_goto_nonempty_list_match_arm_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_167 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_OK as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | RPAREN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_OK (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_035 e in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState167
      | _ ->
          _eRR ()
  
  and _menhir_run_169 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | SLASH ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | SHR ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | SHL ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | PLUS ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | NEQ ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | MINUS ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | LTE ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | LT ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | LBRACE ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | GTE ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | GT ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | EQEQ ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | DOT ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | BITAND ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState169
      | _ ->
          _eRR ()
  
  and _menhir_run_177 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_IDENT _menhir_cell0_option___anonymous_4_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_option___anonymous_4_ (_menhir_stack, typ) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_VAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let init = _v in
          let _v = _menhir_action_121 init name typ in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState177
      | _ ->
          _eRR ()
  
  and _menhir_goto_stmt : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_059 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | VAR ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_171 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | STRING_VAL _v_0 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState205
      | OK ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | MATCH ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | LPAREN ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | LET ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_180 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | INT _v_1 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v_1 MenhirState205
      | IF ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | IDENT _v_2 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_188 _menhir_stack _menhir_lexbuf _menhir_lexer _v_2 MenhirState205
      | FOR ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_192 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | ERR ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | CONST ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_197 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState205
      | BOOL_VAL _v_3 ->
          let _menhir_stack = MenhirCell1_stmt (_menhir_stack, _menhir_s, _v) in
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v_3 MenhirState205
      | RBRACE ->
          let s = _v in
          let _v = _menhir_action_015 s in
          _menhir_goto_block_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_171 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_VAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState173 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | U8 ->
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | EQ ->
              let _v = _menhir_action_093 () in
              _menhir_goto_option___anonymous_4_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_4_ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option___anonymous_4_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState176 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_180 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LET (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState182 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | U8 ->
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | EQ ->
              let _v = _menhir_action_091 () in
              _menhir_goto_option___anonymous_3_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_3_ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_LET _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option___anonymous_3_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState185 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_188 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LBRACE ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_077 _menhir_stack _menhir_lexbuf _menhir_lexer
      | EQ ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState189 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | COLONCOLON ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_003 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITAND | BITOR | DOT | EQEQ | GT | GTE | LT | LTE | MINUS | NEQ | PLUS | RBRACE | SEMICOLON | SHL | SHR | SLASH | STAR ->
          let id = _v in
          let _v = _menhir_action_043 id in
          _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | LPAREN ->
          let id = _v in
          let _v = _menhir_action_081 id in
          _menhir_goto_module_path _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_192 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FOR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IN ->
              let _menhir_s = MenhirState194 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | STRING_VAL _v ->
                  _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | OK ->
                  _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | MATCH ->
                  _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | LPAREN ->
                  _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | INT _v ->
                  _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | IF ->
                  _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | ERR ->
                  _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL_VAL _v ->
                  _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_197 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_CONST (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState199 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | U8 ->
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | RESULT ->
                  _menhir_run_022 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | EQ ->
              let _v = _menhir_action_095 () in
              _menhir_goto_option___anonymous_5_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_5_ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_CONST _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let _menhir_stack = MenhirCell0_option___anonymous_5_ (_menhir_stack, _v) in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState202 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_goto_block_stmts : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState205 ->
          _menhir_run_208 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState058 ->
          _menhir_run_209 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_208 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_stmt -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_stmt (_menhir_stack, _menhir_s, s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_016 b s in
      _menhir_goto_block_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_209 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_LBRACE -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_LBRACE (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_013 b in
      _menhir_goto_block _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_block : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState131 ->
          _menhir_run_132 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState135 ->
          _menhir_run_136 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState133 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState137 ->
          _menhir_run_139 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState169 ->
          _menhir_run_170 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState195 ->
          _menhir_run_196 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState057 ->
          _menhir_run_211 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_132 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_block (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _menhir_s = MenhirState133 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACE ->
              _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | BITAND | BITOR | COMMA | DOT | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | MINUS | NEQ | OK | PLUS | RBRACE | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | UNDERSCORE ->
          let _v = _menhir_action_097 () in
          _menhir_goto_option___anonymous_6_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_134 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block as 'stack) -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _menhir_s = MenhirState134 in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | STRING_VAL _v ->
          _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | OK ->
          _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | MATCH ->
          _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | LPAREN ->
          _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | INT _v ->
          _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | IF ->
          _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | IDENT _v ->
          _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | ERR ->
          _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
      | BOOL_VAL _v ->
          _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_6_ : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_block (_menhir_stack, _, thn) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, cond) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let els = _v in
      let _v = _menhir_action_037 cond els thn in
      _menhir_goto_expr _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_136 : type  ttv_stack. ((((((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_block (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _menhir_s = MenhirState137 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACE ->
              _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IF ->
              _menhir_run_134 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | _ ->
              _eRR ())
      | BITAND | BITOR | COMMA | DOT | EQEQ | ERR | GT | GTE | IDENT _ | LBRACE | LT | LTE | MINUS | NEQ | OK | PLUS | RBRACE | RPAREN | SEMICOLON | SHL | SHR | SLASH | STAR | UNDERSCORE ->
          let _v = _menhir_action_099 () in
          _menhir_goto_option___anonymous_7_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_7_ : type  ttv_stack. ((((((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_block (_menhir_stack, _, thn) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, cond) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let els = _v in
      let _v = _menhir_action_018 cond els thn in
      _menhir_goto_else_branch _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_else_branch : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState137 ->
          _menhir_run_138 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState133 ->
          _menhir_run_141 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_138 : type  ttv_stack. ((((((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let e = _v in
      let _v = _menhir_action_100 e in
      _menhir_goto_option___anonymous_7_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_141 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let e = _v in
      let _v = _menhir_action_098 e in
      _menhir_goto_option___anonymous_6_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_139 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_block as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let b = _v in
      let _v = _menhir_action_017 b in
      _menhir_goto_else_branch _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_170 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _, cond) = _menhir_stack in
      let MenhirCell1_WHILE (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_125 b cond in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_196 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_expr -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expr (_menhir_stack, _, e) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, id) = _menhir_stack in
      let MenhirCell1_FOR (_menhir_stack, _menhir_s) = _menhir_stack in
      let b = _v in
      let _v = _menhir_action_126 b e id in
      _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_211 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ _menhir_cell0_option___anonymous_1_ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell0_option___anonymous_1_ (_menhir_stack, ret_typ) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_param__ (_menhir_stack, _, xs) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_FN (_menhir_stack, _menhir_s) = _menhir_stack in
      let body = _v in
      let _v = _menhir_action_047 body name ret_typ xs in
      let f = _v in
      let _v = _menhir_action_057 f in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_186 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LET _menhir_cell0_IDENT _menhir_cell0_option___anonymous_3_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_option___anonymous_3_ (_menhir_stack, typ) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_LET (_menhir_stack, _menhir_s) = _menhir_stack in
          let init = _v in
          let _v = _menhir_action_120 init name typ in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState186
      | _ ->
          _eRR ()
  
  and _menhir_run_190 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_123 e name in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState190
      | _ ->
          _eRR ()
  
  and _menhir_run_195 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FOR _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | SLASH ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | SHR ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | SHL ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | PLUS ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | NEQ ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | MINUS ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | LTE ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | LT ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | LBRACE ->
          _menhir_run_058 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | GTE ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | GT ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | EQEQ ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | DOT ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | BITAND ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState195
      | _ ->
          _eRR ()
  
  and _menhir_run_203 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_CONST _menhir_cell0_IDENT _menhir_cell0_option___anonymous_5_ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell0_option___anonymous_5_ (_menhir_stack, typ) = _menhir_stack in
          let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
          let MenhirCell1_CONST (_menhir_stack, _menhir_s) = _menhir_stack in
          let init = _v in
          let _v = _menhir_action_122 init name typ in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState203
      | _ ->
          _eRR ()
  
  and _menhir_run_206 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | SEMICOLON ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_124 e in
          _menhir_goto_stmt _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState206
      | RBRACE ->
          let e = _v in
          let _v = _menhir_action_014 e in
          _menhir_goto_block_stmts _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_217 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_base_type as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | SLASH ->
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | SHR ->
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | SHL ->
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | RPAREN ->
          let _menhir_stack = MenhirCell1_RPAREN (_menhir_stack, MenhirState217) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LBRACE ->
              let _menhir_s = MenhirState219 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_220 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | RBRACE ->
                  let _v = _menhir_action_067 () in
                  _menhir_goto_loption_separated_nonempty_list_COMMA_enum_member__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | PLUS ->
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | NEQ ->
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | MINUS ->
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | LTE ->
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | LT ->
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | GTE ->
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | GT ->
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | EQEQ ->
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | DOT ->
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | BITAND ->
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState217
      | _ ->
          _eRR ()
  
  and _menhir_run_220 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | EQ ->
          let _menhir_s = MenhirState221 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | COMMA | RBRACE ->
          let _v = _menhir_action_089 () in
          _menhir_goto_option___anonymous_2_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_goto_option___anonymous_2_ : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
      let const_expr = _v in
      let _v = _menhir_action_020 const_expr name in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_enum_member (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState228 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_220 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RBRACE ->
          let x = _v in
          let _v = _menhir_action_108 x in
          _menhir_goto_separated_nonempty_list_COMMA_enum_member_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_enum_member_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState219 ->
          _menhir_run_224 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState228 ->
          _menhir_run_229 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_224 : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_base_type, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_RPAREN -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_068 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_enum_member__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_goto_loption_separated_nonempty_list_COMMA_enum_member__ : type  ttv_stack. ((((ttv_stack, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_base_type, _menhir_box_program) _menhir_cell1_expr, _menhir_box_program) _menhir_cell1_RPAREN -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_RPAREN (_menhir_stack, _) = _menhir_stack in
      let MenhirCell1_expr (_menhir_stack, _, iota_expr) = _menhir_stack in
      let MenhirCell1_base_type (_menhir_stack, _, base_typ) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_ENUM (_menhir_stack, _menhir_s) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_019 base_typ iota_expr name xs in
      let e = _v in
      let _v = _menhir_action_058 e in
      _menhir_goto_item _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_229 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_enum_member -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_enum_member (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_109 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_enum_member_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_222 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_090 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | SLASH ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_094 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | SHR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_096 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | SHL ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_102 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | PLUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_098 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | NEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_104 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | MINUS ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_100 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | LTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_106 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | LT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_108 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | GTE ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_110 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | GT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_112 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | EQEQ ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_114 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | DOT ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_092 _menhir_stack _menhir_lexbuf _menhir_lexer
      | BITOR ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_118 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | BITAND ->
          let _menhir_stack = MenhirCell1_expr (_menhir_stack, _menhir_s, _v) in
          _menhir_run_120 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState222
      | COMMA | RBRACE ->
          let e = _v in
          let _v = _menhir_action_090 e in
          _menhir_goto_option___anonymous_2_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_212 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_ENUM (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | COLON ->
              let _menhir_s = MenhirState214 in
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | U8 ->
                  _menhir_run_017 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U64 ->
                  _menhir_run_018 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U32 ->
                  _menhir_run_019 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | U16 ->
                  _menhir_run_020 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | STR ->
                  _menhir_run_021 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | IDENT _v ->
                  _menhir_run_024 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
              | I8 ->
                  _menhir_run_025 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I64 ->
                  _menhir_run_026 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I32 ->
                  _menhir_run_027 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | I16 ->
                  _menhir_run_028 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | BOOL ->
                  _menhir_run_029 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_041 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_field -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_field (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_113 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_field_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_047 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, name) = _menhir_stack in
      let typ = _v in
      let _v = _menhir_action_101 name typ in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_param (_menhir_stack, _menhir_s, _v) in
          let _menhir_s = MenhirState050 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_045 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | RPAREN ->
          let x = _v in
          let _v = _menhir_action_116 x in
          _menhir_goto_separated_nonempty_list_COMMA_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_param_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState044 ->
          _menhir_run_048 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | MenhirState050 ->
          _menhir_run_051 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_048 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let x = _v in
      let _v = _menhir_action_076 x in
      _menhir_goto_loption_separated_nonempty_list_COMMA_param__ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_051 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_param -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_param (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_117 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_param_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_056 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FN _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_param__ -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let t = _v in
      let _v = _menhir_action_088 t in
      _menhir_goto_option___anonymous_1_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_174 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_VAR _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let t = _v in
      let _v = _menhir_action_094 t in
      _menhir_goto_option___anonymous_4_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_183 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_LET _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let t = _v in
      let _v = _menhir_action_092 t in
      _menhir_goto_option___anonymous_3_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_200 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_CONST _menhir_cell0_IDENT -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let t = _v in
      let _v = _menhir_action_096 t in
      _menhir_goto_option___anonymous_5_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
  
  and _menhir_run_215 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_ENUM _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_base_type (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState216 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_083 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_module_path (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | LPAREN ->
          let _menhir_s = MenhirState084 in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | STRING_VAL _v ->
              _menhir_run_060 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | OK ->
              _menhir_run_061 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | MATCH ->
              _menhir_run_063 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | LPAREN ->
              _menhir_run_064 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | INT _v ->
              _menhir_run_065 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | IF ->
              _menhir_run_075 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | IDENT _v ->
              _menhir_run_076 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | ERR ->
              _menhir_run_080 _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s
          | BOOL_VAL _v ->
              _menhir_run_082 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
          | RPAREN ->
              let _v = _menhir_action_069 () in
              _menhir_goto_loption_separated_nonempty_list_COMMA_expr__ _menhir_stack _menhir_lexbuf _menhir_lexer _v
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  let _menhir_run_000 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IMPORT ->
          _menhir_run_001 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState000
      | ENUM | EOF | FN | STRUCT ->
          let _v = _menhir_action_060 () in
          _menhir_run_011 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState000 _tok
      | _ ->
          _eRR ()
  
end

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_000 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
