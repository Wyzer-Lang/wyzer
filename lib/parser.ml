[@@@warning "-27"]
open Ast
open Token
open Diagnostic

exception Error

type parser_state = {
  lexbuf: Lexing.lexbuf;
  lexer: Lexing.lexbuf -> token;
  mutable current: token;
}

let init_state lexer lexbuf =
  let p = { lexbuf; lexer; current = EOF } in
  p.current <- lexer lexbuf;
  p

let next_token p =
  p.current <- p.lexer p.lexbuf

let peek p = p.current

let consume p tok =
  if p.current = tok then (next_token p; true)
  else false

let get_pos p =
  p.lexbuf.lex_start_p

let make_span start_pos end_pos =
  {
    file = start_pos.Lexing.pos_fname;
    start_line = start_pos.Lexing.pos_lnum;
    start_col = start_pos.Lexing.pos_cnum - start_pos.Lexing.pos_bol + 1;
    end_line = end_pos.Lexing.pos_lnum;
    end_col = end_pos.Lexing.pos_cnum - end_pos.Lexing.pos_bol + 1;
  }

let expect p tok =
  if p.current = tok then next_token p
  else
    let pos = get_pos p in
    let span = make_span pos pos in
    let patches = if tok = SEMICOLON then [ { Diagnostic.span; replacement = ";" } ] else [] in
    raise_error
      ~code:Error_codes.unexpected_token
      ~label:(Printf.sprintf "expected `%s`, found `%s`" (show_token_human tok) (show_token_human p.current))
      ~patches
      (Printf.sprintf "expected `%s`" (show_token_human tok))
      span

let expect_semi_opt_rbrace p =
  if consume p SEMICOLON then ()
  else if peek p = RBRACE then ()
  else expect p SEMICOLON

let error p msg =
  let pos = get_pos p in
  let span = make_span pos pos in
  raise_error
    ~code:Error_codes.syntax_error
    ~label:(Printf.sprintf "unexpected token `%s`" (show_token_human p.current))
    msg
    span

let combine_span s end_pos =
  { s with
    end_line = end_pos.Lexing.pos_lnum;
    end_col = end_pos.Lexing.pos_cnum - end_pos.Lexing.pos_bol + 1;
  }

let with_span p f =
  let start_pos = get_pos p in
  let item = f start_pos in
  let end_pos = get_pos p in
  { item; span = make_span start_pos end_pos }

let rec parse_separated_list p sep parse_fn =
  match peek p with
  | EOF -> []
  | t when t = sep -> []
  | _ ->
      let first = parse_fn p in
      if consume p sep then
        first :: parse_separated_list p sep parse_fn
      else
        [first]

let parse_separated_nonempty_list p sep parse_fn =
  let first = parse_fn p in
  if consume p sep then
    first :: parse_separated_list p sep parse_fn
  else
    [first]

let rec parse_module_path p =
  match peek p with
  | IDENT _ | OK | ERR ->
      let id_str = match peek p with
        | IDENT id -> id
        | OK -> "Ok"
        | ERR -> "Err"
        | _ -> assert false
      in
      next_token p;
      if consume p COLONCOLON then
        id_str :: parse_module_path p
      else
        [id_str]
  | _ -> error p "Expected identifier in module path"

let bp_infix = function
  | OR -> (10, 11)
  | AND -> (20, 21)
  | EQEQ | NEQ | LT | GT | LTE | GTE -> (30, 31)
  | BITOR -> (40, 41)
  | BITAND -> (50, 51)
  | SHL | SHR -> (60, 61)
  | PLUS | MINUS -> (70, 71)
  | STAR | SLASH -> (80, 81)
  | AS -> (90, 91)
  | DOT -> (100, 101)
  | AT -> (110, 111)
  | LBRACKET -> (120, 121)
  | _ -> (-1, -1)

let parse_int_suffix _p = None
let parse_float_suffix _p = None

let parse_literal p =
  match peek p with
  | INT v ->
      next_token p;
      let suf = parse_int_suffix p in
      LInt (v, suf)
  | FLOAT v ->
      next_token p;
      let suf = parse_float_suffix p in
      LFloat (v, suf)
  | BOOL_VAL b -> next_token p; LBool b
  | STRING_VAL s -> next_token p; LStr s
  | CHAR_VAL c -> next_token p; LChar c
  | _ -> error p "Expected literal"

let rec parse_base_type p =
  match peek p with
  | U8 -> next_token p; TU8
  | U16 -> next_token p; TU16
  | U32 -> next_token p; TU32
  | U64 -> next_token p; TU64
  | U128 -> next_token p; TU128
  | USIZE -> next_token p; TUSize
  | I8 -> next_token p; TI8
  | I16 -> next_token p; TI16
  | I32 -> next_token p; TI32
  | I64 -> next_token p; TI64
  | I128 -> next_token p; TI128
  | ISIZE -> next_token p; TISize
  | F8 -> next_token p; TF8
  | F16 -> next_token p; TF16
  | F32 -> next_token p; TF32
  | F64 -> next_token p; TF64
  | F128 -> next_token p; TF128
  | BOOL -> next_token p; TBool
  | STR -> next_token p; TStr
  | CHAR -> next_token p; TChar
  | IDENT id -> next_token p; TCustom id
  | GENERIC ->
      next_token p;
      expect p LT;
      let args = parse_separated_nonempty_list p COMMA parse_typ in
      expect p GT;
      let inner = parse_base_type p in
      TGenericApp (args, inner)
  | _ -> error p "Expected base type"

and parse_typ p =
  with_span p (fun start_pos ->
    match peek p with
    | LBRACKET ->
        next_token p;
        let t = parse_typ p in
        expect p RBRACKET;
        if consume p AT then 
          let inner = { item = TArray t; span = make_span start_pos (get_pos p) } in
          TRole (inner, parse_ident p)
        else TArray t
    | LPAREN ->
        next_token p;
        let t1 = parse_typ p in
        expect p COMMA;
        let rest = parse_separated_nonempty_list p COMMA parse_typ in
        expect p RPAREN;
        TTuple (t1 :: rest)
    | RESULT ->
        next_token p;
        expect p LT;
        let t1 = parse_typ p in
        expect p COMMA;
        let t2 = parse_typ p in
        expect p GT;
        if consume p AT then
          let inner = { item = TResult (t1, t2); span = make_span start_pos (get_pos p) } in
          TRole (inner, parse_ident p)
        else TResult (t1, t2)
    | _ ->
        let b = parse_base_type p in
        if consume p AT then
          let inner = { item = TBase b; span = make_span start_pos (get_pos p) } in
          TRole (inner, parse_ident p)
        else TBase b
  )

and parse_ident p =
  match peek p with
  | IDENT id -> next_token p; id
  | _ -> error p "Expected identifier"

and parse_variant_ident p =
  match peek p with
  | IDENT id -> next_token p; id
  | OK -> next_token p; "Ok"
  | ERR -> next_token p; "Err"
  | _ -> error p "Expected variant identifier"

and parse_expr p min_bp no_struct =
  let lhs = parse_prefix p no_struct in
  let rec loop lhs =
    let (l_bp, r_bp) = bp_infix (peek p) in
    if l_bp < min_bp then lhs
    else
      let op = peek p in
      next_token p;
      let rhs = parse_infix p lhs op r_bp no_struct in
      loop rhs
  in
  loop lhs

and parse_prefix p no_struct =
  with_span p (fun start_pos ->
    match peek p with
    | NOT ->
        next_token p;
        let r = parse_expr p 130 no_struct in
        EUnOp (Not, r)
    | MINUS ->
        next_token p;
        let r = parse_expr p 130 no_struct in
        EUnOp (Neg, r)
    | INT _ | FLOAT _ | BOOL_VAL _ | STRING_VAL _ | CHAR_VAL _ ->
        ELit (parse_literal p)
    | OK ->
        next_token p;
        if consume p LPAREN then (
          let e = parse_expr p 0 false in
          expect p RPAREN;
          EOk (e, None)
        ) else (
          EPathVar ["Ok"]
        )
    | ERR ->
        next_token p;
        if consume p LPAREN then (
          let e = parse_expr p 0 false in
          expect p RPAREN;
          EErr (e, None)
        ) else (
          EPathVar ["Err"]
        )
    | IOTA ->
        next_token p;
        EVar "iota"
    | IF ->
        next_token p;
        let cond = parse_expr p 0 true in
        let thn = parse_block p in
        let els = if consume p ELSE then Some (parse_else_branch p) else None in
        EIf (cond, thn, els)
    | MATCH ->
        next_token p;
        let cond = parse_expr p 0 true in
        expect p LBRACE;
        let arms = parse_match_arms p in
        expect p RBRACE;
        EMatch (cond, arms)
    | LBRACKET ->
        next_token p;
        let elems = if peek p = RBRACKET then [] else parse_separated_list p COMMA (fun p -> parse_expr p 0 false) in
        expect p RBRACKET;
        EArray elems
    | LPAREN ->
        next_token p;
        let e1 = parse_expr p 0 false in
        if consume p COMMA then (
          let rest = parse_separated_nonempty_list p COMMA (fun p -> parse_expr p 0 false) in
          expect p RPAREN;
          ETuple (e1 :: rest)
        ) else (
          expect p RPAREN;
          e1.item
        )
    | TRANSFER ->
        next_token p;
        expect p LPAREN;
        let e = parse_expr p 0 false in
        expect p COMMA;
        let r = parse_ident p in
        expect p RPAREN;
        ETransfer (e, r)
    | SIZEOF ->
        next_token p;
        expect p LT;
        let t = parse_typ p in
        expect p GT;
        expect p LPAREN;
        expect p RPAREN;
        ESizeOf t
    | TYPEOF ->
        next_token p;
        expect p LPAREN;
        let e = parse_expr p 0 false in
        expect p RPAREN;
        ETypeOf e
    | FSTRING_VAL s ->
        next_token p;
        EFormatStr (ref s, ref [])
    | IDENT _ ->
        let path = parse_module_path p in
        (match peek p with
        | LBRACE when not no_struct ->
            next_token p;
            let fields = if peek p = RBRACE then [] else parse_separated_list p COMMA parse_field_init in
            expect p RBRACE;
            EStruct (List.hd (List.rev path), fields, None)
        | LPAREN ->
            next_token p;
            let args = if peek p = RPAREN then [] else parse_separated_list p COMMA (fun p -> parse_expr p 0 false) in
            expect p RPAREN;
            (match path with
            | [id] -> ECall (id, args)
            | _ -> EPathCall (path, args))
        | _ ->
            (match path with
            | [id] -> EVar id
            | _ -> EPathVar path))
    | GENERIC ->
        next_token p;
        expect p LT;
        let args = parse_separated_nonempty_list p COMMA parse_typ in
        expect p GT;
        let inner = parse_expr p 130 no_struct in
        EGenericApp (args, inner)
    | _ -> error p "Expected expression"
  )

and parse_infix p lhs op r_bp no_struct =
  let item =
    match op with
    | PLUS -> EBinOp (lhs, Add, parse_expr p r_bp no_struct)
    | MINUS -> EBinOp (lhs, Sub, parse_expr p r_bp no_struct)
    | STAR -> EBinOp (lhs, Mul, parse_expr p r_bp no_struct)
    | SLASH -> EBinOp (lhs, Div, parse_expr p r_bp no_struct)
    | SHL -> EBinOp (lhs, Shl, parse_expr p r_bp no_struct)
    | SHR -> EBinOp (lhs, Shr, parse_expr p r_bp no_struct)
    | BITAND -> EBinOp (lhs, BitAnd, parse_expr p r_bp no_struct)
    | BITOR -> EBinOp (lhs, BitOr, parse_expr p r_bp no_struct)
    | AND -> EBinOp (lhs, And, parse_expr p r_bp no_struct)
    | OR -> EBinOp (lhs, Or, parse_expr p r_bp no_struct)
    | EQEQ -> EBinOp (lhs, Eq, parse_expr p r_bp no_struct)
    | NEQ -> EBinOp (lhs, Neq, parse_expr p r_bp no_struct)
    | LT -> EBinOp (lhs, Lt, parse_expr p r_bp no_struct)
    | GT -> EBinOp (lhs, Gt, parse_expr p r_bp no_struct)
    | LTE -> EBinOp (lhs, Lte, parse_expr p r_bp no_struct)
    | GTE -> EBinOp (lhs, Gte, parse_expr p r_bp no_struct)
    | AS -> ECast (lhs, parse_typ p)
    | DOT ->
        (match peek p with
        | INT i ->
            next_token p;
            EField (lhs, Int64.to_string i)
        | IDENT id ->
            next_token p;
            if consume p LPAREN then (
              let args = if peek p = RPAREN then [] else parse_separated_list p COMMA (fun p -> parse_expr p 0 false) in
              expect p RPAREN;
              EMethodCall (lhs, id, args, ref None)
            ) else (
              EField (lhs, id)
            )
        | _ -> error p "Expected identifier or integer after '.'")
    | LBRACKET ->
        let idx = parse_expr p 0 false in
        expect p RBRACKET;
        EIndex (lhs, idx)
    | AT ->
        let r = parse_ident p in
        if r = "Comptime" then EComptime lhs else ETransfer (lhs, r)
    | _ -> error p "Unexpected infix operator"
  in
  let end_pos = get_pos p in
  { item; span = combine_span lhs.span end_pos }

and parse_field_init p =
  let name = parse_ident p in
  expect p COLON;
  let e = parse_expr p 0 false in
  (name, e)

and parse_pattern p =
  with_span p (fun start_pos ->
    match peek p with
    | UNDERSCORE -> next_token p; PWildcard
    | INT _ | FLOAT _ | BOOL_VAL _ | STRING_VAL _ | CHAR_VAL _ -> PLit (parse_literal p)
    | LPAREN ->
        next_token p;
        let p1 = parse_pattern p in
        expect p COMMA;
        let rest = parse_separated_nonempty_list p COMMA parse_pattern in
        expect p RPAREN;
        PTuple (p1 :: rest)
    | IDENT _ | OK | ERR ->
        let path = parse_module_path p in
        (match peek p with
        | LPAREN ->
            next_token p;
            let args = if peek p = RPAREN then [] else parse_separated_list p COMMA parse_pattern in
            expect p RPAREN;
            PVariant (List.hd (List.rev path), Some args)
        | _ ->
            if List.length path = 1 then
              match path with
              | ["Ok"] -> PVariant ("Ok", None)
              | ["Err"] -> PVariant ("Err", None)
              | [id] -> PIdent id
              | _ -> assert false
            else
              PVariant (List.hd (List.rev path), None))
    | _ -> error p "Expected pattern"
  )

and parse_match_arms p =
  let rec loop () =
    let pat = parse_pattern p in
    expect p FATARROW;
    let arm_e = parse_expr p 0 false in
    let comma = consume p COMMA in
    let arm = (pat, arm_e) in
    if comma && peek p <> RBRACE then 
      let rest = loop () in
      arm :: rest
    else [arm]
  in
  loop ()

and parse_else_branch p =
  let start_pos = get_pos p in
  let item =
    match peek p with
    | IF ->
        next_token p;
        let cond = parse_expr p 0 true in
        let thn = parse_block p in
        let els = if consume p ELSE then Some (parse_else_branch p) else None in
        let e = EIf (cond, thn, els) in
        { stmts = []; ret_expr = Some { item = e; span = make_span start_pos (get_pos p) } }
    | MATCH ->
        next_token p;
        let cond = parse_expr p 0 true in
        expect p LBRACE;
        let arms = parse_match_arms p in
        expect p RBRACE;
        let e = EMatch (cond, arms) in
        { stmts = []; ret_expr = Some { item = e; span = make_span start_pos (get_pos p) } }
    | LBRACE -> parse_block p
    | _ -> error p "Expected block, if, or match in else branch"
  in
  item

and parse_block p =
  expect p LBRACE;
  if consume p RBRACE then { stmts = []; ret_expr = None }
  else
    let stmts, ret = parse_block_stmts p in
    expect p RBRACE;
    { stmts; ret_expr = ret }

and parse_block_stmts p =
  match peek p with
  | LET | VAR | CONST | RETURN | WHILE | FOR ->
      let s = parse_stmt p in
      if peek p = RBRACE then ([s], None)
      else
        let rest, ret = parse_block_stmts p in
        (s :: rest, ret)
  | _ ->
      let e = parse_expr p 0 false in
      match peek p with
      | SEMICOLON ->
          next_token p;
          let s = { item = SExpr e; span = e.span } in
          if peek p = RBRACE then ([s], None)
          else
            let rest, ret = parse_block_stmts p in
            (s :: rest, ret)
      | EQ ->
          next_token p;
          let rhs = parse_expr p 0 false in
          expect_semi_opt_rbrace p;
          let end_pos = get_pos p in
          let s = { item = SAssign (e, rhs); span = combine_span e.span end_pos } in
          if peek p = RBRACE then ([s], None)
          else
            let rest, ret = parse_block_stmts p in
            (s :: rest, ret)
      | PLUS_EQ ->
          next_token p;
          let rhs = parse_expr p 0 false in
          expect_semi_opt_rbrace p;
          let end_pos = get_pos p in
          let bin = { item = EBinOp (e, Add, rhs); span = combine_span e.span end_pos } in
          let s = { item = SAssign (e, bin); span = combine_span e.span end_pos } in
          if peek p = RBRACE then ([s], None)
          else
            let rest, ret = parse_block_stmts p in
            (s :: rest, ret)
      | MINUS_EQ ->
          next_token p;
          let rhs = parse_expr p 0 false in
          expect_semi_opt_rbrace p;
          let end_pos = get_pos p in
          let bin = { item = EBinOp (e, Sub, rhs); span = combine_span e.span end_pos } in
          let s = { item = SAssign (e, bin); span = combine_span e.span end_pos } in
          if peek p = RBRACE then ([s], None)
          else
            let rest, ret = parse_block_stmts p in
            (s :: rest, ret)
      | STAR_EQ ->
          next_token p;
          let rhs = parse_expr p 0 false in
          expect_semi_opt_rbrace p;
          let end_pos = get_pos p in
          let bin = { item = EBinOp (e, Mul, rhs); span = combine_span e.span end_pos } in
          let s = { item = SAssign (e, bin); span = combine_span e.span end_pos } in
          if peek p = RBRACE then ([s], None)
          else
            let rest, ret = parse_block_stmts p in
            (s :: rest, ret)
      | SLASH_EQ ->
          next_token p;
          let rhs = parse_expr p 0 false in
          expect_semi_opt_rbrace p;
          let end_pos = get_pos p in
          let bin = { item = EBinOp (e, Div, rhs); span = combine_span e.span end_pos } in
          let s = { item = SAssign (e, bin); span = combine_span e.span end_pos } in
          if peek p = RBRACE then ([s], None)
          else
            let rest, ret = parse_block_stmts p in
            (s :: rest, ret)
      | RBRACE -> ([], Some e)
      | _ when (match e.item with EIf _ | EMatch _ -> true | _ -> false) ->
          let _ = consume p SEMICOLON in
          let s = { item = SExpr e; span = e.span } in
          if peek p = RBRACE then ([s], None)
          else
            let rest, ret = parse_block_stmts p in
            (s :: rest, ret)
      | _ -> error p "Expected semicolon, assignment, or closing brace after expression"

and parse_stmt p =
  with_span p (fun start_pos ->
    match peek p with
    | LET | VAR | CONST as k ->
        let kind = match k with LET -> VLet | VAR -> VVar | CONST -> VConst | _ -> assert false in
        next_token p;
        let pat = parse_pattern p in
        let typ = if consume p COLON then Some (parse_typ p) else None in
        expect p EQ;
        let init = parse_expr p 0 false in
        expect_semi_opt_rbrace p;
        SDecl { kind; pat; typ; init }
    | RETURN ->
        next_token p;
        let e = if peek p = SEMICOLON then None else if peek p = RBRACE then None else Some (parse_expr p 0 false) in
        expect_semi_opt_rbrace p;
        SReturn e
    | WHILE ->
        next_token p;
        let cond = parse_expr p 0 true in
        let b = parse_block p in
        SWhile (cond, b)
    | FOR ->
        next_token p;
        let id = parse_ident p in
        expect p IN;
        let e = parse_expr p 0 true in
        let b = parse_block p in
        SFor (id, e, b)
    | _ -> error p "Expected statement"
  )

let parse_visibility p =
  if consume p PUB then true else false

let parse_param p =
  let name = parse_ident p in
  expect p COLON;
  let typ = parse_typ p in
  ({ name; typ } : param)

let parse_field p =
  let name = parse_ident p in
  expect p COLON;
  let typ = parse_typ p in
  ({ name; typ } : field)

let parse_fn_sig p =
  expect p FN;
  let name = parse_ident p in
  expect p LPAREN;
  let params = if peek p = RPAREN then [] else parse_separated_list p COMMA parse_param in
  expect p RPAREN;
  let ret_typ = if consume p MINUS then (expect p GT; Some (parse_typ p)) else None in
  expect p SEMICOLON;
  { name; params; ret_typ }

let parse_enum_member p =
  let name = parse_variant_ident p in
  let payload =
    if consume p LPAREN then (
      let types = if peek p = RPAREN then [] else parse_separated_list p COMMA parse_typ in
      expect p RPAREN;
      types
    ) else []
  in
  let override =
    if consume p AT_EQ then Some (IotaOverride, parse_expr p 0 false)
    else if consume p DOLLAR_EQ then Some (ValueOverride, parse_expr p 0 false)
    else None
  in
  { name; payload; override; computed_val = ref None }

let rec parse_item p =
  with_span p (fun start_pos ->
    match peek p with
    | PUB | FN | EXTERN | ENUM | STRUCT | TRAIT | IMPL | GLOBAL | ROLE | MOD | GENERIC ->
        let is_pub = parse_visibility p in
        (match peek p with
        | EXTERN ->
            next_token p;
            let abi = match peek p with
              | STRING_VAL s -> next_token p; Some s
              | _ -> None
            in
            expect p FN;
            let name = parse_ident p in
            expect p LPAREN;
            let params = if peek p = RPAREN then [] else parse_separated_list p COMMA parse_param in
            expect p RPAREN;
            let role = if consume p AT then Some (parse_ident p) else None in
            let ret_typ = if consume p MINUS then (expect p GT; Some (parse_typ p)) else None in
            expect p SEMICOLON;
            IFn { is_pub; name; params; ret_typ; role; is_extern = true; abi; body = None }
        | FN ->
            next_token p;
            let name = parse_ident p in
            expect p LPAREN;
            let params = if peek p = RPAREN then [] else parse_separated_list p COMMA parse_param in
            expect p RPAREN;
            let role = if consume p AT then Some (parse_ident p) else None in
            let ret_typ = if consume p MINUS then (expect p GT; Some (parse_typ p)) else None in
            let body = parse_block p in
            IFn { is_pub; name; params; ret_typ; role; is_extern = false; abi = None; body = Some body }
        | ENUM ->
            next_token p;
            let name = parse_ident p in
            let base_typ, iota_expr =
              if consume p COLON then
                let t = parse_base_type p in
                if consume p LPAREN then
                  let e = parse_expr p 0 false in
                  expect p RPAREN;
                  (t, e)
                else
                  (t, { item = EVar "iota"; span = make_span (get_pos p) (get_pos p) })
              else if consume p LPAREN then
                let e = parse_expr p 0 false in
                expect p RPAREN;
                (TU32, e)
              else
                (TU32, { item = EVar "iota"; span = make_span (get_pos p) (get_pos p) })
            in
            expect p LBRACE;
            let members = if peek p = RBRACE then [] else parse_separated_list p COMMA parse_enum_member in
            expect p RBRACE;
            IEnum { is_pub; name; base_typ; iota_expr; members }
        | STRUCT ->
            next_token p;
            let name = parse_ident p in
            expect p LBRACE;
            let fields = if peek p = RBRACE then [] else parse_separated_list p COMMA parse_field in
            expect p RBRACE;
            IStruct { is_pub; name; fields }
        | TRAIT ->
            next_token p;
            let name = parse_ident p in
            expect p LBRACE;
            let rec parse_methods () =
              if peek p = RBRACE then []
              else (
                let first = parse_fn_sig p in
                first :: parse_methods ()
              )
            in
            let methods = parse_methods () in
            expect p RBRACE;
            ITrait { is_pub; name; methods }
        | IMPL ->
            next_token p;
            let trait_name = parse_ident p in
            expect p FOR;
            let for_typ = parse_typ p in
            expect p LBRACE;
            let rec parse_impl_methods () =
              if peek p = RBRACE then []
              else (
                match parse_item p with
                | { item = IFn f; _ } -> f :: parse_impl_methods ()
                | _ -> error p "Expected function in impl block"
              )
            in
            let methods = parse_impl_methods () in
            expect p RBRACE;
            IImpl { trait_name; for_typ; methods }
        | GLOBAL ->
            next_token p;
            let name = parse_ident p in
            expect p COLON;
            let typ = parse_typ p in
            expect p EQ;
            let init = parse_expr p 0 false in
            expect p SEMICOLON;
            IGlobal { is_pub; name; typ; init }
        | ROLE ->
            next_token p;
            expect p AT;
            let name = parse_ident p in
            let properties =
              if consume p LBRACE then (
                let props = if peek p = RBRACE then [] else parse_separated_list p COMMA parse_field_init in
                expect p RBRACE;
                props
              ) else (
                expect p SEMICOLON;
                []
              )
            in
            IRole { name; properties }
        | MOD ->
            next_token p;
            let name = parse_ident p in
            expect p SEMICOLON;
            IMod { is_pub; name }
        | GENERIC ->
            next_token p;
            expect p LT;
            let params = parse_separated_nonempty_list p COMMA parse_ident in
            expect p GT;
            let i = parse_item p in
            IGeneric (params, i)
        | _ -> error p "Expected item declaration")
    | _ -> error p "Expected item declaration"
  )

let parse_import_decl p =
  let start_pos = get_pos p in
  expect p IMPORT;
  let path = parse_module_path p in
  let alias = if consume p AS then Some (parse_ident p) else None in
  expect p SEMICOLON;
  let end_pos = get_pos p in
  { path; alias; span = make_span start_pos end_pos }

let parse_program lexer lexbuf =
  let p = init_state lexer lexbuf in
  let rec parse_imports () =
    if peek p = IMPORT then let first = parse_import_decl p in first :: parse_imports ()
    else []
  in
  let imports = parse_imports () in
  let rec parse_items () =
    if peek p = EOF then []
    else let first = parse_item p in first :: parse_items ()
  in
  let items = parse_items () in
  expect p EOF;
  { imports; items }

let parse_standalone_expr lexer lexbuf =
  let p = init_state lexer lexbuf in
  let e = parse_expr p 0 false in
  expect p EOF;
  e
