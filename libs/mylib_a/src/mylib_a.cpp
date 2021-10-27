#include <iostream>
#include "mylib_a.h"
#include "mylib_b.h"

int my_lib_a(void) {
    std::cout << "My lib A" << std::endl;
    #ifdef EMBEDDED_LINUX
        std::cout << "Define in Lib!!!" << std::endl;
    #endif
    return 0;
}
