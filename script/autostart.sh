#!/usr/bin/env bash

~/script/set_screens.sh
lxpolkit &w
dunst &
pcmanfm -d --no-desktop &
xcompmgr -c -t-5 -l-5 -r4.2 -o.55 &
~/script/background_switch.py &
~/script/update.sh &
redshift &
#uget-gtk &

#xprop -root -format _NET_DESKTOP_LAYOUT 32c -set _NET_DESKTOP_LAYOUT 0,3,3,0
#volumeicon &
#compton --config ~/.config/compton.conf -b &
#tint2 &
#conky -c ~/.config/conky.conf &
