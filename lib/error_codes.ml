(* Type system *)
let var_consumed          = "E001"
let type_mismatch_decl    = "E002"
let binop_type_mismatch   = "E003"
let if_branch_mismatch    = "E004"
let return_type_mismatch  = "E005"
let role_mismatch         = "E006"
let arity_mismatch        = "E007"
let undefined_variable    = "E008"
let undefined_function    = "E009"
let non_exhaustive_match  = "E010"
let type_error            = "E011"   (* generic fallback *)

(* Parse / syntax *)
let syntax_error          = "E100"
let unexpected_token      = "E101"
let unexpected_eof        = "E102"

(* Runtime *)
let runtime_error         = "E200"

(* Codegen *)
let codegen_error         = "E300"
