# Wyzer TODO List

## Core Metaprogramming
- [x] Add `@Compiler` as a built-in role to execute code during compilation.
- [x] Support `transfer(ast, TargetRole)` for injecting compile-time values and ASTs into runtime roles.
- [ ] Compile-time reflection API (`typeof`, `sizeof`, `alignof`).
- [ ] Expose an AST manipulation API to the `@Compiler` role for writing macros.
- [ ] Programmatic AST inspection (iterating over struct fields at compile time).
- [ ] `comptime` blocks for pre-computing heavy physics or lookup tables.
- [ ] Custom Linter API (writing your own lints that execute on the `@Compiler` role).
- [ ] Type-State metaprogramming (changing a type from `File<Open>` to `File<Closed>`).

## Choreography & Concurrency Enhancements
- [x] Endpoint Projection (AST Splitting): Automatically strip irrelevant code for specific roles (`--role` CLI flag).
- [ ] Compiler Backend: Export physical standalone binaries for projected nodes via C/OCaml code generation.
- [ ] Multi-cast transfers (e.g., `transfer(val, [@Node1, @Node2, @Node3])`).
- [ ] Fault tolerance decorators for network drops (`@Timeout`, `@Retry`) mapped to External roles.
- [ ] Zero-copy shared-memory IPC optimization for threads on the same physical CPU.

## Advanced Type System
- [x] Traits and Type Classes (`trait Show { fn to_string() -> str; }`).
- [ ] Trait bounds on generics (`generic<T: Show>`).
- [x] Algebraic Data Types (Full pattern matching on nested enums/structs).
- [ ] Smart Pointers (`Box<T>`, `Rc<T>`, `Arc<T>`).
- [ ] Slices (`[u8]`) and fat pointers.
- [ ] `any` type for dynamic dispatch and v-tables.
- [ ] Never type (`!`) for functions that diverge or crash.

## FFI & Low-Level Control
- [ ] `extern "C"` ABI compatibility.
- [ ] C header file generation (automatically creating `.h` files from Wyzer structs).
- [ ] Direct linking against `.so` and `.dll` files.
- [ ] Inline Assembly blocks (`asm!("mov rax, 1")`).
- [ ] Volatile reads/writes for memory-mapped I/O registers.
- [ ] Endianness control (`@BigEndian`, `@LittleEndian` struct annotations).
- [ ] `#pragma pack` equivalent for packed hardware structs.

## Modules & Tooling
- [ ] Multi-file compilation and dependency resolution.
- [x] `pub` and `priv` visibility modifiers.
- [ ] Namespaces and module aliasing (`import foo as bar`).
- [ ] Built-in package manager integration (like `cargo`).
- [ ] Dead-code elimination (Tree shaking).

## Standard Library & Built-ins

### `std::io` (Input/Output)
- [x] Standard streams: `stdin`, `stdout`, `stderr`.
- [x] Printing macros/functions: `print`, `println`, `eprint`, `eprintln`.
- [x] Formatting and interpolation (e.g., `f"Value: {x}"`).
- [ ] Generic `Read` and `Write` stream interfaces/traits.

### `std::fs` (File System & Paths)
- [ ] `File` type for reading, writing, and appending.
- [ ] Operations: `open`, `create`, `delete`, `rename`, `copy`.
- [ ] Directory operations: `mkdir`, `read_dir`, `rmdir`.
- [ ] `std::path`: Cross-platform path manipulation (`PathBuf`).

### `std::net` (Networking)
- [ ] `TcpListener` and `TcpStream` (Foundational for choreographic roles).
- [ ] `UdpSocket` for datagrams.
- [ ] `IpAddr` (IPv4 and IPv6 representations).
- [ ] DNS resolution (`lookup_host`).

### `std::thread` & `std::sync` (Concurrency)
- [ ] `spawn` for creating green threads.
- [ ] `sleep` and cooperative yielding (`yield`).
- [ ] Local channels (`mpsc::Sender`, `mpsc::Receiver`) for thread-to-thread communication on the same node.

### `std::math` (Mathematics)
- [x] Trigonometry (`sin`, `cos`, `tan`, `asin`, etc.).
- [x] Exponents and logarithms (`exp`, `log`, `log10`, `sqrt`, `pow`).
- [ ] Constants (`PI`, `E`, `TAU`).
- [ ] Hardware intrinsics (fast math).

### `std::collections` (Data Structures)
- [ ] Heap-allocated growable Arrays (`Vec<T>`).
- [ ] `HashMap<K, V>` and `HashSet<T>`.
- [ ] `LinkedList<T>` and `BTreeMap<K, V>`.

### Additional Utility Modules
- [ ] `std::env` (CLI arguments, environment variables).
- [x] `std::time` (Duration, Instant, Unix epoch time).
- [x] `std::process` (Spawning external shell commands, exit codes).
- [x] `std::string` (UTF-8 string manipulation, splitting, slicing).

## Error Reporting & Diagnostics
- [x] Implement a rich diagnostic engine for `LocatedError` (like Rust's `miette` or `rustc`) using accurate source spans.
- [x] Connect parsing syntax errors and typechecking semantic errors to the Diagnostic engine.
- [x] Print visual code snippets with pointers (`^~~~~`) to highlight the exact location of errors.
