cmake_minimum_required(VERSION 3.10)

set (CMAKE_C_STANDARD 17)
set (CMAKE_CXX_STANDARD 17)

find_package(LLVM REQUIRED CONFIG)

add_executable(test-runner
    main.cpp
    TestRunner.cpp
    Benchmarks/BenchRunner.cpp
    Benchmarks/PI/PIBenchmark.cpp
    Benchmarks/Sink/SinkBenchmark.cpp
    Benchmarks/QSort/QSortBenchmark.cpp
    Benchmarks/IntMM/IntMMBenchmark.cpp
    Benchmarks/FloatMM/FloatMMBenchmark.cpp
    Benchmarks/Sum1/Sum1Benchmark.cpp
    Benchmarks/Sum2/Sum2Benchmark.cpp
    Benchmarks/Sum3/Sum3Benchmark.cpp
    Benchmarks/Sum4/Sum4Benchmark.cpp
)

set(NO_RTTI "-fno-rtti")

add_definitions(${NO_RTTI})

target_include_directories(test-runner
    PRIVATE ${LLVM_INCLUDE_DIRS}
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/../Optimizer
)

target_compile_definitions(test-runner PRIVATE ${LLVM_DEFINITIONS})

target_link_libraries(test-runner 
    PRIVATE LLVM
    PUBLIC optimizer
)
