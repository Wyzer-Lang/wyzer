#pragma once
#include "ast_prt.hpp"
#include <string>
#include <unordered_map>
#include <variant>

enum class ValueType {
    NUMBER,
    STRING,
    BOOLEAN
};

enum class VarKind {
    LET,
    VAR,
    CONST
};

struct Value {
    ValueType type;
    union {
    double numberValue;
    std::string stringValue;
    bool booleanValue;
    };
    Value() : type(ValueType::NUMBER), numberValue(0) {}
    Value(double num) : type(ValueType::NUMBER), numberValue(num) {}
    Value(std::string str) : type(ValueType::STRING), stringValue(std::move(str)) {}
    Value(bool b) : type(ValueType::BOOLEAN), booleanValue(b) {}

    ~Value() {
        if (type == ValueType::STRING) {
            stringValue.~basic_string();
        }
    }
};

struct VariableInfo {
    VarKind kind;
    Value value;
};

class Interpreter {
public:
    void executeFunction(const FunctionDecl* fn);

private:
std::string toString(const Value& val);
std::string typeToStr(ValueType type);
    void executeStmt(const Stmt* stmt);
    Value evaluateExpr(const Expr* expr);

    std::unordered_map<std::string, VariableInfo> variables;
};
