#include <iostream>
#include <cassert>
#include <sol/sol.hpp>
#include "Interface.h"

// initialize global lua state
sol::state lua;

int main(int argc, char* argv[]) {
    // open common lua libs
    lua.open_libraries(sol::lib::base, sol::lib::package);
    lua.script("print('Lua is running')");
    
    // intitialize interface
    Interface interface;
    interface.Initialize();
    interface.Run();
    interface.Destroy();
    return 0;
}
