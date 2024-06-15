#!/bin/bash
CLOCK_FONT="Rubik"
FONT="lexend"
IMAGE="$HOME/.config/berry/walls/leaves-hard.jpg" # or use -blur 5

quote="$(shuf -n 1 ~/dox/notes/quotes)"
status=$(playerctl status || true)
music_paused_on_lock=false
#[ ! -e /tmp/blurred_wall.jpg ] && convert -scale 10% -blur 0x2.5 -resize 1000% /home/savar/.config/dwm/walls/gruvbox_astro.jpg /tmp/blurred_wall.jpg
#scrot -o /tmp/blurred_screen.jpg && convert -scale 100% -blur 10x10 -resize 100% /tmp/blurred_screen.jpg /tmp/blurred_screen.jpg

lock() {
        i3lock -n -c 00000066 -e --fill \
		-i $IMAGE \
                --ind-pos="w/2:h-24"\
                --radius=5 --ring-width=10 \
                --ring-color=31363b00 --ringver-color=474f5400 --ringwrong-color=474f5400 \
                --inside-color=474f5400 --insidever-color=d39bb600 --insidewrong-color=d39bb600\
		--keyhl-color=9EAA62 --bshl-color=D8776D              \
                --line-uses-inside \
                --time-str="%I:%M %p" --time-pos="w/2:h/2-70" \
                --time-color=bfddb2 --timeoutline-color=868686  --time-font="$CLOCK_FONT:style=Medium" --time-size=64 \
                --date-pos="tx:ty+42"\
                --date-color=b3cfa7 --date-font="$FONT:style=Bold" --date-size=24 \
                --greeter-text="$quote" \
                --greeter-pos="w/2:h/2+18"\
                --greeter-color=d39bb6 --greeter-font="$FONT" --greeter-size=24 \
                --keylayout 2 --layout-pos="18:h-18" --layout-color=999f93 --layout-align=1\
                --layout-font="$FONT" \
                --verif-text="Matching Passphrase.." --verif-pos="w/2:h-18" \
                --verif-color=999f93 --verif-font="$FONT" --verif-size=14 \
                --wrong-text="Invalid Passphrase!" --wrong-pos="w/2:h-18" \
                --wrong-color=d76e6e --wrong-font="$FONT" --wrong-size=14 \
                --noinput-text="No Input" \
		--force-clock #--no-unlock-indicator
}

# Pause the current playing song
if [ "$status" == "Playing" ]; then
	playerctl pause &
	music_paused_on_lock=true
fi

# Pause dunst notifications
dunstctl set-paused true

# lock the screen
lock

# Resume playback on unlock
if [ "$music_paused_on_lock" = true ]; then
	playerctl play
fi


# Resume dunst notifications
dunstctl set-paused false
