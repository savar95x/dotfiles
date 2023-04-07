#!/bin/sh
if hash picom >/dev/null 2>&1; then
	pkill picom
	picom --config "$HOME/.local/share/themes/newtheme/config/picom.conf" &
  # 	$HOME/.local/src/picom-pijulius/build/src/picom --config $HOME/.config/picom.conf.pijulius -b --animations --animation-window-mass 0.5 --animation-for-open-window zoom --animation-stiffness 350 &
#    $HOME/.local/src/picom-pijulius/build/src/picom --config $HOME/.config/picom.conf.pijulius
  #  $HOME/.local/src/picom-ftlabs/build/src/picom --config $HOME/.config/picom.conf.ftlabs
fi

if hash xbanish >/dev/null 2>&1; then
	pkill xbanish
	xbanish &
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
xwallpaper --zoom $HOME/pix/walls/flowers-right.jpg
xset r rate 215 50
xrdb -load $HOME/.config/x11/xresources
setxkbmap -option caps:swapescape 

# audio dameon
pgrep pipewire || setsid -f pipewire &
pgrep pipewire && pgrep pipewire-pulse || setsid -f pipewire-pulse &
pgrep pipewire && pgrep pipewire-pulse && pgrep mpd || setsid -f mpd &
pgrep pipewire && pgrep pipewire-pulse && pgrep mpd && pgrep mpd_notify || setsid -f $HOME/.local/binbg/mpd_notify & # currently depends on mpc (for notify and cli), mpDris (for playerctl support), and playerctl (for global audio control)
