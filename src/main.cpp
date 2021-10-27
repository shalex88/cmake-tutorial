#include <iostream>
#include "mylib_a.h"
#include "mylib_b.h"
#include "version.h"

extern const char* git_tag;
extern const char* git_rev;
extern const char* git_branch;

int main() {
    std::cout << "Hello, World!" << std::endl;
    my_lib_a();
    my_lib_b();
    #ifdef EMBEDDED_LINUX
        std::cout << "Define in App!!!" << std::endl;
    #endif
    std::cout << git_branch << "/" << git_rev << std::endl;

    return 0;
}
