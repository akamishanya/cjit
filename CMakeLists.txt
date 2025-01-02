cmake_minimum_required(VERSION 3.10)
project(CJIT)

set (CMAKE_C_STANDARD 17)
set (CMAKE_CXX_STANDARD 17)

find_package(LLVM REQUIRED CONFIG)

add_subdirectory(Optimizer)
add_subdirectory(TestRunner)
