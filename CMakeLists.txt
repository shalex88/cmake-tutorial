cmake_minimum_required(VERSION 3.7)

project(cmake-tutorial)

message(${PROJECT_SOURCE_DIR})
message(${CMAKE_CURRENT_SOURCE_DIR})
# Add a custom command that produces version.cpp, plus
# a dummy output that's not actually produced, in order
# to force version.cmake to always be re-run before the build
ADD_CUSTOM_COMMAND(
    OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/inc/version.h
           ${CMAKE_CURRENT_SOURCE_DIR}/inc/_version.h
    COMMAND ${CMAKE_COMMAND} -P
            ${CMAKE_CURRENT_SOURCE_DIR}/version.cmake)

add_compile_options(-Wall -Wextra -Wpedantic)

include_directories(inc)

file(GLOB_RECURSE SOURCES "src/*.c")
file(GLOB_RECURSE INCLUDES "inc/*.h")

# Create excutable
add_executable(${PROJECT_NAME} ${SOURCES} ${INCLUDES})
