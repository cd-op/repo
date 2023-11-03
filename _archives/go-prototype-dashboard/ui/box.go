package ui

import (
	"log"

	"github.com/gotk3/gotk3/gtk"
)

func HBox(spacing int, children ...Component) *BoxComponent {
	return box(spacing, gtk.ORIENTATION_HORIZONTAL, children)
}

func VBox(spacing int, children ...Component) *BoxComponent {
	return box(spacing, gtk.ORIENTATION_VERTICAL, children)
}

func box(
	spacing int, orientation gtk.Orientation,
	children []Component) *BoxComponent {

	gtkB, err := gtk.BoxNew(orientation, spacing)
	if err != nil {
		log.Fatal("failed to create box:", err)
	}

	for _, c := range children {
		gtkB.Add(c.unwrap())
	}

	return &BoxComponent{
		u: gtkB,
	}
}

type BoxComponent struct {
	u *gtk.Box
}

func (b *BoxComponent) unwrap() gtk.IWidget {
	return b.u
}
