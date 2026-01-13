#!/bin/sh
if hash redshift >/dev/null 2>&1; then
	pkill redshift
	redshift -P -O 6500
	setsid -f redshift &
fi
pkill picom; setsid -f picom --config $HOME/.config/dwm/assets/picom/active.conf &
pkill dunst; setsid -f dunst &
pkill dwmblocks; setsid -f sleep 1 && dwmblocks &
#pkill eww; eww daemon & eww open todo & eww open at-a-glance & sleep 1; eww open quote &

### quality of life ###
xwallpaper --zoom "$(ls -1 ~/pix/walls/new/* | shuf -n 1)"
xset r rate 215 40
setxkbmap -option caps:swapescape 
xrdb -load $HOME/.config/x11/xresources

sleep 2 && xdo lower -n eww

exit

# audio dameon
#$HOME/.config/dwm/audio_server.sh &

#if hash dwmblocks >/dev/null 2>&1; then
	#pkill dwmblocks
	#setsid -f dwmblocks &
#fi

#xsetroot -name "^v^^c#FFFFFF^ ^t^$(mpc -f "%artist% - %title%" current)  ^r0,7,2,4^^r2,4,22,10^^c#000000^^r3,5,20,8^^c#ffffff^^r10,5,13,8^^d^^f24^ [status2d] ^c#FF0000^red text with blue rectangle^c#55cdfc^  ^r3,3,14,24^^f20^^c#FFFFFF^^b#f7a8b8^ and white text on pink background "

#pkill picom; setsid -f picom --config ~/.config/xmonad/assets/picom/pijulius.conf &
#pkill picom; setsid -f ~/.config/xmonad/assets/picom-ftlabs --config ~/.config/xmonad/assets/picom/ftlabs.conf &
#pkill picom; setsid -f ~/.config/xmonad/assets/picom-pijulius --config ~/.config/xmonad/assets/picom/pijulius.conf &
