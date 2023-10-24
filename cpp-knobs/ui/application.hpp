#ifndef _UI_APPLICATION_H_
#define _UI_APPLICATION_H_

#include <gtkmm.h>

#include "button.hpp"
#include "window.hpp"

namespace ui
{

class Application: public Gtk::Application
{
    int win_w = 1;
    int win_h = 1;
    void (*setup)(Window *) = nullptr;

  public:
    Application(int window_width, int window_height, void (*setup_fn)(Window *)):
        Gtk::Application(""),
        win_w(window_width),
        win_h(window_height),
        setup(setup_fn) {}

    void on_activate()
    {
        auto hidden_window = Gtk::manage(new Window());
        add_window(*hidden_window);

        auto window = Gtk::manage(new Window());
        add_window(*window);

        window->set_transient_for(*hidden_window);

        window->set_default_size(win_w, win_h);
        window->set_resizable(false);
        window->set_decorated(false);
        window->set_modal(true);

        setup(window);
    }
};

}

#endif
