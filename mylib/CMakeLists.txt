cmake_minimum_required(VERSION 3.16)
project(mylib)

set(CMAKE_CXX_STANDARD 20)

include_directories(inc)
file(GLOB_RECURSE SOURCES "src/*.cpp")
file(GLOB_RECURSE HEADERS "inc/*.h")

add_compile_options(-Wall -Wextra -Wpedantic)
add_library(${PROJECT_NAME} SHARED ${SOURCES} ${HEADERS})
