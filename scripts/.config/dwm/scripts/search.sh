#!/bin/sh
DIR=~/.config/dwm/scripts
source $DIR/vars.sh

echo ""
case "$BLOCK_BUTTON" in
	1) rofi -show drun & ;;
esac
