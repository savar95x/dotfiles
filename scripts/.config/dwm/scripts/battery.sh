#!/bin/bash
source ~/.config/dwm/scripts/vars.sh
battery="$(sb_battery perc)"
if [ $battery -gt 20 ]; then
	echo "^c$FG^$(sb_battery icon)    ^c$INACTIVE^$battery^c$FG^"
else
	echo "^c$RED^    ^c$INACTIVE^$(sb_battery perc)^c$FG^"
fi

sb_battery notify_critical &

case "$BLOCK_BUTTON" in
	1) notify-send -i ~/pix/assets/icons/battery-full-solid.svg -a scripts -r 13 "Battery" "$(sb_battery perc) / $(cat /sys/class/power_supply/BAT1/status)" ;;
esac
