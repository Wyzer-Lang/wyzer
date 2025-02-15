cmake_minimum_required(VERSION 3.16)
project(WyzerLang)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")

find_package(LLVM REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

add_executable(wyzer src/main.cpp src/lexer.cpp src/parser.cpp src/ir_gen.cpp)
add_library(lexer STATIC src/lexer.cpp)
target_link_libraries(wyzer lexer)


target_link_libraries(wyzer LLVM)
