# The Wyzer Programming Language
![WYZERLANG](https://github.com/Wyzer-Lang/.github/blob/main/Group%20187.svg)

> "Simplicity is not the absence of power. It is power without pretense."
                                                                ~ Atiksh Sharma

Feel free to use the prentensious quote anywhere lol.

---
Wyzer is a statically typed, compiled, resource-oriented programming language with integrated distributed safety via choreographic programming and a perceus memory model

## Motive behind Wyzer
Rust guarantees safety within a process
It does nothing for:
- distributed deadlocks
- protocol mismatches
- cross-service correctness

To solve this problem Wyzer introduces the concept of **choreographic programming** which is one of the few serious attempts to solve it.


Contributions are welcome, if you want to contribute to the language please read [RESEARCH.md](https://github.com/wyzer-Lang/wyzer/blob/main/RESEARCH.md)

---

## FAQ: What It Is, Why It Exists, and What's Actually New

*A simple guide with no math. Use this to explain the project quickly.*

### 1. What Wyzer Is, In One Paragraph

Wyzer is a programming language built on one idea: most hard problems (like memory bugs, deadlocks, and network errors) happen because it is not clear who owns a resource. Instead of using three different tools to fix memory, concurrency, and networks, Wyzer uses just one ownership rule for all three.

### 2. Why Make a New Language At All?

This is a fair question, and the honest answer starts with what is already good about existing options, not what is wrong with them.

**Rust** proved you can have safe memory without a garbage collector. This is great, but Rust is hard to learn, and its rules make some common code structures difficult to write.

**Go, Java, C#, and Python** use garbage collectors. This makes them easier to use but slower and less predictable. This is bad for real-time or low-level systems.

**Network programming** is still mostly done by hand. You write two programs and hope they talk to each other correctly. When they don't, you get bugs.

Wyzer's goal: Get the safety of Rust without the difficulty, and use the same rule to make network programs safe too.

### 3. What's Actually New About It?

Most of Wyzer's pieces already exist. What is new is putting them together.

- **Perceus reference counting:** Fast memory management without Rust's complexity. We borrowed this from Koka and Lean 4.
- **Choreographic programming:** Writing one network rule that creates code for every computer. We borrowed this from academic research.
- **What is new:** We use the choreography idea for more than just networks. We use it for threads and interrupts too. The exact same rule proves memory safety, interrupt safety, and network safety.

The benefit: You only need to learn one rule to manage memory, threads, and networks safely.

### 4. Core Design Principles

These are the values that drive our decisions. They explain why Wyzer looks the way it does.

**One way to write a thing.** If there are two ways to write the same thing, we remove one.

**No hidden magic, but keep it clean.** Important things should be visible in the code, but you shouldn't have to write extra boilerplate.

**Let the compiler do the work, unless it is confusing.** We want the compiler to figure things out, but we require clear rules when things get tricky.

**Be honest about what is not finished.** We mark unsolved problems clearly so people know what needs work.

### 5. The Core Semantics, In Plain Language

This section is a simple map of the formal rules. Read this first to understand the basics.

**Memory (Section 5):** You write functional code that does not change data. Behind the scenes, if a piece of data has only one owner, the compiler changes it directly in memory. This makes it as fast as C without a garbage collector or lifetime rules.

**Ownership is everything (Sections 3, 6, 7):** The one rule is that once you use a resource, you cannot use it again. This applies to memory, network messages, and hardware interrupts.

**Safe networks (Section 6):** You write regular functions, and the types show who owns the data. The compiler figures out the network rules and checks them for you. This catches deadlocks and dropped messages before the code even runs.

**No hidden control flow:** There is no `async`/`await` split. Errors are returned as standard types, not hidden exceptions.

### 6. Frequently Asked Questions

**"Isn't this just Rust with extra steps?"**
No. We want Rust's safety without its steep learning curve. We use a different method (Perceus) for memory, and Rust does not have our network features.

**"Isn't choreographic programming already a solved research area?"**
The math works, but it is mostly used in research, not real languages. We want to bring it to a general-purpose language.

**"Why not just use effect handlers / async-await / a GC like everyone else does?"**
Those tools solve specific problems. Wyzer is trying to see if one single rule can solve memory, threads, and networks all at once.

**"Is this actually going to be finished or production-ready?"**
Honestly, this is early research. Several big problems are still unsolved.

**"What's the elevator pitch, one more time?"**
One ownership rule for memory, threads, and networks. No garbage collector, no complex borrow checker, and no network errors.
