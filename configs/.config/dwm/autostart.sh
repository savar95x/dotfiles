#!/bin/sh
#if hash picom >/dev/null 2>&1; then
	#pkill picom
	#setsid -f picom --config $HOME/.config/dwm/picom.conf &
	##--config "$HOME/.local/share/themes/gruv/config/picom.conf" &
	##$HOME/.local/src/picom-pijulius/build/src/picom --config $HOME/.config/picom.conf.pijulius -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 &
	##$HOME/.local/src/picom-pijulius/build/src/picom --config $HOME/.config/picom.conf.pijulius
	##$HOME/.local/src/picom-ftlabs/build/src/picom --config $HOME/.config/picom.conf.ftlabs
#fi
#
#if hash xbanish >/dev/null 2>&1; then
	#pkill xbanish
	#setsid -f xbanish -t 1 &
#fi
#
#if hash dwmblocks >/dev/null 2>&1; then
	#pkill dwmblocks
	#setsid -f dwmblocks &
#fi
#
if hash redshift >/dev/null 2>&1; then
	pkill redshift
	redshift -P -O 6500
	setsid -f redshift &
fi
pkill picom; setsid -f picom --config $HOME/.config/dwm/picom.conf &
pkill dunst; setsid -f dunst &
#pkill picom; setsid -f picom
#pkill xbanish; setsid -f xbanish -t 1 &
pkill dwmblocks; setsid -f sleep 1 && dwmblocks &
#xsetroot -name "^v^^c#FFFFFF^ ^t^$(mpc -f "%artist% - %title%" current)  ^r0,7,2,4^^r2,4,22,10^^c#000000^^r3,5,20,8^^c#ffffff^^r10,5,13,8^^d^^f24^ [status2d] ^c#FF0000^red text with blue rectangle^c#55cdfc^  ^r3,3,14,24^^f20^^c#FFFFFF^^b#f7a8b8^ and white text on pink background "
#pkill redshift; setsid -f redshift &

### quality of life ###
xwallpaper --zoom ~/.config/dwm/walls/wall.jpg
#xwallpaper --zoom ~/pix/walls/gruvbox/flower-1.jpg
xset r rate 215 40
setxkbmap -option caps:swapescape 
##xrdb -load $HOME/.config/x11/xresources

# audio dameon
#$HOME/.config/dwm/audio_server.sh &
exit
