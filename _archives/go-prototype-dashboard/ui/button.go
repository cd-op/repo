package ui

import (
	"log"

	"github.com/gotk3/gotk3/gtk"
)

func Button(text, image string, onClick func()) *ButtonComponent {
	gtkB, err := gtk.ButtonNew()
	if err != nil {
		log.Fatal("failed creating button:", err)
	}

	if image != "" {
		gtkI := ImageFromIcon(image)
		gtkB.SetImage(gtkI.u)
		gtkB.SetAlwaysShowImage(true)
	}

	gtkB.SetLabel(text)
	gtkB.Connect("clicked", onClick)

	return &ButtonComponent{
		u: gtkB,
	}
}

type ButtonComponent struct {
	u *gtk.Button
}

func (b *ButtonComponent) unwrap() gtk.IWidget {
	return b.u
}
