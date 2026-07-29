(lang dune 3.10)
(name wyzer)
(generate_opam_files true)
(using menhir 2.1)

(source
 (github Wyzer-Lang/wyzer))

(authors "Atiksh Sharma")
(maintainers "Atiksh Sharma")
(license MIT)

(package
 (name wyzer)
 (synopsis "The Wyzer Programming Language Compiler")
 (description "Wyzer is a statically typed, compiled, resource-oriented programming language with integrated distributed safety via choreographic programming and a perceus memory model.")
 (depends
  (ocaml (>= 4.14.0))
  (dune (>= 3.10))
  (menhir (>= 20230608))
  (ppx_deriving (>= 5.2.1))))
