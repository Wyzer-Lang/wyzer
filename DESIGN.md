# Wyzer: Design Rationale & Contributor Guide

*A programming language that combines memory safety, interrupt safety, and distributed safety using a single ownership rule.*

Status: **early research / pre-implementation**
This document helps new members understand what Wyzer does and *why* we made major decisions. It includes ideas we tried and rejected.

---

## 1. What Wyzer Is

Wyzer is built on one main idea: **most hard problems in systems programming (like memory corruption, deadlocks, protocol mismatches, and unsafe concurrency) happen for the same reason. That reason is unclear or missing resource ownership rules.**

Instead of using different tools to solve memory, concurrency, and distributed safety (like a garbage collector, locks, and a networking library), Wyzer uses **one** static ownership rule for all three:

| Scale | Resource examples | Mechanism |
|---|---|---|
| Local memory | Heap values, buffers | Perceus reference counting + FBIP |
| Concurrent/interrupt | Locks, MMIO registers, shared buffers | Ownership sets checked against interrupt handlers |
| Distributed | Messages, remote values | Role-typed values (`T@Role`), choreography inferred from composition |

If this idea works well in practice, it is Wyzer's main contribution. If it *does not* work completely, that is still useful. We should share negative results instead of hiding them.

---

## 2. Why Not Just Use an Existing Language?

We respect existing languages. Each of the following influenced us. Understanding what they do well and what they lack is important for contributors.

- **C/C++**: Gives full control and runs fast. But manual memory management causes many security problems, like buffer overflows.
- **Rust**: Proves memory safety without a garbage collector (GC) using ownership and borrowing. This is great. But the borrow checker is hard to learn and use with some data structures. Wyzer wants the same safety without a GC, but without making the programmer follow strict borrow checker rules manually.
- **Go, Java, C#, Python**: Use garbage collection so you don't have to manage memory. But this makes programs pause randomly and run slower. This is fine for many apps but bad for real-time systems.
- **Koka / Lean 4**: Created **Perceus**, a smart reference-counting method. It often runs as fast as C without needing borrow checker rules. Wyzer uses this memory model.
- **Unison**: Created code where functions are identified by a hash, not a name. We thought about using this but decided not to. See Section 6.
- **Choreographic programming**: This is the research behind Wyzer's distributed safety. Current tools show the math works for networks. Wyzer wants to use this for more than just networks. See Section 4.

---

## 3. The Memory Model: Perceus + FBIP

### The problem
Memory management used to be a choice between: automatic (GC: safe, slow, unpredictable), manual (fast, unsafe), or statically checked (Rust: safe, fast, but hard to learn).

### The approach
Wyzer code is written in a functional style. Data cannot be changed after it is created. Instead of changing data, we create new data. This is important because it makes memory management easier to handle.

The compiler then uses **Perceus reference counting**:

1. Every heap value is reference-counted.
2. The compiler checks if a reference is the last one being used.
3. If you try to update the last reference, the compiler changes it directly in memory without making a new copy.
4. If the compiler isn't sure, it updates the reference count while the program runs. This is fast and does not pause the program.

### Why this instead of Rust's borrow checker
Perceus does not force you to write lifetime rules. You write normal functional code. The compiler figures out the rest and only does quick checks when running if needed. The trade-off: Rust is always fast but hard to write. Wyzer might be slightly slower sometimes but is much easier to write. **We still need to prove this works well in practice.**

### 3.1 Cyclic References and Memory Leaks
Because Perceus is a reference counting mechanism, a natural question is: **how does Wyzer handle cyclic data structures?**
Our current stance: **Wyzer accepts memory leaks for cyclic structures.**
We explicitly choose *not* to run a background cycle collector (tracing GC). A background cycle collector introduces unpredictable pauses, which violates our core goal of deterministic, low-latency execution for systems programming. If a developer builds a cyclic graph in Wyzer, those nodes will leak. In the future, we may explore type-level acyclicity restrictions or explicit weak references, but currently, cycles simply leak.

### 3.2 Trade-offs: Latency vs. Safety
Wyzer trades the absolute memory perfection of a tracing GC for predictable latency.
- **Advantage**: Dropping a value in Perceus is deterministic and interleaved with execution. There are no stop-the-world pauses.
- **Trade-off**: The developer must be conscious of cyclic structures. We provide memory safety (no use-after-free, no buffer overflows) without lifetime annotations, but we do not guarantee memory leak prevention if cycles are constructed.

### Further reading
- Reinking, Xie, de Moura, Leijen: *"Perceus: Garbage Free Reference Counting with Reuse"*
- Clean language's uniqueness typing

---

## 4. Generalized Choreographic Programming

### The classical version
Choreographic programming lets you write how different parts talk to each other in one place. You don't have to write code for each part separately. The compiler then splits this into safe code for each part.

Usually, a "participant" is a network computer. Wyzer wants to make a "participant" mean **anything that runs code and shares things**. This includes CPU cores, threads, and hardware, not just networks.

### Why generalize it at all
If this works, Wyzer will use the same rule for threads, interrupts, and networks. You will not need different tools like locks or RPC frameworks. This is our main goal.

### Design decision: no special `choreo` syntax
Early on, we considered explicit choreography blocks:

```
choreo transfer(S: sender, S': receiver) {
    S -> S': amount
    S' -> S: confirmation
}
```

We rejected this. We don't want special keywords like `async`/`await`. We want code to be simple and easy to combine. We also don't want to hide when code runs on another machine, because programmers need to know when that happens.

**Current plan:** We put the participant's role in the **type** (like `T@Role`). The compiler figures out how parts talk by looking at how functions are used together. It then checks that there are no deadlocks or errors.

### Interrupts as a special class of participant
Interrupt handlers stop the program at random times. They don't follow a strict script. Our plan:

- A scripted participant `S` executes an ordered sequence of instructions, which is what the projection of the global protocol produces for it.
- An interrupt handler `H` is **not** in the script. It waits for an event and can run at any time.
- **Safety rule:** Handler `H` is safe if it doesn't use the same things as script `S` at the same time, unless `S` gives those things to `H`.
- This uses the same ownership rules we already have. Interrupt safety is not a new feature; it is the same idea applied differently.

**Unsolved problem:** What if an interrupt handler needs to stop the script completely and restart it later? We are still researching this. See Section 7.

### Honest scope note
Building an entire OS this way is a long-term goal. For now, we want to prove this works for regular programs (threads talking safely). This is useful on its own. Later, we can try it on kernels and hardware.

### A cautionary precedent: Ada's Distributed Systems Annex
Ada tried something similar, but almost nobody used it. This is because Ada forced every part of the network to be written in Ada. If a feature only works when everyone uses the same language, few people will use it. Wyzer must not make this mistake.

Wyzer's fix: Roles are split into **Native** (compiled Wyzer code, fully verified) and **External** (any language, verified only against a shared contract). This keeps the safety guarantees for Wyzer systems while allowing them to talk to services written in any language. See Section 6.4 of the spec for details.

---

## 5. Error Handling & I/O (Current State)

Wyzer does **not** have algebraic effect handlers right now. For now:

- We handle errors using `Result<T, E>` types, like in Rust or Zig. There are no hidden exceptions.
- I/O is synchronous. There is no `async`/`await`, and no effect-polymorphism yet.

This makes things simpler for now. We might add effect handlers later to handle errors and security better. But they are hard to build, and we don't need them to prove our main ideas yet.

---

## 6. Ideas We Considered and Set Aside

Writing down rejected ideas helps new people understand our choices. It stops us from arguing over old topics.

| Idea | Why it was attractive | Why it's set aside for now |
|---|---|---|
| **Content-addressed code** (functions known by a hash, not a name) | Fixes dependency issues and helps with fast builds. | Good idea, but it doesn't fit our main goal right now. We might add it later to our tools. |
| **Algebraic effect handlers** | Combines async code, errors, and security nicely. | Very powerful, but too hard to build right now. See Section 5. |
| **Automatic parallelism** | Runs code at the same time without locks or managing threads. | We want our choreography to do this instead. Having both would be extra work and goes against our "one rule" idea. |
| **Reversible computing** | Might help with energy limits in the future. | Not needed for today's languages. It would make writing code too hard. We might look at this again if new hardware needs it. |
| **MLIR as a compiler base** | Good for optimizing code on any hardware. | We haven't rejected this. We might use it when we start compiling code. It's an implementation detail. |

---

## 7. Open Research Questions (Good First Places to Contribute)

These are the genuinely unsolved problems the project needs help on, roughly in priority order:

1. **Interrupt stop and restart.** What does it mean for an interrupt handler to completely stop a script and restart it in a new state? This is our biggest unsolved problem.
2. **Defining the three types of participants.** We need rules for scripts, interrupts, and untrusted code. We must prove these rules work together.
3. **Testing the Perceus cost.** How often does the compiler fail to figure out ownership and have to check it while running? We need to test this when the compiler is built.
4. **Syntax for role types.** How should we write role types (like `T@Role`) so they look natural?
5. **Untrusted participants and security.** How do we handle code that might break the rules? How do we run untrusted code safely?
6. **Native vs External roles.** What should the contract format look like for External roles? How do we treat them safely if we don't control their code?

---

## 8. Risk Register: What Could Actually Kill This Project

Having the right math is not the only thing that matters. Many big projects fail because of bad planning, not bad rules. We list our biggest risks here to be honest about them.

| Risk | Why it's real | Mitigation |
|---|---|---|
| **Stuck in design phase, never shipping code.** It is easy to design forever and never build a compiler. | This is the most common way small language projects fail. | A strict rule: the first compiler (Section 9) does not wait for every problem to be solved. |
| **The project is too big for one person.** Writing a compiler and checking protocols is a lot of work. | We know this is a problem. | We must do things in order. Build the basic parts first (Section 9) so we have a working tool before tackling the hardest problems. |
| **Math and formal rules are hard for new contributors to learn.** If you need to be an expert to help, nobody will join. | An outside reader pointed this out. It is a valid concern. | The FAQ and overview let people help with syntax, tools, and testing without needing to learn complex math. |
| **Forcing everyone to use only one language limits who will use it.** | This has happened before (see Section 4). | The Native/External role split (spec Section 6.4) fixes this problem. |
| **No clear way to prove our main idea works.** A nice idea that is never tested on real code is just a guess. | We need proof. | We have strict goals in Section 9. The interrupt example and a real network example must both compile and work. |

---

## 9. Roadmap: Maturity-Based Milestones

Milestones are based on what is finished, not dates.

**Milestone 0: The basic compiler works.** It includes basic functions, `enum`, `if` statements, basic errors, and `println`. It does not include advanced memory rules or choreography. Success means a simple program runs.

**Milestone 1: Memory analysis works and is tested.** Add uniqueness checking to the compiler. Success means programs use direct memory mutation instead of runtime checks for common cases.

**Milestone 2: A real network program compiles.** Implement basic role types and projection. Success means a protocol bug (like using a value after sending it) causes a real compile-time error.

**Milestone 3: Interrupt safety works on a real example.** Check the interrupt rule against a real driver example. The complex "stop and restart" feature is not needed yet.

**Milestone 4: Talking to other languages works, and the compiler compiles itself.** External role contracts are built, and we begin rewriting the compiler in Wyzer itself.

Each milestone is a working tool, not just a design document.

---

## 10. Prerequisite Concepts for Contributors

If you want to contribute to the *theory*, not just implementation, this is roughly the study path we'd recommend, in order:

**Tier 1: Basic language theory**
- Reading formal rules and typing logic.
- Benjamin Pierce, *Types and Programming Languages*: Read the first 6 chapters.
- Linear and affine type systems: The math behind Wyzer's ownership rules.

**Tier 2: Choreography**
- CSP and π-calculus: Where "deadlock-free" ideas come from.
- Multiparty session types (Honda, Yoshida, Carbone): Global vs. local types and projection.
- Fabrizio Montesi, *Introduction to Choreographies*: The foundation for Wyzer's main feature.

**Tier 3: Memory model**
- Reinking, Xie, de Moura, Leijen: *"Perceus: Garbage Free Reference Counting with Reuse"*
- Clean language's uniqueness typing.

**Tier 4: Systems knowledge (for OS development)**
- *Operating Systems: Three Easy Pieces* (free online): Covers interrupts.
- seL4's approach to resource access and verification: The closest project to what Wyzer wants to do at the OS level.
