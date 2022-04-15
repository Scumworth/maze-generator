#ifndef INTERFACE_H
#define INTERFACE_H

#include <SDL2/SDL.h>

class Interface {
    private:
        SDL_Window* window;
        SDL_Renderer* renderer;
        bool isRunning;
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
};

#endif
