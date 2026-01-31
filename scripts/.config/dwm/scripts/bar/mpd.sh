#!/bin/bash
# run this once
# setsid -f $HOME/.config/dwm/scripts/dwm/mpd.sh
while true; do
	mpc idle player > /dev/null
	kill -35 $(pidof dwmblocks)
done
