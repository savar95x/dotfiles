#!/bin/bash
DIR=~/.config/dwm/scripts
source $DIR/vars.sh

case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) echo "^c$FG^^b$BG^" ;;
	down) echo "^c$BGALT2^^b$BG^^c$FG^" ;;
esac

case "$BLOCK_BUTTON" in
	1) notify-send -i ~/pix/assets/icons/wifi-solid.svg -a scripts -r 12 "Wifi" "$(iwctl station wlan0 show | grep "Connected network" | cut -d' ' -f19-)" ;;
	3) iwctl station wlan0 scan; sleep 5; iwctl station wlan0 connect phone_1; sleep 1; pkill -RTMIN+16 dwmblocks ;;
esac
