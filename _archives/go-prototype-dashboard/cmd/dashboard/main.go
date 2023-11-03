package main

import (
	"dashboard"
	"dashboard/ui"
)

func main() {
	ui.Loop(dashboard.Configure)
}
