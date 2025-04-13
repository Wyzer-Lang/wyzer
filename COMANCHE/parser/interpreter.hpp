#pragma once
#include "ast_prt.hpp"
#include <string>

enum class ValueType {
    NUMBER,
    STRING
};

struct Value {
    ValueType type;
    double numberValue;
    std::string stringValue;

    Value(double num) : type(ValueType::NUMBER), numberValue(num) {}
    Value(std::string str) : type(ValueType::STRING), stringValue(std::move(str)) {}
};

class Interpreter {
public:
    void executeFunction(const FunctionDecl* fn);

private:
    void executeStmt(const Stmt* stmt);
    Value evaluateExpr(const Expr* expr);
    std::string toString(const Value& val);
    std::string typeToStr(ValueType type);
};
