#!/bin/sh
DIR=~/.config/dwm/scripts
. $DIR/vars.sh

echo "^c$FG^^b$BG^"

case "$BLOCK_BUTTON" in
	1) $DIR/bar/control_center & ;;
esac
