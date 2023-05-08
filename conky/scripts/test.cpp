#include <iostream>
#include <string.h>

int main(int argc, char* argv[]) {
    std::cout << (std::stof(argv[1]) / std::stof(argv[2])) * 100 << '\n';

    return EXIT_SUCCESS;
}
