#!/bin/sh
if hash picom >/dev/null 2>&1; then
	pkill picom
	setsid -f picom --config $HOME/.config/2bwm/picom.conf &
fi

if hash polybar >/dev/null 2>&1; then
	pkill polybar
	setsid -f polybar date &
	setsid -f polybar power &
	setsid -f polybar battery &
	setsid -f polybar tags &
	setsid -f polybar search &
	#sleep 1 && setsid -f polybar dummy &
	sleep 1 && setsid -f polybar dummy && sleep 1 && polybar-msg -p $(xdotool search --name dummy getwindowpid) cmd toggle &
fi

if hash xbanish >/dev/null 2>&1; then
	pkill xbanish
	setsid -f xbanish -t 1 &
fi

if hash redshift >/dev/null 2>&1; then
	pkill redshift
	redshift -P -O 6500
	setsid -f redshift &
fi

### quality of life ###
xwallpaper --zoom ~/.config/2bwm/walls/berries.jpg &
#xwallpaper --zoom "$HOME/.config/2bwm/walls/$(ls $HOME/.config/2bwm/walls/ | shuf | head -n 1)"
xset r rate 215 40
xsetroot -cursor_name left_ptr
xrdb -load $HOME/.config/x11/xresources
setxkbmap -option caps:swapescape 

# audio dameon
$HOME/.config/2bwm/audio_server.sh &
