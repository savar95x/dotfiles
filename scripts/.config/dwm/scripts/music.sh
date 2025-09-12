#!/bin/bash
DIR=~/.config/dwm/scripts
source $DIR/vars.sh

if [ "$(mpc current)" = "" ]; then
	echo ""
else
	title=$(mpc -f "%title%" current | cut -d'(' -f1)
	title=$(printf '%s\n' "$title" | sed 's/[[:space:]]*$//')
	artist=$(mpc -f "%artist%" current | cut -d'/' -f1)
	#mpc -f "%title% - %artist%" current
	echo "^c$FG^^b$BG^  $title - $artist"
fi
case "$BLOCK_BUTTON" in
	1) setsid -f st -e ncmpcpp & ;;
esac
