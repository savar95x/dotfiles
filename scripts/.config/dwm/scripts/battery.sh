#!/bin/bash
source ~/.config/dwm/scripts/vars.sh
echo "^c$FG^$(sb_battery icon)"
sb_battery notify_critical &

case "$BLOCK_BUTTON" in
	1) notify-send -i ~/pix/assets/icons/battery-full-solid.svg -a scripts -r 13 "Battery" "$(sb_battery perc) / $(cat /sys/class/power_supply/BAT1/status)" ;;
esac
