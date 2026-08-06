# 2. Variables and Types

Wyzer is strongly typed. You must always tell the compiler exactly what type of data you are using.

## How to Change Variables

Wyzer makes you think about when data changes.

1. `let` : Creates a normal variable. You cannot change it later. (immutable variable)
2. `var` : Creates a mutable variable
3. `const` : Creates a fixed constant. This is evaluated before the program runs.

```wyzer
fn main() {
    const MAX: u32 = 100;

    let x: u32 = 10;
    // x = 20; // ERROR: x cannot be changed!

    var y: u32 = 5;
    y = y + x; // OK: y was made with 'var'
}
```

## Basic Types

Numbers in Wyzer must show their exact size.

**Integers:**

- Unsigned (positive only): `u8`, `u16`, `u32`, `u64`, `u128`, `usize`
- Signed (positive or negative): `i8`, `i16`, `i32`, `i64` , `i128`, `isize`

_Note: The compiler can guess the type of your numbers. If you just write `42`, the compiler will look at where it is used to figure out if it is a `u8` or `u32`. If it can't tell, it will make it an `i32` by default. You can also write the type at the end of the number (like `42u32`) if you want to be extra clear._

**Integer Bases:**

You can write integer literals in three bases. All three produce a standard Wyzer integer — the prefix is purely cosmetic and has no effect on the type.

| Prefix | Base | Example | Value |
|--------|------|---------|-------|
| *(none)* | Decimal | `255` | 255 |
| `0x` / `0X` | Hexadecimal | `0xFF` | 255 |
| `0b` / `0B` | Binary | `0b11111111` | 255 |

You can combine any base with a type suffix, or leave it off and let the compiler infer the type:

```wyzer
fn main() {
    // Suffixed — type is explicit
    let byte_max: u8  = 0xFFu8;         // hex, 255
    let nibble:   u8  = 0b1010;           // binary, 10
    let port:     u32 = 0x1F90u32;      // hex, 8080

    // Unsuffixed — type inferred from the annotation
    let status:   u32 = 0xFF;           // same as 255u32
    let flags:    u8  = 0b11110000;      // same as 240

    // Unsuffixed with no annotation — defaults to i32
    let code = 0xFF;                    // i32, value 255
}
```

Hex and binary literals work everywhere a decimal literal does, including arithmetic and bitwise expressions:

```wyzer
fn main() {
    let mask:   u32 = 0xFF00u32 & 0x0FFFu32;  // 3840
    let merged: u32 = 0xFF00u32 | 0x00FFu32;  // 65535
    let shifted: u32 = 0b0001 << 4;            // 16
}
```

_Note: A malformed literal like `0xGHI` is not valid Wyzer. The compiler will report an "unexpected token" error pointing at the invalid characters._

**Booleans:**

- `bool` (`true` or `false`)

**Strings:**

- `str` (`"hello"`)

## Handling Errors

Wyzer does not have exceptions that crash your program. Instead, it uses a `Result` type for errors.

```wyzer
let success: Result<u32, str> = Ok(10u32);
let failure: Result<u32, str> = Err("Disk full");
```
