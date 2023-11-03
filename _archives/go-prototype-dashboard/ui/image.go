package ui

import (
	"log"

	"github.com/gotk3/gotk3/gtk"
)

func ImageFromIcon(name string) *ImageComponent {
	gtkI, err := gtk.ImageNewFromIconName(name, gtk.ICON_SIZE_BUTTON)
	if err != nil {
		log.Fatal("failed to create image:", err)
	}

	return &ImageComponent{
		u: gtkI,
	}
}

// TODO: ImageFromPath()

type ImageComponent struct {
	u *gtk.Image
}

func (i *ImageComponent) unwrap() gtk.IWidget {
	return i.u
}
