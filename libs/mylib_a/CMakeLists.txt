cmake_minimum_required(VERSION 3.16)
project(mylib_a VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)

message(STATUS "${PROJECT_NAME}")

file(GLOB_RECURSE SOURCES "src/*.cpp")
file(GLOB_RECURSE HEADERS "inc/*.h")

add_compile_options(-Wall -Wextra -Wpedantic)
add_library(${PROJECT_NAME} SHARED ${SOURCES} ${HEADERS})
target_include_directories(${PROJECT_NAME} PUBLIC inc)

target_link_libraries(${PROJECT_NAME} PUBLIC mylib_b)