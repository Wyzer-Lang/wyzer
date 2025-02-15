#include <iostream>
#include <fstream>
#include <sstream>
#include "include/lexer.h"
#include "include/parser.h"
#include "include/ir_gen.h"

int main(int argc, char** argv) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <file.wyz>\n";
        return 1;
    }

    std::ifstream file(argv[1]);
    if (!file) {
        std::cerr << "Error: Could not open file " << argv[1] << "\n";
        return 1;
    }

    std::stringstream buffer;
    buffer << file.rdbuf();
    std::string source = buffer.str();

    Lexer lexer(source);
    std::vector<Token> tokens = lexer.scanTokens();

    Parser parser(tokens);
    std::vector<std::unique_ptr<Stmt>> statements = parser.parse();

    
    LLVMCodeGen codegen; 
    codegen.generate(statements);

    return 0;
}
