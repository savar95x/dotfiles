#!/bin/sh
pkill pipewire; pkill mpd
pgrep pipewire || setsid -f pipewire &
sleep 1
pgrep pipewire && pgrep pipewire-pulse || setsid -f pipewire-pulse &
sleep 1
pgrep pipewire && pgrep pipewire-pulse && pgrep wireplumber || setsid -f wireplumber &
sleep 1
pgrep pipewire && pgrep pipewire-pulse && pgrep wireplumber && pgrep mpd || setsid -f mpd &
sleep 1
#setsid -f pulsemixer
mpd
exit
