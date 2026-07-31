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

### 4.1 Metaprogramming as Choreography (The Compiler as a Node)

Traditional systems programming languages introduce entirely separate sub-languages or disjoint evaluation phases to handle metaprogramming (e.g., C preprocessor macros, Rust's `macro_rules!`, or Zig's `comptime`). This creates a semantic bifurcation: the language executed by the compiler at build-time is fundamentally distinct from the language executed by the runtime, often lacking the full type-safety and syntax of the host language.

Wyzer unifies these concepts by proposing a radical topological shift: **the Compiler itself is treated as just another node in the choreography**. 

By formalizing the Compiler as an implicit, omnipresent role (e.g., `@Compiler`), metaprogramming simply becomes a standard choreographic `transfer` operation targeted at the compile-time node.

**Theoretical Formulation**: Let $C$ be the set of physical nodes in a choreography (e.g., $C = \{\text{Client}, \text{Server}\}$). We expand this set to define a unified topology $C' = C \cup \{N_{compiler}\}$.
When an expression evaluates to a value of type $T @ N_{compiler}$, the Endpoint Projection (EPP) engine recognizes it as a cross-boundary communication. Instead of emitting a physical network operation, the compiler routes the evaluation of that expression to its own internal AST evaluator during the compilation phase, injecting the result directly into the projected binaries of the receiving node.

For example, string interpolation and static code generation can be expressed dynamically:
```wyzer
// The format string requires information known only at compile time.
// By transferring the expression to the Compiler, it is evaluated instantly during the build.
let interpolated: str@Client = transfer(f"Build Date: {get_date()}", Compiler);
```
This paradigm yields three profound implications:
1. **Zero New Syntax**: Metaprogramming does not require distinct keyword modifiers (like `const fn` or `comptime`).
2. **Phase Separation via Topology**: The staging of computation (build-time vs. run-time) is elegantly subsumed by spatial topology. The temporal boundary of compilation is reframed as a spatial boundary to the `@Compiler` role.
3. **Trace Equivalence**: The typechecker ensures that the Compiler role satisfies choreographic trace equivalence identically to physical nodes, preventing malformed macro expansions.

This establishes a novel isomorphism between **multi-staged programming** and **choreographic programming**, heavily reducing the overall conceptual surface area of the language.

### 4.2 Knowledge of Choice via AST Synthesis

In classical distributed systems, **Knowledge of Choice** is a major source of deadlocks: if Node A evaluates a boolean condition that dictates the control flow of Node B, Node A must explicitly send the result of that condition to Node B, and Node B must block to receive it before branching. 

Most choreographic languages (like Jolie or Chor) handle this limitation passively. They strictly enforce *Choreographic Trace Equivalence* at compile-time, acting as a verification tool that rejects the program with an "Asymmetric Choreography" error if the footprint of operations doesn't match perfectly, forcing the developer to manually write the required synchronization protocols.

Wyzer elevates choreography from a passive verification tool to an **active compilation mechanism** via **Automatic Branch Synchronization (AST Synthesis)**.

**Theoretical Formulation**: Given a branching expression $E = \text{if } C \text{ then } B_1 \text{ else } B_2$, where the condition $C$ is evaluated strictly on role $N_{evaluator}$ (i.e., $\text{role}(C) = N_{evaluator}$). Let $R_{participants}$ be the set of all roles that contain operations within the blocks $B_1 \cup B_2$.

During Endpoint Projection (EPP), for any target role $N_{target} \in R_{participants} \setminus \{N_{evaluator}\}$:
1. The projection engine automatically erases the evaluation of condition $C$ for $N_{target}$.
2. It synthesizes a blocking network receive operation, yielding $C_{projected} \leftarrow \text{ENetRecv}(N_{evaluator})$.
3. Simultaneously, for the evaluating node $N_{evaluator}$, the engine synthesizes $O(|R_{participants}| - 1)$ network send operations, injecting $\text{ENetSend}(N_{target}, C)$ identically into the preambles of both projected blocks $B_1$ and $B_2$.

This allows developers to write a single, centralized control flow graph without explicitly reasoning about synchronization barriers:
```wyzer
// The condition is evaluated purely on the Client.
let x: u32@Client = 10;
if x > 5 {
    // The Server executes this branch without explicit network code!
    let msg: str@Server = "Greater!";
    std::io::println(msg); 
}
```
The compiler guarantees absolute trace equivalence by automatically constructing the required synchronization protocol directly into the AST, entirely removing deadlocks from the developer experience.

**What does "without explicit network code" mean here?**
In a traditional distributed system, the developer must manually write `send(true, Server)` on the Client and `recv(Client)` on the Server so the Server knows which branch to take. If the developer forgets, the system deadlocks. 
In Wyzer, the developer writes *none* of that. The Endpoint Projection engine detects that the condition is on the Client and the body is on the Server, and **physically injects the network sends and receives into the final compiled binaries for you**.

### 4.3 Zero-Cost Role Polymorphism

To maximize code reusability across a distributed topology, Wyzer introduces **Role Inference**.
Functions and variables that omit an explicit role annotation (e.g., `@Role`) are strictly inferred by the typechecker to belong to the `"Poly"` (Polymorphic) role.

When a `"Poly"` function is invoked by a specific physical node, the projection engine performs zero-cost monomorphization. The execution of the function is seamlessly projected onto the calling node's local memory, and its return value is implicitly cast to the caller's role without requiring a `transfer` boundary or incurring any network serialization overhead. 

This guarantees that standard library utilities (like math operations or data structure manipulations) remain completely topology-agnostic, while the compiler strictly forbids `"Poly"` functions from accessing node-specific global state.

### 4.4 Distributed Linear Types (Perceus Integration)

Wyzer's most critical innovation is the unification of local memory safety and distributed network safety under a single ownership paradigm.

By running the Choreographic Typechecker concurrently with the **Perceus Reference Counting & FBIP (Fully In-Place Update)** memory model, the `transfer` operation acts as an absolute linear move. 
When a value is `transfer`red across a role boundary, the typechecker marks the local reference as linearly `Consumed`. This structurally forbids double-frees and use-after-transfers across the network. If the `Client` attempts to access a variable that has already been dispatched over the network to the `Server`, the compiler halts with a predictable linear type error.

Because Perceus enforces these strict linear aliasing rules locally, the choreographic engine can safely trust that a message dispatched over a physical TCP socket has a singular, exclusive owner upon deserialization, seamlessly uniting the local heap with the distributed topology.

### Honest scope note
Building an entire OS this way is a long-term goal. For now, we want to prove this works for regular programs (threads talking safely). This is useful on its own. Later, we can try it on kernels, high level softwares and hardware (CPUs, GPUs, FPGAs...).

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

---

## 8. Prerequisite Concepts for Contributors

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

---

## 9. How to Contribute Right Now

Since we haven't written the code yet, the best ways to help are:

- Work on the open research questions in Section 7.
- Test the rules with real-world examples to find problems.
- Read the Tier 1-3 materials and tell us if our explanations are wrong.
- Draw up ideas for role-type syntax and ask for feedback.

We will update this document as we make decisions. If you see a mistake, please let us know.

---

## 10. Related Work & Theoretical Influences

Wyzer does not exist in a vacuum. It heavily builds upon and synthesizes concepts from several foundational research projects in the distributed programming community, particularly the work surrounding Fabrizio Montesi and the multiparty types community.

### 10.1 Choral and the CHOCO Project
The **CHOCO** project (and the resulting **Choral** language) identified a critical gap: choreographies were traditionally understood via process calculi and automata, alienating mainstream software engineers. 
Choral bridged this gap by extending Object-Oriented Java with higher-kinded types, expressing collaborative distributed objects at the type level, which a compiler then projects into pure-Java libraries per role. 

**Wyzer's relationship:** Wyzer shares Choral's mission to bridge choreography with mainstream development. However, rather than utilizing higher-kinded object-oriented types, Wyzer utilizes a functional/imperative foundation rooted in linear memory types (`T@Role`). While Choral produces libraries to be consumed by external Java code, Wyzer acts as a standalone, bare-metal systems compiler that produces standalone physical binaries.

### 10.2 The Choreographic and Multitier Isomorphism (ECOOP 2021)
In the seminal paper *"Multiparty Languages: The Choreographic and Multitier Cases"* (Giallorenzo, Montesi, Peressotti, Richter, Salvaneschi, Weisenburger - ECOOP 2021), the authors formally proved the underlying isomorphism between **Choreographic Programming** (global, top-down protocol descriptions) and **Multitier Programming** (languages like ScalaLoci or Eliom, where computation transitions across physical tiers via location annotations). 

**Wyzer's relationship:** Wyzer is the ultimate architectural realization of this paper's thesis. At the syntax level, Wyzer behaves like a Multitier language (developers declare variables at specific tiers via `T@Role` and transition via `transfer`). However, under the hood, the Endpoint Projection (EPP) engine and the typechecker enforce strict Choreographic Trace Equivalence. By marrying multitier developer experience with choreographic compilation safety, Wyzer seamlessly blends the two paradigms into one cohesive language.

### 10.3 CHORDS (Choreographies for Distributed Systems)
The **CHORDS** initiative (an ERC Consolidator Grant project) focuses on advancing the reasoning, expressivity, and development tooling of distributed systems through choreographies. 

**Wyzer's relationship:** Wyzer's concepts, specifically **Knowledge of Choice via AST Synthesis** and the unification of **Linear Memory Models (Perceus) with Choreography**, contribute directly to the goals outlined by the CHORDS project. By synthesizing network protocols at the AST level, Wyzer aims to improve the usability of choreographic systems.

---

## 11. Core Design FAQ (Choreography vs Traditional Paradigms)

This section documents common questions regarding how Wyzer differs from traditional distributed system models.

### 11.1 Is this just Remote Procedure Calls (RPC)?
No. In an RPC model, a client sends a request to a server, blocks, and waits for a response. Wyzer does not use requests or responses. If a function is annotated with a specific role (e.g., `@Server`), the compiler does not insert an RPC call for the Client. Instead, the Endpoint Projection (EPP) engine deletes the function from the Client's binary entirely. The Server executes the function natively because both participants are traversing the same AST. The Client does not wait for a response unless the developer explicitly writes a `transfer` back to the Client.

### 11.2 Does this introduce implicit network latency?
Wyzer requires explicit syntax to move data. A statement like `println(msg)` where `msg` is located at the `@Server` runs purely locally on the server. The only implicit network traffic generated by Wyzer is a 1-byte tag used for "Knowledge of Choice" (synchronizing branches like `if/else`). Heavy data structures only move across the network when the developer explicitly calls `transfer(data, Target)`.

### 11.3 Why not use Algebraic Effects instead of a custom compiler?
While choreographic programming can be embedded in a host language using Algebraic Effects (e.g., Koka or Eff), doing so requires the host runtime to manage effect handlers. For every network boundary, the runtime must intercept the operation, yield continuations, serialize data, and route traffic. Wyzer is a standalone compiler that uses Endpoint Projection to resolve these boundaries at compile time. The resulting binaries are standard loops and basic `send/recv` system calls, avoiding the runtime overhead associated with dynamic effect handlers.

### 11.4 Is the program a distributed state machine running in lock-step?
Yes. The fundamental model of Wyzer is a single global control flow graph. All participants execute the structural logic (loops and branches) in lock-step. However, unlike deterministic replay models where every node holds a full copy of the program state, the data payloads in Wyzer are physically separated. Participants only execute the data operations assigned to their specific roles, while maintaining synchronized control flow.