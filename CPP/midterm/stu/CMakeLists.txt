cmake_minimum_required(VERSION 3.9)
project(Midterm)

set(CMAKE_CXX_STANDARD 98)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++98 -Wall -Wextra -Weffc++ -pedantic -g")

set(BIKE_STU_SOURCE_FILES
        src/bike/bike_main.cpp
        src/bike/bike.cpp)
add_executable(BikeStu ${BIKE_STU_SOURCE_FILES})

set(MATRIX_STU_SOURCE_FILES
        src/matrix/matrix_main.cpp
        src/matrix/matrix.cpp)
add_executable(MatrixStu ${MATRIX_STU_SOURCE_FILES})

set(WIDGET_STU_SOURCE_FILES
        src/widget/widget_main.cpp
        src/widget/widget.cpp
        src/widget/thingamajig.cpp)
add_executable(WidgetStu ${WIDGET_STU_SOURCE_FILES})

set(WORDS_STU_SOURCE_FILES
        src/words/words_main.cpp)
add_executable(WordsStu ${WORDS_STU_SOURCE_FILES})

set(INFOMERCIAL_STU_SOURCE_FILES
        src/infomercial/infomercial_main.cpp
        src/infomercial/crap.cpp
        src/infomercial/schticky.cpp
        src/infomercial/shamwow.cpp
        src/infomercial/slapchop.cpp)
add_executable(InfomercialStu ${INFOMERCIAL_STU_SOURCE_FILES})

set(PAIR_STU_SOURCE_FILES
        src/pair/pair_main.cpp)
add_executable(PairStu ${PAIR_STU_SOURCE_FILES})

