#include "Interface.h"
#include <SDL2/SDL.h>
#include <iostream>
#include <SDL2/SDL_image.h>

// constructor
Interface::Interface() {
    isRunning = false;
    std::cout << "Interface constructor called" << std::endl;
}

// destructor
Interface::~Interface() {
    std::cout << "Interface destructor called" << std::endl;
}

void Interface::Initialize() {
    // init
    if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
        std::cerr << "Error initializing SDL" << std::endl;
        return;
    }

    // create SDL struct
    SDL_DisplayMode displayMode;

    // populate struct
    SDL_GetCurrentDisplayMode(0, &displayMode);
    windowWidth = 800;
    windowHeight = 600;
    window = SDL_CreateWindow(
        NULL,
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        windowWidth,
        windowHeight,
        SDL_WINDOW_BORDERLESS
    );
    if (!window) {
        std::cerr << "Error creating SDL window." << std::endl;
        return;
    }
    renderer = SDL_CreateRenderer(window, -1, 0);
    if (!renderer) {
        std::cerr << "Error creating SDL renderer." << std::endl;
    }

    // change video mode to "real" full screen
    SDL_SetWindowFullscreen(window, SDL_WINDOW_FULLSCREEN);
    isRunning = true;
}

void Interface::Run() {
    while (isRunning) {
        ProcessInput();
        Render();
    }
}

void Interface::ProcessInput() {
    SDL_Event sdlEvent;
    while(SDL_PollEvent(&sdlEvent)) {
        switch (sdlEvent.type) {
            case SDL_QUIT:
                isRunning = false;
                break;
            case SDL_KEYDOWN:
                if (sdlEvent.key.keysym.sym == SDLK_ESCAPE) {
                    isRunning = false;
                }
                break;
        }
    }
}

void Interface::Render() {
    SDL_SetRenderDrawColor(renderer, 21, 21, 21, 255);
    SDL_RenderClear(renderer);
    // Draw a PNG texture
    //SDL_Surface* surface = IMG_Load("./assets/images/tank-tiger-right.png"); 
    //SDL_Texture* texture = SDL_CreateTextureFromSurface(renderer, surface);

    // free memory
    //SDL_FreeSurface(surface); 

    // What is the destination rectangle that we want to place our texture
    //SDL_Rect dstRect = { 10, 10, 32, 32 };

    // copy texture to renderer
    //SDL_RenderCopy(renderer, texture, NULL, &dstRect);
    //SDL_DestroyTexture(texture);
    
    // swap buffers
    SDL_RenderPresent(renderer);
}

void Interface::Destroy() {
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
}