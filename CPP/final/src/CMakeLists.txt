cmake_minimum_required(VERSION 3.9)
project(Midterm)

set(CMAKE_CXX_STANDARD 17)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17 -Wall -Wextra -Weffc++ -pedantic -g")

set(SORT_SOURCE_FILES
        01-Sort/sort.cpp)
add_executable(01-Sort ${SORT_SOURCE_FILES})

set(MEMORY_SOURCE_FILES
        02-Memory/memory.cpp
        02-Memory/thing.cpp
        02-Memory/widget.cpp)
add_executable(02-Memory ${MEMORY_SOURCE_FILES})

set(LAMBDA_SOURCE_FILES
        03-Lambda/lambda.cpp)
add_executable(03-Lambda ${LAMBDA_SOURCE_FILES})

set(BST_SOURCE_FILES
        04-BST/bst.cpp)
add_executable(04-BST ${BST_SOURCE_FILES})

set(THREADS_SOURCE_FILES
        05-Threads/threads.cpp)
add_executable(05-Threads ${THREADS_SOURCE_FILES})

set(FIZZBUZZ_SOURCE_FILES
        06-FizzBuzz/fb_main.cpp
        06-FizzBuzz/fizzbuzz.cpp)
add_executable(06-FizzBuzz ${FIZZBUZZ_SOURCE_FILES})

set(ACCUMULATE_SOURCE_FILES
        07-Accumulate/accumulate.cpp)
add_executable(07-Accumulate ${ACCUMULATE_SOURCE_FILES})