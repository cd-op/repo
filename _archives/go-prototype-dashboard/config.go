package dashboard

import (
	"dashboard/ui"
	"fmt"
	"os"
	"os/exec"
	"os/signal"
	"syscall"
	"time"
)

const width = 1200
const height = 700

func Configure() {
	clock, window := layout()

	handleClock(clock)
	onSignal(syscall.SIGUSR1, window.ToggleVisibility)
}

func layout() (*ui.LabelComponent, *ui.WindowComponent) {
	clock := ui.Label("")
	w := ui.Window(width, height)

	w.Children(ui.VBox(30,
		clock,

		ui.VBox(10,
			ui.Button("Abiword", "abiword", launchfn(w, "abiword")),
			ui.Button("Alacritty", "Alacritty", launchfn(w, "alacritty")),
			ui.Button("Brave", "brave", launchfn(w, "brave")),
			ui.Button("Gnumeric", "gnumeric", launchfn(w, "gnumeric")),
			ui.Button("KeepassXC", "keepassxc", launchfn(w, "keepassxc")),
			ui.Button("Leafpad", "leafpad", launchfn(w, "leafpad")),
			ui.Button("Lutris", "lutris", launchfn(w, "lutris")),
			ui.Button("Thunderbird", "mozilla-thunderbird", launchfn(w, "thunderbird")),
			ui.Button("Spacefm", "file-manager", launchfn(w, "spacefm")),
		),

		ui.VBox(10,
			ui.Button("Hexchat", "hexchat", launchfn(w, "hexchat", "--existing")),
			ui.Button("Signal", "signal-desktop", launchfn(w, "apulse", "signal-desktop")),
			ui.Button("Telegram", "telegram", launchfn(w, "telegram-desktop")),
		),

		ui.HBox(10,
			ui.ImageFromIcon("audio-speakers-symbolic"),
			ui.HScale(0, 100, 5, func(value float64) {
				spawn("amixer", "sset", "-c", "HDMI", "speakers",
					"--", fmt.Sprintf("%d%%", int(value)))
			}),
			ui.Button("Mixer", "audio-speakers-symbolic",
				spawnfn("alacritty", "-e", "alsamixer", "-c", "HDMI")),

			ui.ImageFromIcon("audio-headphones-symbolic"),
			ui.HScale(0, 100, 5, func(value float64) {
				spawn("amixer", "sset", "-c", "Generic", "Master",
					"--", fmt.Sprintf("%d%%", int(value)))
			}),
			ui.Button("Mixer", "audio-headphones-symbolic",
				spawnfn("alacritty", "-e", "alsamixer", "-c", "Generic")),

			ui.Button("Mixer", "audio-input-microphone-symbolic",
				spawnfn("alacritty", "-e", "alsamixer", "-c", "Mini")),
		),

		ui.HBox(10,
			ui.Button("On", "redshift", func() {
				waitFor("redshift", "-x")
				spawn("redshift", "-O", "3000")
			}),
			ui.Button("Off", "redshift", spawnfn("redshift", "-x")),

			ui.Button("Window/Region", "applets-screenshooter-symbolic",
				launchfn(w, "scrot", "-s")),
			ui.Button("1080p60", "monitor",
				spawnfn("xrandr", "--output", "HDMI-A-0", "--mode", "1920x1080")),
			ui.Button("UW100Hz", "monitor",
				spawnfn("xrandr", "--output", "HDMI-A-0", "--mode", "2560x1080",
					"--rate", "100")),

			ui.Button("EN/US (normal)", "keyboard",
				spawnfn("setxkbmap", "us")),
			ui.Button("EN/US (dvorak)", "keyboard",
				spawnfn("setxkbmap", "us",
					"-variant", "dvorak",
					"-option", "compose:ralt")),

			ui.Button("Reboot", "system-reboot",
				launchfn(w, "alacritty", "-e", "sudo", "reboot")),
			ui.Button("Poweroff", "system-shutdown",
				launchfn(w, "alacritty", "-e", "sudo", "poweroff")),
		),
	))

	return clock, w
}

func onSignal(sig os.Signal, fn func()) {
	go func() {
		ch := make(chan os.Signal, 1)
		signal.Notify(ch, sig)

		for {
			<-ch
			go fn()
		}
	}()
}

func handleClock(c *ui.LabelComponent) {
	go func() {
		for {
			now := time.Now()
			c.UpdateMarkup(formatClock(now))
			time.Sleep(time.Until(nextMin(now)))
		}
	}()
}

func nextMin(t time.Time) time.Time {
	y, mo, d := t.Date()
	h, mi, _ := t.Clock()
	return time.Date(y, mo, d, h, mi+1, 0, 0, t.Location())
}

func formatClock(t time.Time) string {
	return t.Format("Mon, Jan 02\n") +
		`<span size="300%">` + t.Format("15:04") + `</span>`
}

func launchfn(w *ui.WindowComponent, prog string, args ...string) func() {
	return func() {
		w.Hide()
		spawn(prog, args...)
	}
}

func spawnfn(prog string, args ...string) func() {
	return func() {
		spawn(prog, args...)
	}
}

func spawn(prog string, args ...string) {
	go start(prog, args...).Wait()
}

func waitFor(prog string, args ...string) {
	start(prog, args...).Wait()
}

func start(prog string, args ...string) *exec.Cmd {
	c := exec.Command(prog, args...)
	c.Start()

	return c
}
