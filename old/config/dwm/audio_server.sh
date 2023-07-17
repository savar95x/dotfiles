#!/bin/sh
pgrep pipewire || setsid -f pipewire &
sleep 1
pgrep pipewire && pgrep pipewire-pulse || setsid -f pipewire-pulse &
sleep 1
pgrep pipewire && pgrep pipewire-pulse && pgrep wireplumber || setsid -f wireplumber &
sleep 1
pgrep pipewire && pgrep pipewire-pulse && pgrep wireplumber && pgrep mpd || setsid -f mpd &
#pgrep pipewire && pgrep pipewire-pulse && pgrep mpd && pgrep mpd_notify || setsid -f $HOME/.local/binbg/mpd_notify & # currently depends on mpc (for notify and cli), mpDris (for playerctl support), and playerctl (for global audio control)
