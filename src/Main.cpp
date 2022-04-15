#include <iostream>
#include "Interface.h"

int main(int argc, char* argv[]) {
    // intitialize interface
    Interface interface;
    interface.Initialize();
    interface.Run();
    interface.Destroy();
    return 0;
}
