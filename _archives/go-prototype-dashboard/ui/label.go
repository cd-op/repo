package ui

import (
	"log"

	"github.com/gotk3/gotk3/gtk"
)

func Label(markup string) *LabelComponent {
	gtkL, err := gtk.LabelNew("")
	if err != nil {
		log.Fatal("failed to create label:", err)
	}

	gtkL.SetJustify(gtk.JUSTIFY_CENTER)
	gtkL.SetMarkup(markup)

	return &LabelComponent{
		u: gtkL,
	}
}

type LabelComponent struct {
	u *gtk.Label
}

func (l *LabelComponent) unwrap() gtk.IWidget {
	return l.u
}

func (l *LabelComponent) UpdateMarkup(markup string) {
	l.u.SetMarkup(markup)
}
