#ifndef _UI_BOXES_H_
#define _UI_BOXES_H_

#include <gtkmm.h>

namespace ui
{

class BoxWidget: public Gtk::Box
{
  public:
    BoxWidget(Gtk::Orientation orientation, int spacing):
        Gtk::Box(orientation, spacing) {}

    BoxWidget & add(Gtk::Widget & w)
    {
        append(w);
        return *this;
    }
};

BoxWidget & HBox(int spacing)
{
    auto box = Gtk::manage(
                   new BoxWidget(Gtk::Orientation::HORIZONTAL, spacing));

    return *box;
}

BoxWidget & VBox(int spacing)
{
    auto box = Gtk::manage(
                   new BoxWidget(Gtk::Orientation::VERTICAL, spacing));

    return *box;
}

BoxWidget & BoundingBox(int margin)
{
    auto box = Gtk::manage(
                   new BoxWidget(Gtk::Orientation::VERTICAL, 0));

    box->set_margin_top(margin);
    box->set_margin_bottom(margin);
    box->set_margin_start(margin);
    box->set_margin_end(margin);

    return *box;
}

}

#endif
