#!/bin/sh

xrandr     --output HDMI-A-0 --primary --mode 2560x1080 --rate 100
setxkbmap  us -variant dvorak -option compose:ralt
xcape      -e "Super_L=Super_L|BackSpace"

knobs &
exec /usr/bin/i3
