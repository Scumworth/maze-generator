#include "Interface.h"
#include <SDL2/SDL.h>
#include <iostream>
#include <list>
#include <SDL2/SDL_image.h>
#include <sol/sol.hpp>
#include <cassert>

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
    if (SDL_Init(SDL_INIT_EVERYTHING) != 0) {
        std::cerr << "Error initializing SDL" << std::endl;
        return;
    }

    // open common lua libs
    lua.open_libraries(
        sol::lib::base, 
        sol::lib::package, 
        sol::lib::table,
        sol::lib::math,
        sol::lib::string,
        sol::lib::count,
        sol::lib::package
    );

    lua.script("print('Lua is running')");
    
    // open custom lua scripts
    lua.require_file("utils", "assets/scripts/utils.lua");
    lua.require_file("cell", "assets/scripts/cell.lua");
    lua.require_file("grid", "assets/scripts/grid.lua");
    lua.require_file("binary_tree", "assets/scripts/binary_tree.lua");
    
    lua.script_file("assets/scripts/binary_tree_demo.lua");

    // create list to hold all rendered lines
    std::list<Line> lines;

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
        Render();
        ProcessInput();
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

void Interface::DrawLine(int x1, int y1, int x2, int y2, int xoffset, int yoffset) {
    SDL_RenderDrawLine(renderer, x1 + xoffset, y1 + yoffset, x2 + xoffset, y2 + yoffset);
}

void Interface::Render() {
    SDL_SetRenderDrawColor(renderer, 21, 21, 21, 255);
    SDL_RenderClear(renderer);
    sol::table walls = lua["line_coords"];
    int num_rows = lua["num_walls"];
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    for (int i = 1; i <= num_rows; i++) {
        Interface::DrawLine(walls[i][1], walls[i][2], walls[i][3], walls[i][4]);
    }
    // swap buffers
    SDL_RenderPresent(renderer);
}

void Interface::Destroy() {
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
}
