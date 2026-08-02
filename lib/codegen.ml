open Ast

exception CodegenError of string

(* Wyzer LLVM Codegen Stub
   Native LLVM code generation requires the OCaml 'llvm' package and system headers 
   (libzstd-dev, llvm-19-dev). When installed, full LLVM IR generation is enabled.
   Interpreted execution via 'wyzerc run' is fully supported out of the box. *)

let generate_llvm (_prog : program) (_role : string) : unit =
  raise (CodegenError "LLVM codegen requires OCaml 'llvm' package (install via 'sudo apt install libzstd-dev llvm-19-dev && opam install llvm'). Use 'wyzerc run' to execute Wyzer programs.")
