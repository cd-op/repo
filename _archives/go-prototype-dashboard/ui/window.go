package ui

import (
	"log"
	"sync"

	"github.com/gotk3/gotk3/gdk"
	"github.com/gotk3/gotk3/gtk"
)

func Window(w, h int) *WindowComponent {
	gtkW, err := gtk.WindowNew(gtk.WINDOW_TOPLEVEL)

	if err != nil {
		log.Fatal("failed to create window:", err)
	}

	gtkW.SetDecorated(false)
	gtkW.SetResizable(false)
	gtkW.SetSkipPagerHint(true)
	gtkW.SetSkipTaskbarHint(true)
	gtkW.SetKeepAbove(true)
	gtkW.SetModal(true)
	gtkW.SetGravity(gdk.GDK_GRAVITY_CENTER)
	gtkW.SetDefaultSize(w, h)
	gtkW.Stick()
	gtkW.Connect("destroy", func() {
		gtk.MainQuit()
	})

	return &WindowComponent{
		u: gtkW,
	}
}

type WindowComponent struct {
	visibleMutex sync.Mutex
	visible      bool
	shown        bool
	u            *gtk.Window
	topw         *gtk.Window
}

func (w *WindowComponent) Children(children ...Component) {
	gtkB, err := gtk.BoxNew(gtk.ORIENTATION_VERTICAL, 0)
	if err != nil {
		log.Fatal("failed to create window box:", err)
	}

	gtkB.SetMarginTop(30)
	gtkB.SetMarginBottom(30)
	gtkB.SetMarginStart(30)
	gtkB.SetMarginEnd(30)

	w.u.Add(gtkB)
	for _, c := range children {
		gtkB.Add(c.unwrap())
	}
}

func (w *WindowComponent) unwrap() gtk.IWidget {
	return w.u
}

func (w *WindowComponent) Quit() {
	gtk.MainQuit()
}

func (w *WindowComponent) ToggleVisibility() {
	w.visibleMutex.Lock()
	defer w.visibleMutex.Unlock()

	if w.visible {
		w.visible = false
		w.u.Hide()
	} else {
		w.visible = true
		if !w.shown {
			w.shown = true
			w.u.ShowAll()
		}
		w.u.Present()
	}
}

func (w *WindowComponent) Hide() {
	w.visibleMutex.Lock()
	defer w.visibleMutex.Unlock()

	w.visible = false
	w.u.Hide()
}

func (w *WindowComponent) Show() {
	w.visibleMutex.Lock()
	defer w.visibleMutex.Unlock()

	w.visible = true
	if !w.shown {
		w.shown = true
		w.u.ShowAll()
	}
	w.u.Present()
}
