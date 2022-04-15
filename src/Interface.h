#ifndef INTERFACE_H
#define INTERFACE_H

#include <sol/sol.hpp>
#include <SDL2/SDL.h>

class Interface {
    private:
        SDL_Window* window;
        SDL_Renderer* renderer;
        bool isRunning;
        struct Line { 
            int x1;
            int y1;
            int x2;
            int y2;
        };
        void DrawLine(int x1, int y1, int x2, int y2, int xoffset = 0, int yoffset = 0);
    public:
        // constructor
        Interface();
        // destructor
        ~Interface();
        void Initialize();
        void Run();
        void ProcessInput();
        void Render();
        // close window
        void Destroy();
        int windowWidth;
        int windowHeight;
        // global lua state
        sol::state lua;
};

#endif
