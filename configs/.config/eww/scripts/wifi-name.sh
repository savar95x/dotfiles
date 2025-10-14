#!/bin/sh
name="$(iwctl station wlan0 show | grep "Connected network" | cut -d' ' -f19- | sed 's/^[ \t]*//;s/[ \t]*$//')"
if [ "$name" ];then
	echo "$name"
else
	echo "none"
fi
