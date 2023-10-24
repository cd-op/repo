#ifndef _UI_BUTTON_H_
#define _UI_BUTTON_H_

#include <gtkmm.h>

namespace ui
{

class ButtonWidget: public Gtk::Button
{
    void (*on_click)() = nullptr;

  public:
    ButtonWidget(char const * const text,
                 char const * const icon,
                 void(*on_click_fn)()):
        Gtk::Button(),
        on_click(on_click_fn)
    {
        auto box = Gtk::manage(new Gtk::Box(Gtk::Orientation::HORIZONTAL, 4));
        box->set_halign(Gtk::Align::CENTER);

        if(icon != nullptr && icon[0] != 0) {
            auto image = Gtk::manage(new Gtk::Image());
            image->set_from_icon_name(icon);
            box->append(*image);
        }

        if(text != nullptr && text[0] != 0) {
            auto label = Gtk::manage(new Gtk::Label(text));
            box->append(*label);
        }

        this->set_child(*box);
    }

    void on_clicked()
    {
        if(on_click != nullptr) {
            on_click();
        }
    }
};

ButtonWidget & Button(char const * const text,
                      char const * const icon,
                      void(*on_click_fn)())
{
    auto button = Gtk::manage(new ButtonWidget(text, icon, on_click_fn));
    return *button;
}

}

#endif
