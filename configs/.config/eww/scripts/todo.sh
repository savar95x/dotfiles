#!/bin/sh
while read l; do
	if [ "$l" = "" ]; then
		echo ""
	else
		echo "-  $(echo $l | cut -d'>' -f1)"
	fi
done < ~/dox/todo

notify-send "Eww" "Todo Restarted"
xdo lower -N Eww
