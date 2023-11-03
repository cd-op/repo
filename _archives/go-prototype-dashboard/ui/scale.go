package ui

import (
	"log"

	"github.com/gotk3/gotk3/gtk"
)

func HScale(min, max, step float64, onChange func(float64)) *ScaleComponent {
	s := scale(min, max, step, gtk.ORIENTATION_HORIZONTAL, onChange)
	s.u.SetHExpand(true)

	return s
}

func VScale(min, max, step float64, onChange func(float64)) *ScaleComponent {
	s := scale(min, max, step, gtk.ORIENTATION_VERTICAL, onChange)
	s.u.SetVExpand(true)

	return s
}

func scale(
	min, max, step float64,
	orientation gtk.Orientation,
	onChange func(float64)) *ScaleComponent {

	gtkS, err := gtk.ScaleNewWithRange(gtk.ORIENTATION_HORIZONTAL, min, max, step)
	if err != nil {
		log.Fatal("failed to create hscale:", err)
	}

	gtkS.SetDrawValue(false)
	gtkS.Connect("value-changed", func(s *gtk.Scale) {
		onChange(s.GetValue())
	})

	return &ScaleComponent{
		u: gtkS,
	}
}

type ScaleComponent struct {
	u *gtk.Scale
}

func (s *ScaleComponent) unwrap() gtk.IWidget {
	return s.u
}
