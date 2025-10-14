#!/bin/sh
perc=$(cat /sys/class/power_supply/BAT*/capacity)
~/.local/scripts/sb_battery notify_critical &
echo ${perc}%
