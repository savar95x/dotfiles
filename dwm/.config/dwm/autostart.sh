#!/bin/sh
if hash picom >/dev/null 2>&1; then
	pkill picom
	setsid -f picom --config $HOME/.config/dwm/picom.conf &
	#--config "$HOME/.local/share/themes/gruv/config/picom.conf" &
	#$HOME/.local/src/picom-pijulius/build/src/picom --config $HOME/.config/picom.conf.pijulius -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 &
	#$HOME/.local/src/picom-pijulius/build/src/picom --config $HOME/.config/picom.conf.pijulius
	#$HOME/.local/src/picom-ftlabs/build/src/picom --config $HOME/.config/picom.conf.ftlabs
fi

if hash xbanish >/dev/null 2>&1; then
	pkill xbanish
	setsid -f xbanish -t 1 &
fi

if hash dwmblocks >/dev/null 2>&1; then
	pkill dwmblocks
	setsid -f dwmblocks &
fi

if hash redshift >/dev/null 2>&1; then
	pkill redshift
	redshift -P -O 6500
	setsid -f redshift &
fi

### quality of life ###
xwallpaper --zoom ~/pix/walls/gruvbox/gruvbox_astro.jpg
#xwallpaper --zoom ~/pix/walls/gruvbox/flower-1.jpg
xset r rate 215 40
xrdb -load $HOME/.config/x11/xresources
setxkbmap -option caps:swapescape 

# audio dameon
#$HOME/.config/dwm/audio_server.sh &
