#include "interpreter.hpp"
#include "ast_prt.hpp"  // Ensure this includes FunctionCallExpr definition
#include <iostream>
#include <stdexcept>
#include <cmath>

void Interpreter::executeFunction(const FunctionDecl* fn) {
    for (const auto& stmt : fn->body) {
        executeStmt(stmt.get());
    }
}

void Interpreter::executeStmt(const Stmt* stmt) {
    if (auto print = dynamic_cast<const PrintStmt*>(stmt)) {
        Value val = evaluateExpr(print->expr.get());
        if (print->newline) {
            if (val.type == ValueType::NUMBER || val.type == ValueType::BOOLEAN) {
                std::cout << (val.type == ValueType::NUMBER ? std::to_string(val.numberValue) : (val.booleanValue ? "true" : "false"));
            } else {
                std::cout << val.stringValue;
            }
            std::cout << std::endl;
        } else {
            if (val.type == ValueType::NUMBER || val.type == ValueType::BOOLEAN) {
                std::cout << (val.type == ValueType::NUMBER ? std::to_string(val.numberValue) : (val.booleanValue ? "true" : "false"));
            } else {
                std::cout << val.stringValue;
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
        } else if (bin->op == "-") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue - right.numberValue);
            } else {
                throw std::runtime_error("TypeError: '-' only supported for numbers");
            }
        } else if (bin->op == "*") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue * right.numberValue);
            } else {
                throw std::runtime_error("TypeError: '*' only supported for numbers");
            }
        } else if (bin->op == "/") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                if (right.numberValue == 0) {
                    throw std::runtime_error("RuntimeError: Division by zero");
                }
                return Value(left.numberValue / right.numberValue);
            } else {
                throw std::runtime_error("TypeError: '/' only supported for numbers");
            }
        } else if (bin->op == "%") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(fmod(left.numberValue, right.numberValue));
            } else {
                throw std::runtime_error("TypeError: '%' only supported for numbers");
            }
        } else if (bin->op == "==") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue == right.numberValue);
            } else if (left.type == ValueType::STRING && right.type == ValueType::STRING) {
                return Value(left.stringValue == right.stringValue);
            } else if (left.type == ValueType::BOOLEAN && right.type == ValueType::BOOLEAN) {
                return Value(left.booleanValue == right.booleanValue);
            }
            throw std::runtime_error("TypeError: '==' only supported for numbers, strings, or booleans");
        } else if (bin->op == "!=") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue != right.numberValue);
            } else if (left.type == ValueType::STRING && right.type == ValueType::STRING) {
                return Value(left.stringValue != right.stringValue);
            } else if (left.type == ValueType::BOOLEAN && right.type == ValueType::BOOLEAN) {
                return Value(left.booleanValue != right.booleanValue);
            }
            throw std::runtime_error("TypeError: '!=' only supported for numbers, strings, or booleans");
        } else if (bin->op == "<") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue < right.numberValue);
            }
            throw std::runtime_error("TypeError: '<' only supported for numbers");
        } else if (bin->op == ">") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue > right.numberValue);
            }
            throw std::runtime_error("TypeError: '>' only supported for numbers");
        } else if (bin->op == "<=") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue <= right.numberValue);
            }
            throw std::runtime_error("TypeError: '<=' only supported for numbers");
        } else if (bin->op == ">=") {
            if (left.type == ValueType::NUMBER && right.type == ValueType::NUMBER) {
                return Value(left.numberValue >= right.numberValue);
            }
            throw std::runtime_error("TypeError: '>=' only supported for numbers");
        }
        
         else {
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
