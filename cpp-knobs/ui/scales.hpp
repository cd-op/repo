#ifndef _UI_SCALES_H_
#define _UI_SCALES_H_

#include <gtkmm.h>

namespace ui
{

class ScaleWidget: public Gtk::Scale
{
    void (*on_change)(double) = nullptr;

  public:
    ScaleWidget(Gtk::Orientation orientation,
                double min,
                double max,
                void (*on_change_fn)(double)):
        Gtk::Scale(orientation),
        on_change(on_change_fn)
    {
        set_range(min, max);
        signal_value_changed().connect([=]() {
            this->on_change(this->get_value());
        });
    }
};

Gtk::Scale & HScale(double min, double max, void (*on_change_fn)(double))
{
    auto scale = Gtk::manage(new ScaleWidget(
                                 Gtk::Orientation::HORIZONTAL, min, max, on_change_fn));

    scale->set_hexpand(true);

    return *scale;
}

Gtk::Scale & VScale(double min, double max, void (*on_change_fn)(double))
{
    auto scale = Gtk::manage(new ScaleWidget(
                                 Gtk::Orientation::VERTICAL, min, max, on_change_fn));

    scale->set_vexpand(true);

    return *scale;
}

}

#endif

