#!/bin/sh
DIR=~/.config/dwm/scripts
. $DIR/vars.sh

pkill -RTMIN+13 dwmblocks
case "$BLOCK_BUTTON" in
	1) $DIR/bar/control_center & ;;
esac

echo "^c$FG^^b$BG^"
#if eww active-windows | grep -q control_center; then
#echo "^c$FG^^b$BG^"
#else
#echo "^c#81A89F^^b$BG^"
#fi
