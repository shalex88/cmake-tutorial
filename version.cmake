message(${PROJECT_NAME})
message(${CMAKE_SOURCE_DIR})

execute_process(COMMAND git rev-parse HEAD
                OUTPUT_VARIABLE GIT_REV
                ERROR_QUIET)

# if ("${GIT_REV}" STREQUAL "")
#     set(GIT_REV "N/A")
#     set(GIT_DIFF "")
#     set(GIT_TAG "N/A")
#     set(GIT_BRANCH "N/A")
# else()
    string(SUBSTRING "${GIT_REV}" 1 7 GIT_REV)
    # message(${GIT_REV})

    execute_process(COMMAND git rev-parse --abbrev-ref HEAD
                    OUTPUT_VARIABLE GIT_BRANCH)
    string(STRIP "${GIT_BRANCH}" GIT_BRANCH)
    # message(${GIT_BRANCH})

    execute_process(COMMAND bash -c "git diff --quiet --exit-code || echo +"
                    OUTPUT_VARIABLE GIT_DIFF)
    string(STRIP "${GIT_DIFF}" GIT_DIFF)
    # message(${GIT_DIFF})

    execute_process(COMMAND git describe --exact-match --tags
                    OUTPUT_VARIABLE GIT_TAG ERROR_QUIET)
    string(STRIP "${GIT_TAG}" GIT_TAG)
    # message(${GIT_TAG})
# endif()

set(PROJECT_VERSION ${GIT_BRANCH}/${GIT_TAG}-${GIT_REV}${GIT_DIFF})
message(${PROJECT_VERSION})

#################################

set(VERSION "const char* GIT_REV=\"${GIT_REV}${GIT_DIFF}\";
const char* GIT_TAG=\"${GIT_TAG}\";
const char* GIT_BRANCH=\"${GIT_BRANCH}\";")

if(EXISTS inc/version.h)
    file(READ inc/version.h VERSION_)
else()
    set(VERSION_ "")
endif()

if (NOT "${VERSION}" STREQUAL "${VERSION_}")
    file(WRITE inc/version.h "${VERSION}")
endif()