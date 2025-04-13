# The Wyzer Programming Language
![WYZERLANG](https://github.com/Wyzer-Lang/.github/blob/main/Group%20187.svg)

Wyzer is a general purpose, statically typed object oriented programming language

## Motive behind creating Wyzer
The language is still under development and my motive was to create something easy to code with thats machine level unlike C/C++ and Rust , Wyzer targets simplicity and productivity with having interoperability with C/C++ libs

"Geniuses admire simplicity, Idiots admire complexity" ~ Terry A Davis
 
---

## TODO

PHASE 1: CORE INFRASTRUCTURE
----------------------------

Lexer:
- [x] Tokenize keywords: fnc, return, loop, etc.
- [x] Recognize symbols: +, -, *, /, :, ->, {}, (), etc.
- [x] Handle string and number literals
- [x] Skip whitespace and comments
- [x] Subtype matching (e.g., TokenType::KEYWORD + value check)

Parser:
- [x] Function declarations: fnc name(...) -> type { ... }
- [x] Return statements: return expr;
- [x] log(expr); and logln(expr);
- [x] loop { ... }
- [x] Binary expressions: "a" + b;
- [ ] Variable declarations: let x = 5;
- [ ] Assignments: x = x + 1;
- [ ] If-expressions/statements
- [ ] Block expressions: let x = { if (...) { ... } };
- [ ] Structs/classes (optional)

PHASE 2: AST DEFINITION
-----------------------

- [x] FunctionDecl
- [x] ReturnStmt
- [x] PrintStmt
- [x] LoopStmt
- [x] BinaryExpr
- [x] LiteralExpr
- [x] VariableExpr
- [ ] LetStmt
- [ ] AssignExpr
- [ ] IfStmt
- [ ] BlockExpr
- [ ] Type metadata / annotations

PHASE 3: SEMANTIC ANALYSIS
--------------------------

- [ ] Check types (return types, ops)
- [ ] Validate function parameters
- [ ] Check for missing return
- [ ] Ensure main() exists
- [ ] Validate variable usage (declared before use)
- [ ] Add scoping and symbol table
- [ ] No duplicate function names

PHASE 4: INTERPRETER
-------------------------------

- [ ] Evaluate return & binary expressions
- [ ] Execute loops and blocks
- [ ] Handle log/logln
- [ ] Maintain runtime variable scope
- [ ] Call user-defined functions

PHASE 5: COMPILER (USING LLVM IR)
----------------------------

- [ ] Generate intermediate representation (IR)
- [ ] Output assembly or bytecode
- [ ] Optimizations (constant folding, etc.)
