#!/bin/bash
DIR=~/.config/dwm/scripts
source $DIR/vars.sh

# 1. Handle the click FIRST
case "$BLOCK_BUTTON" in
	1) (mpc toggle; pkill -RTMIN+1 dwmblocks) & ;;
	3) (st -c 'floating' -g 80x16 -e ncmpcpp) & ;;
esac

# 2. Then check the status (which is now updated)
if [ "$(mpc current)" = "" ]; then
    echo ""
else
    # Store status in a variable to avoid calling mpc twice
    status=$(mpc status)
    
    # Logic to pick icon
    if echo "$status" | grep -q "\[playing\]"; then
        echo "^c$FG^^b$BG^"
    elif echo "$status" | grep -q "\[paused\]"; then
        echo "^c$FG^^b$BG^"
    fi
fi
