#!/bin/bash
dev="$(bluetoothctl devices Connected | cut -d' ' -f3- | sed 's/^[ \t]*//;s/[ \t]*$//')"

if [ "$dev" ]; then
	echo "$dev"
else
	echo "Off"
fi
