#!/bin/sh
echo $(~/.local/scripts/sb_battery icon)

#󰂁
#case "$(cat /sys/class/power_supply/BAT*/capacity)" in
#    [0-9])
#	echo 󰂃
#	;;
#    1[0-9])
#	echo 󰂃
#	;;
#    2[0-9])
#	echo 󰁼
#	;;
#    3[0-9])
#	echo 󰁽
#	;;
#    4[0-9])
#	echo 󰁾
#	;;
#    5[0-9])
#	echo 󰁿
#	;;
#    6[0-9])
#	echo 󰂀
#	;;
#    7[0-9])
#	echo 󰂁
#	;;
#    8[0-9])
#	echo 󰂂
#	;;
#    9[0-9])
#	echo 󰁹
#	;;
#    100)
#	echo "Unplug the Charger"
#	;;
#    *)
#	echo 󰂃
#	;;
#esac
