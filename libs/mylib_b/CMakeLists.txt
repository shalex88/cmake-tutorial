cmake_minimum_required(VERSION 3.16)
project(mylib_b VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)

message(STATUS "${PROJECT_NAME}")

# Bad practice - include only required for build procedures
if(UNIX)
    message(STATUS "Linux Platform")
    add_compile_options(-Wall -Wextra -Wpedantic)
elseif(WIN32)
    message(STATUS "Windows Platform")
    add_compile_options(/W4)
else()
    message(WARNING "Unknown Platform")
endif()

file(GLOB_RECURSE SOURCES "src/*.cpp")
file(GLOB_RECURSE HEADERS "inc/*.h")

add_library(${PROJECT_NAME} SHARED ${SOURCES} ${HEADERS})
target_include_directories(${PROJECT_NAME} PUBLIC inc)