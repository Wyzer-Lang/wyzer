# 8. Distributed Choreography (Multiple Computers in One File)

Imagine you want to build a smart home system. You have a **Server** in your living room and a **Sensor** on your front door. Normally, you have to write two separate programs in two separate projects, and figure out how to make them talk to each other over Wi-Fi. It is very hard and full of bugs.

Wyzer solves this by letting you write the code for **both computers in a single file**! This is called "Choreography".

## Declaring Roles

A "Role" is just a name for a separate computer or node in your network. You declare them at the top of your file:

```wyzer
role @Server;
role @Sensor;
```

### Physical Transports
If you know exactly what hardware is running these roles, you can pass physical configuration properties to the role declaration. The compiler verifies these properties at compile-time:

```wyzer
role @Sensor { 
    transport: "I2C", 
    address: 0x48 
}
```

## Writing Functions for Different Computers

When you write a function, you can tell Wyzer exactly which computer should run it using the `@` symbol.

```wyzer
// This function lives and runs ONLY on the Sensor
fn get_temperature() @ Sensor -> u32 {
    return 72u32;
}

// This function lives and runs ONLY on the Server
fn main() @ Server {
    // How do we get the temperature from the Sensor?
}

### Role Inference (Zero-Cost Polymorphism)
What if you want to write a utility function that works on *any* node? If you omit the `@Role` annotation, the compiler automatically infers it as `"Poly"`. 

```wyzer
// This can safely run on Server, Sensor, or Client!
fn add(a: u32, b: u32) -> u32 {
    a + b
}
```
When the `Server` calls a `"Poly"` function, the return type is seamlessly and automatically cast into the `Server`'s memory without needing a `transfer()`! The compiler guarantees the `"Poly"` function cannot directly access any node-specific globals.
```

## The Magic of the Compiler

What happens when the `Server` wants to call a function on the `Sensor`? In other languages, you have to write complex network requests.

In Wyzer, you just call the function!

```wyzer
fn main() @ Server {
    // The Server calls the Sensor!
    let data = get_temperature();
}
```

When you do this, Wyzer automatically understands that it needs to send a network message from the Server to the Sensor, wait for the Sensor to calculate the answer, and send it back. 

## Strict Memory Boundaries (The Invisible Wall)

There is a catch! The `Server` and the `Sensor` do not share memory. If the Sensor returns a `u32` number, that number lives in the Sensor's memory! It is of type `u32@Sensor`. 

The compiler builds an invisible wall. It will **completely block** the Server from reading the Sensor's data directly, because that would crash your program.

```wyzer
fn main() @ Server {
    // ERROR! 'data' belongs to the Sensor, but you are the Server!
    let data: u32 = get_temperature(); 
}
```

## Using `transfer` to Cross the Wall

To actually read the data on the Server, you must explicitly use `transfer`. This tells the compiler: "I want to package up this data and safely move it across the network to my computer."

```wyzer
fn main() @ Server {
    // SUCCESS! 
    // We get the data from the Sensor, and safely transfer it to the Server.
    let data: u32 = transfer(get_temperature(), Server); 
}
```

It is that simple! You just built a distributed system across two computers without writing a single line of networking code.

## Knowledge of Choice (Automatic Branch Synchronization)

Because network messages require two computers to participate (one sending, one receiving), branching control flow can cause dangerous deadlocks.

```wyzer
fn main() {
    let x: u32@Client = 10;
    
    if x > 5 {
        // The condition belongs to the Client!
        let msg: str@Server = "Greater than 5!";
        std::io::println(msg);
    } else {
        let msg: str@Server = "Less than or equal to 5!";
        std::io::println(msg);
    }
}
```

In other systems, the `Server` would deadlock because it doesn't know the value of `x` (which is stored on the `Client`) and wouldn't know which branch to execute.

Wyzer solves this through **Knowledge of Choice**. During Endpoint Projection (EPP), the compiler detects that the `Client` is making a choice that affects the `Server`. Wyzer will **automatically inject** hidden network messages into the AST!

When compiled for `Client`, the `if/else` block will automatically prepend a network send:
```wyzer
    if x > 5 {
        std::net::send(Server, true);
    } else {
        std::net::send(Server, false);
    }
```
When compiled for `Server`, the entire condition is erased and replaced by a network receive, dynamically routing the Server to the correct block:
```wyzer
    if std::net::recv(Client) {
        let msg = "Greater than 5!";
        std::io::println(msg);
    } else {
        let msg = "Less than or equal to 5!";
        std::io::println(msg);
    }
```

## Endpoint Projection (Compilation)

When you are ready to deploy your code, how do you compile a single file into two separate binaries for two different computers?

You use the `--role` flag!

```bash
# Compiles and runs ONLY the Server code
wyzerc -- my_file.wyz --role Server

# Compiles and runs ONLY the Client code
wyzerc -- my_file.wyz --role Client
```

When you pass this flag, the Wyzer compiler uses its type-aware **Endpoint Projection (EPP)** engine. It actively splits your single AST, completely stripping away all variables, function calls, and expressions belonging to other roles. It then safely replaces all `transfer` boundaries with physical `ENetSend` and `ENetRecv` operations, leaving perfectly optimized standalone binaries for each specific physical computer.
