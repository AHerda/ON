#include <float.h>
#include <iostream>

int main(int argc, char* argv[]) {
    std::cout << "float epsilon " << FLT_EPSILON << std::endl;
    std::cout << "double epsilon " << DBL_EPSILON << std::endl;
    std::cout << "float max  " << FLT_MAX << std::endl;
    std::cout << "double max " << DBL_MAX << std::endl;
}