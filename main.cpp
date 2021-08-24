#include <iostream>
#include <mylib.h>

extern const char* git_tag;
extern const char* git_rev;
extern const char* git_branch;

int main() {
    std::cout << "Hello, World!" << std::endl;
    my_lib();
    std::cout << git_branch << "/" << git_rev << std::endl;

    return 0;
}
