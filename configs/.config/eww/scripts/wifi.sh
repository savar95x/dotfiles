#!/bin/bash
case "$(cat /sys/class/net/wl*/operstate 2>/dev/null)" in
	up) echo "$(iwctl station wlan0 show | grep "Connected network" | cut -d' ' -f19- | sed 's/^[ \t]*//;s/[ \t]*$//')" ;;
	down) echo "Disconnected" ;;
esac
