# 6. Enums and Choices

Sometimes a variable can only be a few specific things. For example, a traffic light can only be Red, Yellow, or Green. 

In Wyzer, you use an `enum` to make a list of choices.

Because Wyzer believes in "no hidden magic", there is only **one** way to declare an enum, and you must explicitly tell the compiler what type of numbers to use and how to calculate them.

You do this using an `iota` expression. `iota` represents the current step in the list!

## Standard Numbering

If you just want your choices to be numbered `0, 1, 2`, you simply pass `iota`:

```wyzer
enum TrafficLight: u8 (iota) {
    Red,    // iota is 0, so Red is 0
    Yellow, // iota is 1, so Yellow is 1
    Green   // iota is 2, so Green is 2
}
```

## Advanced Numbering

If you want to control the exact numbers, you can use math inside the parenthesis!

```wyzer
enum Flags: u8 (1 << iota) {
    Read,    // iota is 0, so 1 << 0 is 1
    Write,   // iota is 1, so 1 << 1 is 2
    Execute  // iota is 2, so 1 << 2 is 4
}
```

This exposes exactly how your data is represented underneath. The compiler calculates all the math before your program even runs, so it is extremely fast.
