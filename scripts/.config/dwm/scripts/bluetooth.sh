#!/bin/bash
DIR=~/.config/dwm/scripts
source $DIR/vars.sh

dev="$(bluetoothctl devices Connected | cut -d' ' -f3- | sed 's/^[ \t]*//;s/[ \t]*$//')"

if [ "$dev" ]; then
	echo "^c$FG^^b$BG^   $dev"
fi
