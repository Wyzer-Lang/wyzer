# The Wyzer Programming Language
![WYZERLANG](https://github.com/Wyzer-Lang/.github/blob/main/Group%20187.svg)

> "Simplicity is not the absence of power. It is power without pretense."
                                                                ~ Atiksh Sharma (Me)

Feel free to use the prentensious quote anywhere lol.

---
Wyzer is a General purpose, statically typed programming language with no runtime or a garbage collector, built for people who are tired of cognitive overhead, excessive syntax, and unpredictable compiler behavior. It’s for those who want to write programs, and not argue with it.

## Motive behind Wyzer
Modern systems languages suffer from two extremes:
take C++ it's basically a swamp of legacy, inconsistent idioms, and accidental complexity
lets also take Rust which over-engineers simplicity into submission, burying clarity under lifetime puzzles and trait gymnastics

and Wyzer refuses both paths 

---

# Core Design Principles

- ## Clarity over cleverness
   - Code should be read more than it's written. Wyzer discourages syntax that hides what’s really happening just like [Zig](https://ziglang.org/)
- ## One idiomatic way
   - There are no 7 styles of iteration, 5 forms of function pointers, or 6 kinds of inheritance. One clear path to do things.
- ## No hidden control flow
    - Macros, `drop`, implicit lifetimes all of that’s explicit or opt-in. If your code jumps, returns, or allocates, you’ll see it.
- ## Manual where it matters
   - You own your memory, your errors, and your state. Safety is a toolkit, not something to enforce strictly even for unsafe codes
- ## Simple standard library
  - Only what’s needed. You basically build your own stuff, not import someone else’s complexity (thats script kidding :) )
- ## No feature inflation
   - Features must justify their use in syntax, semantics, and compiler complexity.
- ## Hackable Compiler (Finally , a language without LLVM!)
   - The compiler isn’t a black box. It’s open, clean, and documented. Make your own tools with confidence and skill issues if you have any!

--- 
EOF
