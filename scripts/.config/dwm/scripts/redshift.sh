#!/bin/sh
DIR=~/.config/dwm/scripts
. $DIR/vars.sh

echo "^c$FG^"

val=$(vibrant-cli eDP-1 | grep eDP | cut -d' ' -f5)

case "$BLOCK_BUTTON" in
	1) vibrant-cli eDP-1 1 & ;;
	3) vibrant-cli eDP-1 0 & ;;
esac
