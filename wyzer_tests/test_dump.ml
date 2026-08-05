let () =
  let inx = open_in "wyzer_tests/test_num.wyz" in
  let lexbuf = Lexing.from_channel inx in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = "wyzer_tests/test_num.wyz" };
  let prog = Wyzer_lib.Parser.parse_program Wyzer_lib.Lexer.read lexbuf in
  close_in inx;
  print_endline (Wyzer_lib.Ast.show_program prog)
