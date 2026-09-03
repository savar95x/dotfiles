#!/bin/sh
export TERMINAL=foot
setsid -f swaybg -i "$(ls -1 ~/pix/walls/new/* | shuf -n 1)" -m fill &
pkill waybar; setsid -f ~/.local/repos/waybar/Waybar/build/waybar -c ~/.config/waybar/config.jsonc &
exit
