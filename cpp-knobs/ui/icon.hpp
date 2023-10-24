#ifndef _UI_ICON_H_
#define _UI_ICON_H_

#include <gtkmm.h>

namespace ui
{

class IconWidget: public Gtk::Image
{
  public:
    IconWidget(char const * const name): Gtk::Image()
    {
        set_from_icon_name(name);
    }
};

IconWidget & Icon(char const * const name)
{
    auto icon = Gtk::manage(new IconWidget(name));
    return *icon;
}

}

#endif
