# 2. Variables and Types

Wyzer is strongly typed. You must always tell the compiler exactly what type of data you are using.

## How to Change Variables

Wyzer makes you think about when data changes.
1. `let` : Creates a normal variable. You cannot change it later. (immutable variable)
2. `var` : Creates a mutable variable
3. `const` : Creates a fixed constant. This is evaluated before the program runs.

```wyzer
fn main() {
    const MAX: u32 = 100u32;
    
    let x: u32 = 10u32;
    // x = 20u32; // ERROR: x cannot be changed!
    
    var y: u32 = 5u32;
    y = y + x; // OK: y was made with 'var'
}
```

## Basic Types
Numbers in Wyzer must show their exact size. 

**Integers:**
* Unsigned (positive only): `u8`, `u16`, `u32`, `u64`
* Signed (positive or negative): `i8`, `i16`, `i32`, `i64`

*Note: You must write the type at the end of the number (like `42u32`). A plain `42` will cause an error.*

**Booleans:**
* `bool` (`true` or `false`)

**Strings:**
* `str` (`"hello"`)

## Handling Errors
Wyzer does not have exceptions that crash your program. Instead, it uses a `Result` type for errors.

```wyzer
let success: Result<u32, str> = Ok(10u32);
let failure: Result<u32, str> = Err("Disk full");
```
