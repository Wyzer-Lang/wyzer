# The Wyzer Programming Language
![WYZERLANG](https://github.com/Wyzer-Lang/.github/blob/main/Group%20187.svg)

Wyzer is a general purpose, statically typed object oriented programming language

## Motive behind creating Wyzer
The language is still under development and my motive was to create something easy to code with thats machine level unlike C/C++ and Rust , Wyzer targets simplicity and productivity with having interoperability with C/C++ libs

"Geniuses admire simplicity, Idiots admire complexity" ~ Terry A Davis
 
---

### Compiling and testing the language with G++
I have not implemented CMake or Makefile to the project yet that may count as a TODO too , Compiling and testing of Wyzer requires

- G++ 14.2+
- C++ 23

Command to execute:
```
g++ -std=c++23 main.cpp COMANCHE/lexer/lexer.cpp COMANCHE/parser/parser.cpp COMANCHE/parser/ast_prt.cpp COMANCHE/parser/interpreter.cpp -o wuz
```
**Note**: Wuz will be the package manager for Wyzer like Rust has Cargo and python has pip.

## Basic Usage
Contains the example codes of wyzer

Hello world
```wyzer
fnc main() {
    logln("Hello world");
} // or

fnc main() {
    log("Hello world");
}
```
Return binary expressions
```
fnc main() -> int {
    return 2 + 3;
}
```
Print Computed results
```
fnc main() {
    logln("Result is:");
    log(5 + 7);
}
```
Simple parameterized function and return
```
fnc add(a: int, b: int) -> int {
    return a + b;
}

fnc main() {
    logln("Sum:");
    log(add(10, 15));
}
```
Loop with binary ops
```
fnc main() {
    loop {
        logln("This is a loop with a binary op: ");
        log("Hello " + "world");
    }
}
```

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
- [x] Variable declarations: let x = 5;
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
- [x] LetStmt
- [ ] AssignExpr
- [ ] IfStmt
- [ ] BlockExpr
- [ ] Type metadata / annotations

PHASE 3: SEMANTIC ANALYSIS
--------------------------

- [ ] Check types (return types, ops)
- [ ] Validate function parameters
- [ ] Check for missing return
- [x] Ensure main() exists
- [ ] Validate variable usage (declared before use)
- [ ] Add scoping and symbol table
- [ ] No duplicate function names

PHASE 4: INTERPRETER
-------------------------------

- [x] Evaluate return & binary expressions
- [x] Execute loops and blocks
- [x] Handle log/logln
- [ ] Maintain runtime variable scope
- [ ] Call user-defined functions

PHASE 5: COMPILER (USING LLVM IR)
----------------------------

- [ ] Generate intermediate representation (IR)
- [ ] Output assembly or bytecode
- [ ] Optimizations (constant folding, etc.)

