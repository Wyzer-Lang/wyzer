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
  
  let project_root = Filename.dirname filename in
  try
    let _ = Typechecker.check_program project_root prog in
    let prog_comptime = Comptime.transform_program project_root prog in
    let target_role_opt = ref None in
    let filename_idx = ref 1 in
    for i = 1 to Array.length Sys.argv - 1 do
      if Sys.argv.(i) = "--role" && i + 1 < Array.length Sys.argv then (
        target_role_opt := Some Sys.argv.(i+1);
      ) else if Sys.argv.(i) <> "--role" && (i = 1 || Sys.argv.(i-1) <> "--role") then (
        filename_idx := i
      )
    done;
    let prog_to_run = match !target_role_opt with
    | Some r -> Projection.project_program prog_comptime r
    | None -> prog_comptime
    in
    let prog_transformed = Perceus.transform_program prog_to_run in
    
    let command = if Array.length Sys.argv > 1 then Sys.argv.(1) else "run" in
    if command = "build" then (
      let role = Option.value !target_role_opt ~default:"Poly" in
      let c_code = Codegen.generate_c prog_transformed role in
      let base_name = Filename.remove_extension (Filename.basename filename) in
      let out_c = sprintf "%s_%s.c" base_name role in
      let out_bin = sprintf "%s_%s" base_name role in
      
      let oc = open_out out_c in
      fprintf oc "%s\n" c_code;
      close_out oc;
      
      printf "Generated %s. Compiling...\n" out_c;
      let gcc_cmd = sprintf "gcc -O3 %s -o %s" out_c out_bin in
      let status = Sys.command gcc_cmd in
      if status = 0 then
        printf "Successfully built %s\n" out_bin
      else
        fprintf stderr "Error: gcc compilation failed\n"
    ) else (
      Eval.eval_program project_root prog_transformed (Option.value !target_role_opt ~default:"Poly")
    )
  with
  | Typechecker.TypeError msg ->
      fprintf stderr "Type Error: %s\n" msg;
      exit (-1)
  | Eval.EvalError msg ->
      fprintf stderr "Runtime Error: %s\n" msg;
      exit (-1)

let () =
  if Array.length Sys.argv < 3 then (
    fprintf stderr "Usage: %s <run|build> <file.wyz> [--role <RoleName>]\n" Sys.argv.(0);
    exit 1
  );
  let command = Sys.argv.(1) in
  if command <> "run" && command <> "build" then (
    fprintf stderr "Unknown command: %s\n" command;
    exit 1
  );
  let filename = ref "" in
  for i = 2 to Array.length Sys.argv - 1 do
    if Sys.argv.(i) <> "--role" && (i = 2 || Sys.argv.(i-1) <> "--role") then
      filename := Sys.argv.(i)
  done;
  if !filename = "" then (
    fprintf stderr "Usage: %s <run|build> <file.wyz> [--role <RoleName>]\n" Sys.argv.(0);
    exit 1
  );
  process_file !filename
