open Printf
open Wyzer_lib

(** Convert a Lexing position to a Diagnostic span. *)
let lex_span lexbuf =
  let pos = lexbuf.Lexing.lex_curr_p in
  Ast.{
    file       = pos.pos_fname;
    start_line = pos.pos_lnum;
    start_col  = pos.pos_cnum - pos.pos_bol + 1;
    end_line   = pos.pos_lnum;
    end_col    = pos.pos_cnum - pos.pos_bol + 2;
  }

let parse_with_error lexbuf =
  try Parser.parse_program Lexer.read lexbuf
  with
  | Lexer.SyntaxError msg ->
      Diagnostic.(emit (make_error
        ~code:Error_codes.syntax_error
        ~label:msg
        "syntax error"
        (lex_span lexbuf)));
      exit 1
  | Diagnostic.LocatedError d ->
      Diagnostic.emit d;
      exit 1
  | Parser.Error ->
      (* Bare parser.Error (menhir) — no span info *)
      Diagnostic.emit_plain_error "unexpected parse error";
      exit 1

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
    | None   -> prog_comptime
    in
    let prog_transformed = Perceus.transform_program prog_to_run in

    let command = if Array.length Sys.argv > 1 then Sys.argv.(1) else "run" in
    if command = "build" then (
      let role = Option.value !target_role_opt ~default:"Poly" in
      let llvm_module = Codegen.generate_llvm prog_transformed role in
      let base_name = Filename.remove_extension (Filename.basename filename) in
      let out_ll  = sprintf "%s_%s.ll"  base_name role in
      let out_bin = sprintf "%s_%s"     base_name role in

      Llvm.print_module out_ll llvm_module;

      printf "Generated %s. Compiling...\n" out_ll;
      let clang_cmd = sprintf "clang -O3 %s lib/wyzer_runtime.c -lm -o %s" out_ll out_bin in
      let status = Sys.command clang_cmd in
      if status = 0 then
        printf "Successfully built %s\n" out_bin
      else
        fprintf stderr "Error: clang compilation failed\n"
    ) else (
      Eval.eval_program project_root prog_transformed
        (Option.value !target_role_opt ~default:"Poly")
    )
  with
  (* Rich located errors from typechecker / parser *)
  | Diagnostic.LocatedError d ->
      Diagnostic.emit d;
      exit 1
  (* Legacy plain TypeError (sites not yet migrated) *)
  | Typechecker.TypeError msg ->
      Diagnostic.(emit (make_error
        ~code:Error_codes.type_error
        ~label:"type error here"
        msg
        Ast.dummy_span));
      exit 1
  (* Runtime errors *)
  | Eval.EvalError msg ->
      Diagnostic.(emit (make_error
        ~code:Error_codes.runtime_error
        ~label:"runtime error occurred"
        msg
        Ast.dummy_span));
      exit 1

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
