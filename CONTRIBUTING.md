# Contributing to Wyzer

First off, thank you for considering contributing to Wyzer! It's people like you that make Wyzer such a great language.

## Getting Started

1. **Fork the repository** on GitHub.
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/your-username/wyzer.git
   cd wyzer
   ```

## Development Environment Setup

Wyzer is written in OCaml and uses Dune as its build system.

1. **Install OPAM** (the OCaml package manager) by following the instructions at [opam.ocaml.org](https://opam.ocaml.org/).
2. **Initialize OPAM** and install the correct compiler version:
   ```bash
   opam init
   opam switch create 5.1.0 # Or the version specified in the project
   eval $(opam env)
   ```
3. **Install Dependencies**:
   ```bash
   opam install dune menhir
   ```
   *Note: Check the `dune-project` file for any additional dependencies.*

## Building and Testing

To build the compiler:
```bash
dune build
```

To run the compiler against a test file:
```bash
dune exec wyzerc wyzer_tests/io_test.wyz
```

Please make sure all tests pass before submitting a pull request, and consider adding new tests for any features or bug fixes you implement! Test files are located in the `wyzer_tests/` directory.

## How to Contribute

### Reporting Bugs
- Ensure the bug was not already reported by searching on GitHub under Issues.
- If you're unable to find an open issue addressing the problem, open a new one. Be sure to include a title and clear description, as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.

### Suggesting Enhancements
- Open a new issue with a clear title and description.
- Explain why this enhancement would be useful to most Wyzer users.

### Pull Requests
1. Create a new branch from `master` (`git checkout -b my-new-feature`).
2. Make your changes and test them thoroughly.
3. Commit your changes with a clear and descriptive commit message (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin my-new-feature`).
5. Create a new Pull Request on GitHub.

## Code Style

- Please adhere to standard OCaml formatting conventions. 
- Ensure that the parser (`lib/parser.mly`), lexer (`lib/lexer.mll`), and typechecker (`lib/typechecker.ml`) remain clean and well-documented.
- If you are adding a major feature, please remember to update the documentation in the `docs/` directory.

## Code of Conduct

- By participating in this project, you agree to abide by our Code of Conduct. Please be respectful and considerate of others when communicating on issues or pull requests.

- **By contributing to this project, you agree to transfer all right, title, and interest
in the copyright in the contribution that you own or control to the owner of this project.
This is intended to protect the project from bad-faith copyright claims, including (but not
limited to) DMCA takedown requests, which could severely harm the project and even potentially
kill it entirely. This agreement may be used in a court of law as evidence of the parties'
respective rights and obligations concerning the contribution in any applicable legal proceedings.
You may be required to explicitly acknowledge this agreement in your contribution depending on
the nature or significance of the contribution.**

### AI Usage
Bringing technology to use is not an issue , it becomes an issue with how you use technology so here are the rules for using AI in this project. 
You're not carrying the heavy weight of a corporate job here , remember that you are contributing because you truely care about the language and want to be a part of it. You came with an interest of contributing and by all means do not pressure yourself to contribute to the project because you just want to maybe stamp this on your CV perhaps? At this project we prefer people to be honest and loyal, human written code also helps me defend it line by line against people who want to know the reasoning behind the logic of the code.

- Refrain from using AI for coding wyzer as it can cause the language to be buggy as seen in the Linux kernel
- If AI was used in contributing please mention where and how AI was used when you open the PR
- AI can be used for understanding what's going on in the project
- Decisions taken by AI should be thoroughly discussed in issues or our discord server before execution https://discord.gg/RhpPhkTrVu

Happy hacking!
