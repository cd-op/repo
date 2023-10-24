#ifndef _CONFIG_H_
#define _CONFIG_H_

#include <csignal>
#include <cmath>
#include <chrono>
#include <ctime>
#include <thread>

#include "ui/application.hpp"
#include "ui/boxes.hpp"
#include "ui/icon.hpp"
#include "ui/label.hpp"
#include "ui/scales.hpp"

// this file is an example configuration for the knobs dashboard/launcher
// it is meant to (non-exhaustively) illustrate how to quickly create dashboards
// for your own needs

// button callback helper: start a program and dismiss the dashboard
// useful for program launchers
#define launch(command) ([](){\
    std::thread t1(std::system, (command));\
    t1.detach();\
    the_window->dismiss();\
})

// button callback helper: execute a program, but keep the dashboard visible
// useful for scales/sliders and tooling buttons
#define spawn(command) ([](){\
    std::thread t1(std::system, (command));\
    t1.detach();\
})

// dashboard window dimensions, these must be set before creating the window
static int const WINDOW_WIDTH = 600;
static int const WINDOW_HEIGHT = 400;

// global dashboard window pointer for signal handlers
static ui::Window * the_window = nullptr;

// in this config we use a signal handler to summon/dismiss the dashboard
// a signal handler normally shouldn't be this complex (toggle uses a mutex),
// but so far no crashes/locks/races were detected during normal use
static void on_SIGUSR1(int)
{
    if(the_window != nullptr) {
        the_window->toggle();
    }
}

// here is an example of how to turn a label into a clock which updates on
// minute boundaries; can be adapted to tick on second boundaries if one is
// so inclined; this function shouldn't terminate
static void handle_clock(ui::LabelWidget * clock_label, char const * const clock_format)
{
    while(true) {
        static char buf[64] = {0};

        time_t t_now = time(0);
        struct tm const * now = localtime(&t_now);

        strftime(buf, sizeof(buf), clock_format, now);
        clock_label->set_markup(buf);

        struct tm next_minute = *now;
        next_minute.tm_min += 1;
        next_minute.tm_sec = 0;

        time_t t_next = mktime(&next_minute);

        std::this_thread::sleep_for(std::chrono::seconds(t_next - t_now));
    }
}

// scale callback function: note the value parameter which is the value of
// the scale right after the last update; this one sets the value for the
// Master control of the default ALSA sound card
static void adjust_volume(double value)
{
    std::string command;
    command.reserve(64);
    command.append("amixer sset Master -- ")
           .append(std::to_string(std::lround(value))).append("%");

    std::system(command.data());
}

// the setup function is where we organize the layout of our dashboard and
// wire controls to their handlers, it runs once during app initialization
static void setup(ui::Window * window)
{
    // if you need a global pointer to the window,
    // set that first to avoid segfaults
    the_window = window;

    // a label that will be our dashboard clock
    // it will be passed to the handler thread later
    // caveat: labels are pointers, not refs, because gtk's copy/move
    // constructors are deleted for some reason...
    auto clock = ui::Label("clock");

    // labels can take arbitrary pango markup, providing extreme flexibility:
    // if you can write a C/C++ function to get your text, you can have it
    // update a label with whatever information at whatever interval you want

    // window can only have one child widget, so it should probably be a box
    window->set_child(
        ui::BoundingBox(30).add( // a bounding box lets us control margins
            ui::VBox(30) // add a vertical layout box, 30px spacing between children
            .add(*clock) // then add widgets, or other boxes
            .add(
                ui::VBox(10)
                .add(ui::Button("terminal", "Alacritty", launch("alacritty")))
                .add(ui::Button("editor", "vim", launch("alacritty -e vim"))))
            .add( // calls to .add() can be chained
                ui::HBox(10)
                .add(ui::Icon("audio-speakers-symbolic"))
                .add(ui::HScale(0, 100, adjust_volume)))
        )
    );

    // setup the signal handler, in this case for USR1
    std::signal(SIGUSR1, on_SIGUSR1);

    // run the clock handler in a separate thread
    // because setup must be allowed to terminate
    static char const * const clock_format =
        "%a, %b %d\n<span size=\"300%%\">%H:%M</span>";
    std::thread t1(handle_clock, clock, clock_format);
    t1.detach();
}

#endif
