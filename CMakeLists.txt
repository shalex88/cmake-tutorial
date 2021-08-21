cmake_minimum_required(VERSION 3.16)
project(cmake-tutorial)

set(CMAKE_CXX_STANDARD 20)

include_directories(inc)
file(GLOB_RECURSE SOURCES "src/*.cpp")
file(GLOB_RECURSE HEADERS "inc/*.h")

add_compile_options(-Wall -Wextra -Wpedantic)
add_executable(${PROJECT_NAME} main.cpp ${SOURCES} ${HEADERS})
