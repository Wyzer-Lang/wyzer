open Printf
open Wyzer_lib

let print_position outx lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  try Parser.program Lexer.read lexbuf with
  | Lexer.SyntaxError msg ->
      fprintf stderr "%a: %s\n" print_position lexbuf msg;
      exit (-1)
  | Parser.Error ->
      fprintf stderr "%a: syntax error at '%s'\n" print_position lexbuf (Lexing.lexeme lexbuf);
      exit (-1)

let process_file filename =
  let inx = open_in filename in
  let lexbuf = Lexing.from_channel inx in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
  let prog = parse_with_error lexbuf in
  close_in inx;
  
  try
    let _ = Typechecker.check_program prog in
    let prog_transformed = Perceus.transform_program prog in
    Eval.eval_program prog_transformed
  with
  | Typechecker.TypeError msg ->
      fprintf stderr "Type Error: %s\n" msg;
      exit (-1)
  | Eval.EvalError msg ->
      fprintf stderr "Runtime Error: %s\n" msg;
      exit (-1)

let () =
  if Array.length Sys.argv < 2 then (
    fprintf stderr "Usage: %s <file.wyz>\n" Sys.argv.(0);
    exit 1
  ) else
    process_file Sys.argv.(1)
