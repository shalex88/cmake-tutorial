cmake_minimum_required(VERSION 3.16)
project(cmake-tutorial VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)

# Bad practice - include only required for build procedures
if(UNIX)
    message(STATUS "Linux Platform")
elseif(WIN32)
    message(STATUS "Windows Platform")
else()
    message(WARNING "Unknown Platform")
endif()

message(STATUS "${CMAKE_GENERATOR} Generator")

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/version.cpp ${CMAKE_CURRENT_BINARY_DIR}/_version.cpp
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_SOURCE_DIR}/version.cmake)

include_directories(inc)
file(GLOB_RECURSE SOURCES "src/*.cpp")
file(GLOB_RECURSE HEADERS "inc/*.h")

add_compile_options(-Wall -Wextra -Wpedantic)
add_executable(${PROJECT_NAME} main.cpp ${CMAKE_CURRENT_BINARY_DIR}/version.cpp ${SOURCES} ${HEADERS})

add_subdirectory(mylib)
include_directories(mylib/inc)

target_link_libraries(${PROJECT_NAME} PRIVATE mylib)