#!/bin/bash
source ~/.config/dwm/scripts/vars.sh
echo "^c$BG^^b$GREEN^ CPU ^c$FG^^b$BGALT^ $(grep -o '^[^ ]*' /proc/loadavg)"
