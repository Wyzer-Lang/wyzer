# The Wyzer Programming Language
Wyzer is a statically typed, compiled, resource-oriented programming language with integrated distributed safety via choreographic programming and a perceus memory model.

> "Simplicity is not the absence of power. It is power without pretense."
>                                                                 ~ Atiksh Sharma


**What is Choreographic Programming?**

In traditional distributed programming, you write separate code for the client and the server, and hope their communication protocols match up. Choreographic programming allows you to write a single, unified view of the entire distributed system. The compiler then mathematically projects this single script into deadlock-free, independent binaries for each physical node (e.g., Client and Server).

**What is the Perceus Memory Model?**

Perceus is a fast, deterministic memory management strategy that avoids the unpredictable pauses of a Garbage Collector and the complex annotations of a borrow checker. It uses precise reference counting to know exactly when a value has a single owner, allowing the compiler to mutate the data directly in place (FBIP) without making copies or pausing the program.

---

## Design Principles
- One ownership rule for everything
- No garbage collector
- No borrow checker
- Deadlock-free by design
- Avoid hidden magic
- C ABI compatibility  
- ### Rules we follow
  - Syntax to be kept concise avoiding it to be abbreviated
  - Base Syntax should be kept minimal , everything extra must be in under `std` library
  - Something shouldn't be made simpler beyond simple

---

## Examples
### Distributed Key-Value Store

In Wyzer, you write one program that describes how multiple systems talk to each other. The compiler automatically infers network sends and verifies ownership across nodes.

```wyzer
role @Client;
role @Server;

struct KVRequest {
    op: u8, // 0 for Get, 1 for Put
    key: str,
    value: str
}

fn main() {
    // Lock-free state owned securely by the Server
    var _store_key: str@Server = "";
    var _store_value: str@Server = "";

    // Client creates a Put request
    let put_req: KVRequest@Client = KVRequest { 
        op: 1, 
        key: "username", 
        value: "alice" 
    };
    
    // It is safely sent across the network by transferring ownership
    let server_req: KVRequest@Server = put_req;

    // Server updates its state without needing mutexes
    if server_req.op == 1 {
        _store_key = server_req.key;
        _store_value = server_req.value;
    }
}
```

Because Wyzer merges Choreography with Perceus linear typing, a network transfer acts as an absolute linear move. Transferring ownership of a variable across the network consumes it locally. Attempting to use it again produces a compile-time error:

```text
Error [E001]: use of moved variable `put_req`
╭─▶ example.wyz:31:22
│
│ 30 │     
│ 31 │     std::io::println(put_req);
│    │                      ╰────── variable `put_req` used here after being moved
│ 32 │ }
│
├─▶ note: `put_req` is a linear resource and can only be used once
├─▶ help: consider passing it by reference if you need to use it multiple times
╰─────────────────────────────────────────────────
```

---

### Request/Response Choreography

Choreographies make complex network handshakes read like a single sequential function. Here, a client queries a server, and the server returns the result back to the client:

```wyzer
fn fetch_data(query: str@Client) -> str@Client {
    // client transfers query to Server
    let server_query: str@Server = query;
    
    // server processes query securely
    let server_result: str@Server = db_lookup(server_query);
    
    // server transfers result back to Client
    let client_result: str@Client = server_result;
    
    return client_result;
}
```

---

### In-Place Mutation (Perceus)

Wyzer uses the Perceus memory model, which determines variable lifespans via precise reference counting. If a variable is uniquely owned (`refcount == 1`), the compiler safely mutates the data **in-place** rather than allocating new memory (known as FBIP: Functional But In-Place).

```wyzer
struct User { id: u32, name: str }

fn update_name(user: User, new_name: str) -> User {
    // In traditional functional languages, this allocates a new 'User' struct.
    // In Wyzer, if 'user' has exactly 1 owner, the compiler mutates the existing 
    // memory in-place, achieving C-like speeds without a borrow checker!
    return User {
        id: user.id,   // Value retained
        name: new_name // Value overwritten in-place
    };
}
```

---

## Documentation & Community

- Language Design & Motivation: [DESIGN.md](DESIGN.md)
- Research & Implementation Details: [RESEARCH.md](RESEARCH.md)
- Official Documentation: https://wyzer-lang.vercel.app/docs/foreword

Community: Join our Discord server: https://discord.gg/RhpPhkTrVu

## Notable Examples
- **donut.wyz**: donut.c reprogrammed in wyzer https://github.com/rudywasfound/donut.wyz
