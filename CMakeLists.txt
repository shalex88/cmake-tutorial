cmake_minimum_required(VERSION 3.16)
project(cmake-tutorial VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)

message(STATUS "${PROJECT_NAME}")

# Handle finding the shared libraries on Windows, use for all platforms
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${PROJECT_BINARY_DIR}/bin")

# Bad practice - include only required for build procedures
if(UNIX)
    message(STATUS "Linux Platform")
    add_compile_options(-Wall -Wextra -Wpedantic)
elseif(WIN32)
    message(STATUS "Windows Platform")
    add_compile_options(/W4)

    # Handle building shared libraries on Windows
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
    set(BUILD_SHARED_LIBS TRUE)
else()
    message(WARNING "Unknown Platform")
endif()

message(STATUS "${CMAKE_GENERATOR} Generator")

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/version.cpp ${CMAKE_CURRENT_BINARY_DIR}/_version.cpp
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/cmake/version.cmake)

file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS "src/*.cpp")
file(GLOB_RECURSE HEADERS CONFIGURE_DEPENDS "inc/*.h")

configure_file (
    "${PROJECT_SOURCE_DIR}/inc/version.h.in"
    "${PROJECT_BINARY_DIR}/inc/version.h"
)
set(GLOB_RECURSE BINARY_DIR_HEADERS CONFIGURE_DEPENDS ${PROJECT_BINARY_DIR}/inc/*.h)

add_executable(${PROJECT_NAME} ${CMAKE_CURRENT_BINARY_DIR}/version.cpp ${SOURCES} ${HEADERS} ${BINARY_DIR_HEADERS})
target_include_directories(${PROJECT_NAME} PRIVATE inc)
target_include_directories(${PROJECT_NAME} PRIVATE ${PROJECT_BINARY_DIR}/inc)

set(LIBS libs)
add_subdirectory(${LIBS}/mylib_a)
add_subdirectory(${LIBS}/mylib_b)

target_link_libraries(${PROJECT_NAME} PRIVATE mylib_a)

# graphviz - Dependency graph generator
# sudo apt install graphviz0
find_program(GRAPHVIZ "dot")
if(GRAPHVIZ)
    add_custom_target(graphviz ALL
        COMMAND ${CMAKE_COMMAND} "--graphviz=graphviz/dependency.dot" .
        COMMAND dot -Tpng graphviz/dependency.dot -o graphviz/dependency.png
        WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")
else()
    message(WARNING "graphviz is not installed")
endif()