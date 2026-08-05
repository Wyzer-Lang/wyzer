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


Contributions are welcome, if you want to contribute to the language please read [RESEARCH.md](RESEARCH.md)

Join our discord server as well :)) https://discord.gg/RhpPhkTrVu

---

## Documentation

To learn how to program in Wyzer, check out our official documentation:
1. [Introduction](docs/01_introduction.md)
2. [Variables and Types](docs/02_variables_and_types.md)
3. [Control Flow](docs/03_control_flow.md)
4. [Functions and Structs](docs/04_functions_and_structs.md)
5. [Memory Model](docs/05_memory_model.md)

---

## How to Code in Wyzer

Wyzer is designed to be simple, explicit, and easy to read. Here is a quick look at how you write code in Wyzer.

### 1. Variables and Types
Everything has a clear type, and variables are immutable (cannot be changed) by default. If you want to change a variable, you must explicitly use `var` instead of `let`. You can also use `const` for compile-time constants.
```wyzer
fn main() {
    const MAX: u32 = 100;  // Compile-time constant
    let x: u32 = 10;       // Cannot be changed
    var y: u32 = 20;       // Can be changed
    
    y = y + x;
    std::io::println(y);
}
```

### 2. Structs and Data
You can define custom data structures and access their fields directly.
```wyzer
struct Point {
    x: u32,
    y: u32
}

fn main() {
    let p: Point = Point { x: 10, y: 20 };
    std::io::println(p.x);
}
```

### 3. Control Flow
Wyzer supports standard `if`/`else`, `while`, and `for` loops. Note that loops don't need parentheses around the condition.
```wyzer
fn main() {
    let mut i: u32 = 0;
    while i < 3 {
        std::io::println(i);
        i = i + 1;
    }
}
```

### 4. Error Handling and Match
Errors are not hidden. Functions that can fail return a `Result<T, E>`. You use `match` expressions to safely handle both the success (`Ok`) and error (`Err`) cases. Note that `match` is an expression, so if used as a standalone statement, it requires a trailing semicolon!
```wyzer
fn main() {
    let result: Result<u32, str> = Ok(42);
    
    match (result) {
        Ok(value) => std::io::println(value),
        Err(err_msg) => std::io::println(0)
    };
}
```

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

## AI Assistance

Assistance provided by AI

- AI was used to generate commit messages
- AI was used for research (understanding choreographic programming, perceus memory model, etc closely)
- AI was used for brand designing, i thank AI for providing me a wonderful number of ideas to help me design Wyzer's Logo :)
