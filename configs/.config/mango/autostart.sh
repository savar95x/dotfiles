#!/bin/sh
export TERMINAL=foot
pkill swaybg; setsid -f swaybg -i "$(ls -1 ~/pix/walls/new/* | shuf -n 1)" -m fill &
pkill waybar; setsid -f ~/.local/repos/waybar/Waybar/build/waybar -c ~/.config/waybar/config.jsonc &
# a freshly started waybar is always visible; keep scripts/bar.sh in sync
~/.config/mango/scripts/bar.sh reset
# watcher that keeps the bar in sync with the focused tag: it hides the bar
# while that tag is in monocle fullscreen and brings it back on every other
# tag. It reconnects by itself when mango is restarted.
pkill -f monocle_fs_watch.sh; setsid -f ~/.config/mango/scripts/monocle_fs_watch.sh &
exit
