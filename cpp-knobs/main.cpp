#include "config.hpp"

int main (int argc, char* argv[])
{
    ui::Application app (WINDOW_WIDTH, WINDOW_HEIGHT, setup);
    return app.run (argc, argv);
}
