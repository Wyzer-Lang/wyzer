#include "COMANCHE/lexer/lexer.hpp"
#include "COMANCHE/parser/parser.hpp"
#include "COMANCHE/parser/ast_prt.hpp"
#include "COMANCHE/parser/interpreter.hpp"
#include <fstream>
#include <sstream>
#include <iostream>

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: wyzer-test <source-file>\n";
        return 1;
    }

    std::ifstream inFile(argv[1]);
    if (!inFile) {
        std::cerr << "Failed to open file: " << argv[1] << "\n";
        return 1;
    }

    std::stringstream buffer;
    buffer << inFile.rdbuf();
    std::string source = buffer.str();

    Lexer lexer(source);
    std::vector<Token> tokens = lexer.tokenize();
    for (const auto& tok : tokens) {
        std::cout << "Token: " << static_cast<int>(tok.type) << " (" << tok.value << ") at line " << tok.line << "\n";
    }
    std::cout << "SEMICOLON enum value: " << static_cast<int>(TokenType::SEMICOLON) << std::endl;

    try {
        Parser parser(tokens);
        auto program = parser.parse();  

        std::cout << "=== AST ===\n";
        printAST(program);

        FunctionDecl* mainFn = nullptr;
        for (const auto& decl : program->declarations) {
            if (auto fn = dynamic_cast<FunctionDecl*>(decl.get())) {
                if (fn->name == "main") {
                    mainFn = fn;
                    break;
                }
            }
        }

        if (!mainFn) {
            std::cerr << "Error: No main function found.\n";
            return 1;
        }

      
        Interpreter interpreter;
        interpreter.executeFunction(mainFn);

    } catch (const std::exception& e) {
        std::cerr << "Parser error: " << e.what() << "\n";
        return 1;
    }

    return 0;
}
