# The Wyzer Language Specification: v0.1 (Draft)

**Status: early draft.** This document uses math notation for typing rules and grammar. Sections are marked as one of:

- **[SETTLED]**: The rule is finished and stable.
- **[DRAFT]**: We have a working rule but need to test it more.
- **[OPEN]**: We still need to solve this problem.

We mark these clearly so everyone knows what is finished and what is not.

---

## 0. Notation Rules

- `Γ ⊢ e : τ`: In context `Γ`, expression `e` has type `τ`.
- `Γ = Γ_u, Γ_l`: A context is split into an **unrestricted** part (`Γ_u`, normal values used many times) and a **linear** part (`Γ_l`, resources used exactly once). This is how Wyzer handles resources.
- `e → e'`: Expression `e` turns into `e'` in one step.
- `x ∉ dom(Γ)`: `x` is not yet defined in `Γ`.
- Rules are written with the conditions on top and the result on the bottom:

```
   Γ ⊢ e1 : τ1 → τ2      Γ ⊢ e2 : τ1
   ---------------------------------- (T-App)
           Γ ⊢ e1 e2 : τ2
```

---

## 1. Code Rules **[SETTLED]**

- Code uses UTF-8.
- Names: Variables and functions start with lowercase letters. Types and enums start with uppercase letters.
- Comments: Use `//` for comments.
- Numbers: Always state the size of numbers clearly, like `u8`, `u32`, `i64`.

---

## 2. Basic Grammar **[DRAFT]**

This grammar covers the main code and types. We explain choreography and interrupt handlers in Sections 6 and 7.

```ebnf
program     ::= import_decl* item*
item        ::= fn_decl | enum_decl | type_decl

import_decl ::= "import" module_path ("as" ident)? ";"
module_path ::= ident ("::" ident)*        (* e.g. std::io *)

fn_decl     ::= "fn" ident "(" param_list? ")" "->" type block
param_list  ::= param ("," param)*
param       ::= ident ":" type

type        ::= base_type
              | base_type "@" role        (* resource tied to a specific role *)
              | "Result" "<" type "," type ">"

base_type   ::= "u8" | "u16" | "u32" | "u64"
              | "i8" | "i16" | "i32" | "i64"
              | "bool" | "str"
              | ident                     (* user-defined enum or struct name *)

role        ::= ident

block       ::= "{" stmt* expr? "}"
stmt        ::= let_stmt | assign_stmt | expr ";" | if_stmt | while_stmt | for_stmt
let_stmt    ::= "let" "mut"? ident (":" type)? "=" expr ";"
assign_stmt ::= ident "=" expr ";"          (* only allowed if defined with `let mut` *)

if_stmt     ::= "if" expr block ("else" (if_stmt | block))?
while_stmt  ::= "while" expr block
for_stmt    ::= "for" ident "in" expr block

expr        ::= literal | ident | call | match_expr | binop_expr | path_call
call        ::= ident "(" arg_list? ")"
path_call   ::= module_path "(" arg_list? ")"   (* e.g. io::println(...) *)
arg_list    ::= expr ("," expr)*
binop_expr  ::= expr binop expr
binop       ::= "+" | "-" | "*" | "/" | "<<" | ">>" | "&" | "|"
              | "==" | "!=" | "<" | ">" | "<=" | ">="

match_expr  ::= "match" expr "{" match_arm+ "}"
match_arm   ::= pattern "=>" expr ","
pattern     ::= ident | ident "(" pattern_list? ")"
```

---

## 3. Core Type System **[DRAFT]**

### 3.1 Type Rules and Splitting Context

```
   x : τ ∈ Γ_u
   ------------- (T-Var-Unr)
   Γ ⊢ x : τ

   x : τ ∈ Γ_l
   ------------------------------- (T-Var-Lin)
   Γ_u, (x:τ) ⊢ x : τ  ⊣  Γ_u, ∅
```

`T-Var-Lin` means that when you use a linear variable, it is removed from the context. It can no longer be used. This guarantees it is used exactly once. We use this same idea for checking memory, roles, and interrupt safety. **This is the main rule that makes Wyzer safe.**

### 3.2 Using Functions

```
   Γ1 ⊢ e1 : τ1 → τ2 ⊣ Γ1'      Γ1' ⊢ e2 : τ1 ⊣ Γ2
   ------------------------------------------------- (T-App)
              Γ1 ⊢ e1 e2 : τ2 ⊣ Γ2
```

### 3.3 Current Status

Rules for basic things like numbers, math, and `let` use standard ideas. They are **[SETTLED]** and will be written down later.

---

## 4. How Code Runs **[DRAFT]**

Standard execution rules:

```
   e1 → e1'
   -------------------- (E-App1)
   e1 e2 → e1' e2

   e2 → e2'
   -------------------- (E-App2)
   v1 e2 → v1 e2'

   ------------------------------------ (E-AppAbs)
   (fn x -> e) v → e[x := v]
```

These are standard rules. The details of how memory changes are in Section 5.

---

## 5. Memory Model **[DRAFT: partial]**

### 5.1 What we have written down

Perceus is a way for the compiler to manage memory. You don't have to write special types in your code. The compiler figures out if a value is unique. Here we only show the basic rule the compiler must follow.

### 5.2 The Safety Rule **[DRAFT]**

```
   Γ ⊢ e : τ ⊣ ∅        (e consumes all its linear resources)
   uniq(x, e)             (x is the last live reference to its value at this point)
   -----------------------------------------------------------------------------
   compile(let x' = update(x, ...)) ⤳ in-place mutation of x's memory cell
```

`uniq(x, e)` means the compiler knows `x` is the only reference to a memory spot. If it is unique, the compiler can change the memory directly instead of copying it.

### 5.3 Backup Rule **[SETTLED: as a plan, not a final model]**

```
   ¬uniq(x, e)
   --------------------------------------------------
   compile(update(x, ...)) ⤳ runtime refcount check + copy-on-write if count > 1
```

### 5.4 Open Tasks

- We need to figure out exactly when the compiler can prove uniqueness and when it must fall back to checking while running. This is marked as **[OPEN]**.

---

## 6. Distributed Rules **[DRAFT]**

### 6.1 Global Grammar

```
G ::= ρ -> ρ' : v . G
    | ρ' -> ρ : x . G
    | ρ does f(x) . G
    | end
```

### 6.2 Role Types

A value of type `τ@ρ` is owned by role `ρ`. Sending it consumes it:

```
   Γ_u, (x : τ@ρ) ⊢ x : τ@ρ ⊣ Γ_u, ∅        (send consumes it)
   -----------------------------------------------------------------------------
   ρ -> ρ' : x   typechecks only if x : τ@ρ was live and is now removed from Γ
```

We do not need a special keyword for this. Sending a value just uses the normal resource rules. The compiler figures out the global plan automatically.

### 6.3 Splitting the Plan **[OPEN]**

The compiler must split the global plan `G` into code for each specific role `ρ`. This is standard for simple cases. But Wyzer needs to do this for plans it figures out on its own, and for parts that can be interrupted. We have not written the rules for this yet.

### 6.4 Native vs. External Roles **[DRAFT]**

**Motivation.** Ada tried something similar, but almost nobody used it. This is because Ada forced every part of the network to be written in Ada. If a feature only works when everyone uses the same language, few people will use it. Wyzer must not make this mistake.

**Design.** Roles are split into two kinds:

```
role ::= Native(ρ)      // compiled Wyzer code; compiler controls and verifies both sides
       | External(ρ, C) // implemented in any language; C is a declared protocol contract
```

For Native to Native talks, both sides are checked by the compiler. It is completely safe.

For talks with External roles, the safety is different. The Wyzer side is fully checked. The External side is only safe if it actually follows the contract:

```
   Γ_u, (x : τ@Native(ρ)) ⊢ x : τ@Native(ρ) ⊣ Γ_u, ∅
   conforms(τ, C)                                        (* τ matches the declared contract C *)
   -----------------------------------------------------------------------------------------
   Native(ρ) -> External(ρ', C) : x   typechecks; Wyzer side is verified.
```

The compiler creates a contract file that other languages can read. This lets Wyzer talk to services written in any language.

**Open Tasks:**
- What format should the contract use? **[OPEN]**
- How exactly do we check if types match the contract? **[OPEN]**
- Since we don't control External roles, should we treat them like untrusted code instead of scripts? **[OPEN]**

---

## 7. Interrupt Safety **[DRAFT: basic rule only; stop and restart is OPEN]**

### 7.1 Types of Participants

```
Participant ::= Scripted(ρ)       (* follows a local sequence *)
              | Interrupting(H)   (* runs between instructions *)
```

### 7.2 Safety Rule (Working Draft)

```
   ownership_at(S, n) = O_n            (* resources S holds at instruction boundary n *)
   requires(H) = R_H                   (* resources handler H needs *)
   ∀ n reachable in proj(G, S):  O_n ∩ R_H = ∅   ∨   explicit_transfer(O_n, R_H, n)
   ------------------------------------------------------------------------------------
   install(H) is sound over Scripted(S) running proj(G, S)
```

We check what resources the script has at each step. This uses the same rules as before.

### 7.3 Open Problem: Stopping and Restarting **[OPEN]**

The rule above works if the interrupt gives control back exactly where it stopped. It does **not** work if the interrupt needs to cancel the current step and restart it later. We are still researching this.

---

## 8. Enums **[SETTLED]**

### 8.1 Grammar

```ebnf
enum_decl   ::= "enum" ident ":" base_type "(" iota_expr ")" "{" enum_body "}"
iota_expr   ::= expr                (* must reference `iota`; must be const-evaluable *)
enum_body   ::= enum_member ("," enum_member)*
enum_member ::= ident ("=" const_expr)?
const_expr  ::= expr                (* may reference `prev`; must be const-evaluable *)
```

The `(iota_expr)` part is required. You cannot write a plain `enum Foo: u8 { ... }`. We want only one way to define enums.

### 8.2 Meaning

For the `n`-th item in an enum with math rule `E`:

```
   value(member_n) = E[iota := n]                     if member_n has no explicit "= const_expr"
   value(member_n) = eval(const_expr[prev := value(member_{n-1})])   if member_n has "= const_expr"
```

The `iota` value is always its exact position. It does not care about what values came before it. If you want to use the previous value, you must use `prev`.

### 8.3 Design Choices

- Required `(iota_expr)`: Prevents having two ways to do the same thing.
- Positional `iota`: Keeps `iota` simple to calculate by just counting.
- Explicit `prev`: Allows using the last value clearly without making `iota` confusing.

### 8.4 Example

```
enum Baz: u32 (iota * 2) {
    Var1,        // iota=0 : 0
    Var2,        // iota=1 : 2
    Var3,        // iota=2 : 4
    Var4 = 12,   // explicit : 12
    Var5,        // iota=4 : 8   (NOT 26, iota did not inherit from Var4's override)
    Var6,        // iota=5 : 10
};
```

If you want to continue from 12, you must write it out:

```
enum Baz2: u32 (iota * 2) {
    Var1, Var2, Var3,
    Var4 = 12,
    Var5 = prev + 2,   // : 14
    Var6 = prev + 2,   // : 16
};
```

---

## 9. Error Handling **[SETTLED: policy, DRAFT: rule]**

```
type Result<T, E> = Ok(T) | Err(E)
```

We use standard rules with `match`. There are no hidden exceptions. This is the simplest choice for now.

---

## 10. Modules and Imports **[DRAFT]**

### 10.1 Design

Wyzer uses clear, path-based modules. There are no header files and no hidden global names. You must use the full path to an outside name unless you import it.

```
import std::io;
import std::collections as coll;

fn main() -> Result<u8, str> {
    io::println("hello, wyzer");
    ...
}
```

### 10.2 Meaning

```
   import_decl = "import" P ("as" α)?
   -----------------------------------------------------------------
   binds P (or alias α if given) as a resolvable module prefix in scope
```

Calling `P::f(args)` checks the types just like a normal function. The only difference is that the compiler looks in module `P` for the function. Imports only help find names; they do not change the typing rules.

### 10.3 Open Question **[OPEN]**

We do not know yet if role types like `τ@ρ` can be shared between modules. This is marked for Section 16.

---

## 11. Functions **[SETTLED: syntax, DRAFT: typing]**

### 11.1 Declaration

Functions are written with `fn`, full parameter types, and a return type. We require this so you can read what a function does without looking at its code.

```
fn add(a: u32, b: u32) -> u32 {
    a + b
}
```

The last value in a block is what the block returns. You do not need a `return` keyword at the end. We plan to add a `return` keyword for exiting early, but we still need to figure out how that affects linear resources. Exiting early cannot leave unconsumed resources behind **[OPEN]**.

### 11.2 Type Rule

```
   Γ, (a1:τ1), ..., (an:τn) ⊢ body : τr ⊣ ∅
   ------------------------------------------------- (T-Fn)
   Γ ⊢ fn(a1:τ1, ..., an:τn) -> τr { body } : (τ1,...,τn) → τr
```

The `⊣ ∅` part is very important. It means the function **must use every linear resource it receives**. Leaving a resource unused is an error. This stops values from being dropped by mistake.

---

## 12. Control Flow **[DRAFT]**

### 12.1 If Statements

```
   Γ ⊢ e_cond : bool ⊣ Γ'      Γ' ⊢ e_then : τ ⊣ Γ''      Γ' ⊢ e_else : τ ⊣ Γ''
   ---------------------------------------------------------------------------- (T-If)
   Γ ⊢ if e_cond { e_then } else { e_else } : τ ⊣ Γ''
```

Both the `if` and `else` blocks must use the exact same linear resources. This stops a resource from being used in one block but forgotten in the other. An `if` statement without an `else` is only allowed if no linear resources are used.

### 12.2 Loops **[OPEN: affects resources]**

```ebnf
while_stmt ::= "while" expr block
for_stmt   ::= "for" ident "in" expr block
```

Loops cause a big problem for resources. A loop body cannot use a linear resource from outside because the loop might run zero or many times. We cannot guarantee it is used exactly once. For now, our rule is: **loops cannot use linear resources at all**. If you need to loop over linear resources, you must use recursion. We need to find a better solution.

---

## 13. Variables and Mutability **[DRAFT]**

### 13.1 Design

Variables made with `let` cannot be changed. You must use `let mut` if you want to change them later.

```
let x: u32 = 5;        // immutable
let mut y: u32 = 0;    // mutable
y = y + 1;              // legal — y was declared `mut`
x = 6;                  // compile error — x was not declared `mut`
```

### 13.2 Mixing Variables and Resources **[OPEN]**

Right now, you can mix changeable (`mut`) variables with one-time use (linear) resources. But we are not sure if this makes sense. The compiler already changes linear resources safely in memory (see Section 5). Adding `mut` on top of this might cause conflicts. We need to research this.

---

## 14. Input and Output **[DRAFT]**

### 14.1 Printing

```
import std::io;

fn main() -> Result<u8, str> {
    io::println("hello, wyzer");
    io::print("no newline here");
    Ok(0)
}
```

`io::println` and `io::print` are normal functions in the `std::io` module. Their types look like:

```
fn println(s: str) -> unit
fn print(s: str) -> unit
```

### 14.2 Open Question: Security and I/O **[OPEN]**

Currently, anyone can import `std::io` and print things. This is simple, but it makes running untrusted code dangerous. We have not decided if printing should require a special permission or role type.

---

## 15. Green Threads **[OPEN]**

We plan to use green threads. Each thread acts as a basic participant (Section 7.1). Threads yield control willingly. We have not written the rules for this yet, but it should be easier than handling random interrupts.

---

## 16. Summary of Open Tasks

1. **Section 7.3**: Rules for stopping and restarting interrupts.
2. **Section 6.3**: Splitting the global plan for each role automatically.
3. **Section 12.2**: Rules for using resources inside loops.
4. **Section 15**: Writing the rules for green threads.
5. **Section 13.2**: How `mut` works with the memory model.
6. **Section 11.1**: How early `return` handles resources.
7. **Section 14.2**: Security rules for I/O like printing.
8. **Section 5.4**: Knowing when the compiler can prove uniqueness.
9. **Section 10.3**: Checking if role types can cross module boundaries.
10. **Section 6.4**: Making contracts for External roles and treating them safely.
11. **Section 3.3**: Writing down the basic type rules.

---

*This document will change over time. Sections marked [OPEN] are the unsolved problems. Check the Contributor Guide to see how you can help.*