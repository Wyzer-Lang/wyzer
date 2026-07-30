# 8. Distributed Choreography (Multiple Computers in One File)

Imagine you want to build a smart home system. You have a **Server** in your living room and a **Sensor** on your front door. Normally, you have to write two separate programs in two separate projects, and figure out how to make them talk to each other over Wi-Fi. It is very hard and full of bugs.

Wyzer solves this by letting you write the code for **both computers in a single file**! This is called "Choreography".

## Declaring Roles

A "Role" is just a name for a separate computer or node in your network. You declare them at the top of your file:

```wyzer
role @Server;
role @Sensor;
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
