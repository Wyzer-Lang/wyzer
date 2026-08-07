# Wyzer ABI Specification (Draft)

This document outlines the Application Binary Interface (ABI) for Wyzer, specifically detailing how Wyzer types and data structures map to the standard C ABI for `extern "C"` Foreign Function Interface (FFI) calls.

> [!IMPORTANT]
> This is an evolving draft. As the language and compiler backend mature, memory layouts (especially regarding string representations and dynamic arrays) may change to optimize for zero-copy transfers.

## 1. Calling Convention

By default, any function marked with `extern "C"` uses the standard **C calling convention (cdecl/sysv_abi)** for the host platform (e.g., System V AMD64 ABI on Linux/macOS, Microsoft x64 calling convention on Windows).

Wyzer functions (not marked `extern "C"`) use a custom, unspecified calling convention heavily optimized by LLVM. You **cannot** currently call a standard Wyzer function directly from C without an `extern "C"` wrapper.

## 2. Primitive Type Mapping

Wyzer's strict primitive types map 1:1 with standard C fixed-width integers. They guarantee the exact bit-width and alignment of their C counterparts.

| Wyzer Type        | C Type (`<stdint.h>`)    | Size (Bytes)   | Alignment (Bytes) |
| :---------------- | :----------------------- | :------------- | :---------------- |
| `u8` / `i8`       | `uint8_t` / `int8_t`     | 1              | 1                 |
| `u16` / `i16`     | `uint16_t` / `int16_t`   | 2              | 2                 |
| `u32` / `i32`     | `uint32_t` / `int32_t`   | 4              | 4                 |
| `u64` / `i64`     | `uint64_t` / `int64_t`   | 8              | 8                 |
| `uSize` / `iSize` | `uintptr_t` / `intptr_t` | Arch-dependent | Arch-dependent    |
| `f16`             | `_Float16` / `__fp16`    | 2              | 2                 |
| `f32`             | `float`                  | 4              | 4                 |
| `f64`             | `double`                 | 8              | 8                 |
| `f128`            | `__float128`             | 16             | 16                |
| `bool`            | `bool` (`<stdbool.h>`)   | 1              | 1                 |
| `char`            | `uint32_t` (UTF-32)      | 4              | 4                 |

## 3. Pointers and Strings

> [!WARNING]
> Wyzer's string representation (`str`) is currently passed as a raw null-terminated `char*` to remain maximally compatible with standard `libc` functions like `puts` and `printf`. In the future, Wyzer strings may transition to a fat-pointer representation `{ ptr, len }` for internal use.

When calling `extern "C"`, `str` maps to a C-style `const char*`.

## 4. Struct Layouts

Wyzer structs are natively passed by reference (pointer) or by value depending on the signature. Struct fields are laid out in memory in the exact order they are defined, with standard C padding rules applied for alignment.

```rust
// Wyzer
struct Point {
    x: u32,
    y: u32,
}
```

Maps exactly to:

```c
// C
struct Point {
    uint32_t x;
    uint32_t y;
};
```

## 5. Algebraic Data Types (Enums)

Enums in Wyzer are represented as **Tagged Unions**. To prevent memory bound issues and overlap complexities across variants, Wyzer currently enforces a safe, padded memory layout for enums.

**Layout:**

1.  **Tag:** A 32-bit integer (`uint32_t`) representing the variant index (0-indexed based on declaration order).
2.  **Payload:** A statically-sized 32-byte payload block (represented as an array of four 64-bit integers `[4 x i64]`), regardless of the actual variant's data size.

```rust
// Wyzer
enum Message {
    Ok(u32),
    Err(str),
    None,
}
```

Maps to the following memory layout in C:

```c
// C
struct Message {
    uint32_t tag;          // 0 = Ok, 1 = Err, 2 = None
    uint64_t payload[4];   // 32-byte union space
};
```

When extracting the payload in C, you must cast the `payload` block to the appropriate pointer type based on the `tag` value.

## 6. Memory Ownership across Boundaries (Perceus RC)

> [!CAUTION]
> Wyzer manages memory via Perceus FBIP (Fully In-Place Updates) Reference Counting.
> When passing data to an `extern "C"` function, the C code **does not** take ownership of the reference count unless explicitly designed to interact with the Wyzer runtime.

- **Borrowing:** Passing a Wyzer string or struct to C is safe as a "borrow". The Wyzer runtime keeps the reference count alive for the duration of the FFI call.
- **Consuming:** If C code retains a pointer to Wyzer memory after the function returns, the memory may be freed by Wyzer, resulting in a dangling pointer. C code must copy the data if it intends to store it long-term.
