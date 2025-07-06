#!/bin/bash
source ~/.config/dwm/scripts/vars.sh
echo "^c$RED^ $(light -G | cut -d'.' -f1)"

case "$BLOCK_BUTTON" in
	1) notify-send -i ~/pix/assets/icons/sun-solid.svg -a scripts -r 15 "light" "$(light -G)" ;;
esac
