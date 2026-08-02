# 10. Standard Library

Wyzer comes with a built-in standard library to help you build applications quickly without reinventing the wheel. The standard library is always available globally using the `std::` prefix.

---

## Input/Output (`std::io`)

The `std::io` module provides native tools for printing text to the screen and interacting with standard streams.

### Printing Text

```wyzer
fn main() {
    // Prints without a newline
    std::io::print("Hello ");
    
    // Prints with a newline
    std::io::println("World!");
    
    // Prints an error message
    std::io::eprintln("Something went wrong!");
}
```

### String Formatting (F-Strings)

```wyzer
fn main() {
    let user_name = "Alice";
    let score = 95;
    
    // Variables are inserted seamlessly
    std::io::println(f"Player {user_name} achieved a score of {score}!");
}
```

---

## String Operations (`std::string`)

The `std::string` module provides utilities for manipulating strings.

| Function | Signature | Description |
|---|---|---|
| `std::string::len(s)` | `(str) -> u64` | Returns string length |
| `std::string::concat(a, b)` | `(str, str) -> str` | Concatenates two strings |
| `std::string::contains(s, sub)` | `(str, str) -> bool` | Checks if substring exists |
| `std::string::starts_with(s, pre)` | `(str, str) -> bool` | Checks if string starts with prefix |
| `std::string::ends_with(s, suf)` | `(str, str) -> bool` | Checks if string ends with suffix |
| `std::string::to_upper(s)` | `(str) -> str` | Converts string to uppercase |
| `std::string::to_lower(s)` | `(str) -> str` | Converts string to lowercase |
| `std::string::trim(s)` | `(str) -> str` | Trims leading/trailing whitespace |
| `std::string::replace(s, from, to)`| `(str, str, str) -> str` | Replaces occurrences in string |
| `std::string::substr(s, start, len)`| `(str, u64, u64) -> str` | Extracts substring |
| `std::string::char_at(s, idx)` | `(str, u64) -> str` | Returns character at index |
| `std::string::split(s, delim)` | `(str, str) -> [str]` | Splits string by delimiter |

```wyzer
fn main() {
    let msg = "  hello world  ";
    let cleaned = std::string::trim(msg);
    let upper = std::string::to_upper(cleaned);
    std::io::println(upper); // HELLO WORLD
}
```

---

## Numeric Operations (`std::math`)

The `std::math` module provides integer math functions.

| Function | Signature | Description |
|---|---|---|
| `std::math::abs(n)` | `(i64) -> i64` | Absolute value |
| `std::math::min(a, b)` | `(i64, i64) -> i64` | Minimum of two integers |
| `std::math::max(a, b)` | `(i64, i64) -> i64` | Maximum of two integers |
| `std::math::pow(base, exp)` | `(u64, u64) -> u64` | Integer power |
| `std::math::sqrt(n)` | `(u64) -> u64` | Integer square root |
| `std::math::clamp(val, lo, hi)` | `(i64, i64, i64) -> i64` | Clamps value to range `[lo, hi]` |

```wyzer
fn main() {
    let x = std::math::abs(-42);
    let bounded = std::math::clamp(15, 0, 10);
    std::io::println(bounded); // 10
}
```

---

## Type Conversions (`std::conv`)

The `std::conv` module handles type conversions and string parsing.

| Function | Signature | Description |
|---|---|---|
| `std::conv::to_str(v)` | `(T) -> str` | Converts printable value to string |
| `std::conv::parse_int(s)` | `(str) -> Result<u64, str>` | Parses string to integer |
| `std::conv::parse_bool(s)` | `(str) -> Result<bool, str>` | Parses `"true"` or `"false"` to bool |

```wyzer
fn main() {
    let parsed = std::conv::parse_int("100");
    match parsed {
        Ok(v) => std::io::println(v),
        Err(e) => std::io::println(e)
    };
}
```

---

## Collection Utilities (`std::collections`)

The `std::collections` module provides operations on arrays.

| Function | Signature | Description |
|---|---|---|
| `std::collections::len(arr)` | `([T]) -> u64` | Returns array length |
| `std::collections::push(arr, val)` | `([T], T) -> [T]` | Appends element (returns new array) |
| `std::collections::pop(arr)` | `([T]) -> [T]` | Removes last element (returns new array) |
| `std::collections::reverse(arr)` | `([T]) -> [T]` | Reverses array elements |
| `std::collections::contains(arr, val)` | `([T], T) -> bool` | Checks if array contains value |

```wyzer
fn main() {
    let arr = std::collections::push([1, 2, 3], 4);
    std::io::println(std::collections::len(arr)); // 4
}
```

---

## Process Control (`std::process`)

The `std::process` module controls process execution and arguments.

| Function | Signature | Description |
|---|---|---|
| `std::process::exit(code)` | `(u32) -> !` | Exits process with code |
| `std::process::args()` | `() -> [str]` | Returns command line arguments |

---

## Hardware & Interrupts (`std::hw`)

The `std::hw` module provides hardware-level bindings for low-level systems programming.

| Function | Signature | Description |
|---|---|---|
| `std::hw::bind_interrupt(irq, handler)` | `(u32, fn) -> ()` | Binds interrupt vector to ISR handler |
