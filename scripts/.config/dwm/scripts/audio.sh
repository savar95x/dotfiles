#!/bin/bash
source ~/.config/dwm/scripts/vars.sh
# 
case "$(pamixer --get-mute 2>/dev/null)" in
	false) echo "^c$BG^^b$GREEN^  ^c$FG^^b$BGALT^  $(pamixer --get-volume)  ^b$BGALT3^" ;;
	true) echo "^c$BG^^b$BGALT2^  ^c$FG^^b$BGALT^  $(pamixer --get-volume)  ^b$BGALT3^" ;;
esac

case "$BLOCK_BUTTON" in
	1) sb_audio notify ;;
esac
