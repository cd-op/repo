#ifndef _UI_WINDOW_H_
#define _UI_WINDOW_H_

#include <mutex>

#include <gtkmm.h>

namespace ui
{

class Window: public Gtk::Window
{
    std::mutex visible_mutex;
    bool visible = false;
    bool shown = false;

  public:
    void dismiss()
    {
        std::lock_guard<std::mutex> guard(visible_mutex);

        visible = false;
        hide();
    }

    void summon()
    {
        std::lock_guard<std::mutex> guard(visible_mutex);

        visible = true;

        if(!shown) {
            shown = true;
            show();
        }

        present();
    }

    void toggle()
    {
        std::lock_guard<std::mutex> guard(visible_mutex);

        if(visible) {
            visible = false;
            hide();
        } else {
            visible = true;

            if(!shown) {
                shown = true;
                show();
            }

            present();
        }
    }
};

}

#endif
