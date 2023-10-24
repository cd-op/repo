#ifndef _UI_LABEL_H_
#define _UI_LABEL_H_

#include <gtkmm.h>

namespace ui
{

class LabelWidget: public Gtk::Label
{
  public:
    LabelWidget(char const * const markup): Gtk::Label()
    {
        set_justify(Gtk::Justification::CENTER);
        set_markup(markup);
    }
};

LabelWidget * Label(char const * const markup)
{
    return Gtk::manage(new LabelWidget(markup));
}

}

#endif
