#!/bin/sh

( aplay  x/local/config/sounds/silence.wav &&
  amixer sset -c HDMI        'IEC958',3 on &&
  amixer sset -c HDMI        'speakers' 0% &&
  amixer sset -c Generic     'Master'   0% ) &

xrandr     --output HDMI-A-0 --primary --mode 2560x1080 --rate 100
setxkbmap  us -variant dvorak -option compose:ralt
xcape      -e "Super_L=Super_L|BackSpace"

dashboard &
exec /usr/bin/i3
