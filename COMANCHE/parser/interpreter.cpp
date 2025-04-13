#include "interpreter.hpp"
#include "ast_prt.hpp"
#include <iostream>
#include <stdexcept>

void Interpreter::executeFunction(const FunctionDecl* fn) {
    for (const auto& stmt : fn->body) {
        executeStmt(stmt.get());
    }
}

void Interpreter::executeStmt(const Stmt* stmt) {
    if (auto print = dynamic_cast<const PrintStmt*>(stmt)) {
        Value val = evaluateExpr(print->expr.get());
        std::cout << toString(val);
        if (print->newline) std::cout << std::endl;
    } else if (auto ret = dynamic_cast<const ReturnStmt*>(stmt)) {
        Value val = evaluateExpr(ret->expr.get());
        std::cout << toString(val) << std::endl;
    } else if (auto loop = dynamic_cast<const LoopStmt*>(stmt)) {
        while (true) {
            for (const auto& innerStmt : loop->body) {
                executeStmt(innerStmt.get());
            }
        }
    }
}

Value Interpreter::evaluateExpr(const Expr* expr) {
    if (auto lit = dynamic_cast<const LiteralExpr*>(expr)) {
        const std::string& raw = lit->value;
        if (raw.size() >= 2 && raw.front() == '"' && raw.back() == '"') {
            return Value(raw.substr(1, raw.size() - 2));  
        }

        
        try {
            double num = std::stod(raw);
            return Value(num);
        } catch (...) {
            return Value(raw);  
        }
    }

    if (auto bin = dynamic_cast<const BinaryExpr*>(expr)) {
        Value left = evaluateExpr(bin->left.get());
        Value right = evaluateExpr(bin->right.get());

        if (bin->op == "+") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue + right.numberValue);
            } else if (left.type == ValueType::STRING && right.type == ValueType::STRING) {
                return Value(left.stringValue + right.stringValue);
            } else {
                throw std::runtime_error("TypeError: Cannot add " + typeToStr(left.type) + " and " + typeToStr(right.type));
            }
        } else {
            throw std::runtime_error("Unsupported binary operator '" + bin->op + "'");
        }
    }

    if (auto var = dynamic_cast<const VariableExpr*>(expr)) {
        return Value(var->name);
    }

    throw std::runtime_error("Unsupported expression type in interpreter");
}


std::string Interpreter::toString(const Value& val) {
    if (val.type == ValueType::NUMBER) {
        return std::to_string(val.numberValue);
    }
    return val.stringValue;
}

std::string Interpreter::typeToStr(ValueType type) {
    return (type == ValueType::NUMBER) ? "number" : "string";
}
