#!/bin/sh
icon=$HOME/pix/assets/lock.png
tmpbg=/tmp/screen.png
rm $tmpbg && scrot -F $tmpbg
magick $tmpbg -scale 10% -scale 1000% $tmpbg
magick $tmpbg $icon -gravity center -composite -matte $tmpbg
i3lock -u -i $tmpbg
