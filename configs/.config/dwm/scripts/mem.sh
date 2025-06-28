#!/bin/bash
source ~/.config/dwm/scripts/vars.sh
echo "^c$BLUE^^b$BGALT3^  $(free -h | awk '/^Mem/ { print $3 }' | sed s/i//g)"
