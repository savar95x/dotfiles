#!/bin/zsh
source ~/.config/dwm/scripts/vars.sh
echo "^c$FG^^b$BG^$(date '+%d %b')  $(date '+%H:%M')"

case "$BLOCK_BUTTON" in
	1) dunstify -i ~/pix/assets/icons/clock-solid.svg -a scripts -r "93434" "Date" "$(date '+%d %b (%a) %Y\n%H\:%M\:%S')" ;;
	3) echo "$(date '+%d %b %Y, %a  %I:%M %P')" | xclip -r -sel clipboard ;;
esac
