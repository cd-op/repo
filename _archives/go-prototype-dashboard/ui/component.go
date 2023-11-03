package ui

import "github.com/gotk3/gotk3/gtk"

type Component interface {
	unwrap() gtk.IWidget
}
