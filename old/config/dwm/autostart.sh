#!/bin/sh
if hash picom >/dev/null 2>&1; then
	pkill picom
	picom --config "$HOME/.local/share/themes/gruv/config/picom.conf" &
  # 	$HOME/.local/src/picom-pijulius/build/src/picom --config $HOME/.config/picom.conf.pijulius -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 &
#    $HOME/.local/src/picom-pijulius/build/src/picom --config $HOME/.config/picom.conf.pijulius
  #  $HOME/.local/src/picom-ftlabs/build/src/picom --config $HOME/.config/picom.conf.ftlabs
fi

if hash xbanish >/dev/null 2>&1; then
	pkill xbanish
	xbanish -t 1 &
fi

if hash dwmblocks >/dev/null 2>&1; then
	pkill dwmblocks
	dwmblocks &
fi

#if hash eww >/dev/null 2>&1; then
	#pkill eww
	#eww daemon #&& $HOME/.config/eww/bin/launcher open &
#fi

if hash redshift >/dev/null 2>&1; then
	pkill redshift
	redshift -P -O 6500
	redshift &
fi

### quality of life ###
#xwallpaper --tile $HOME/pix/walls/openbox-paper-tile.png #flowers-right.jpg
xwallpaper --zoom $HOME/pix/walls/gruvbox/aristotle-gruv.png #flowers-right.jpg
xset r rate 215 40
#xset r rate 200 30
xrdb -load $HOME/.config/x11/xresources
setxkbmap -option caps:swapescape 

# audio dameon
$HOME/.config/dwm/audio_server.sh &
