#!/bin/bash
if [ "$(mpc current)" = "" ]; then
	if [ "$1" = "artist" ]; then
		echo "Not Playing"
	elif [ "$1" = "title" ]; then
		echo "Music"
	fi
else
	if [ "$1" = "artist" ]; then
		artist="$(mpc -f "%artist%" current | cut -d'/' -f1)"
		printf "%s" "${artist:0:25}"
		if [ $(echo "$artist" | wc -m) -gt 25 ]; then
			echo "..."
		fi
	elif [ "$1" = "title" ]; then
		title="$(mpc -f "%title%" current | cut -d'(' -f1)"
		title="$(printf '%s\n' "$title" | sed 's/[[:space:]]*$//')"
		printf "%s" "${title:0:25}"
		if [ $(echo "$title" | wc -m) -gt 25 ]; then
			echo "..."
		fi
	fi
fi
