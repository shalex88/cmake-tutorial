execute_process(COMMAND git log --pretty=format:'%h' -n 1
                OUTPUT_VARIABLE git_rev
                ERROR_QUIET)

if ("${git_rev}" STREQUAL "")
    set(git_rev "N/A")
    set(git_dirty "")
    set(git_tag "N/A")
    set(git_branch "N/A")
else()
    execute_process(
        COMMAND bash -c "git diff --quiet --exit-code || echo +"
        OUTPUT_VARIABLE git_dirty)
    execute_process(
        COMMAND git describe --exact-match --tags
        OUTPUT_VARIABLE git_tag ERROR_QUIET)
    execute_process(
        COMMAND git rev-parse --abbrev-ref HEAD
        OUTPUT_VARIABLE git_branch)

    string(STRIP "${git_rev}" git_rev)
    string(SUBSTRING "${git_rev}" 1 7 git_rev)
    string(STRIP "${git_dirty}" git_dirty)
    string(STRIP "${git_tag}" git_tag)
    string(STRIP "${git_branch}" git_branch)
endif()

set(VERSION "const char* git_rev=\"${git_rev}${git_dirty}\";
const char* git_tag=\"${git_tag}\";
const char* git_branch=\"${git_branch}\";"
)

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/version.cpp)
    file(READ ${CMAKE_CURRENT_SOURCE_DIR}/version.cpp VERSION_)
else()
    set(VERSION_ "")
endif()

if (NOT "${VERSION}" STREQUAL "${VERSION_}")
    file(WRITE ${CMAKE_CURRENT_SOURCE_DIR}/version.cpp "${VERSION}")
endif()
