#!/bin/bash
source ~/.config/dwm/scripts/vars.sh
echo "^c$BLUE^ 82"

case "$BLOCK_BUTTON" in
	1) notify-send -i ~/pix/assets/icons/battery-full-solid.svg -a scripts -r 13 "battery" "$(sb_battery perc)" ;;
esac
