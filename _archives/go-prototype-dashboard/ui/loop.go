package ui

import "github.com/gotk3/gotk3/gtk"

func Loop(fn func()) {
	gtk.Init(nil)
	fn()
	gtk.Main()
}
