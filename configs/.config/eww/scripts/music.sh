#!/bin/bash
DEFAULT_ART="$HOME/pix/assets/icons/heart-solid.svg"
TMP_ART="/tmp/ncmpcpp_cover-$USER.jpg"
NO_ART=false

get_status() {
	# Check if "playing" string exists in mpc status
	status=$(mpc status)
	if echo "$status" | grep -q "\[playing\]"; then
		echo "playing"
	elif echo "$status" | grep -q "\[paused\]"; then
		echo "paused"
	else
		echo "stopped"
	fi
}

get_art() {
	if [ $NO_ART = true ]; then
		echo "background-image: url('$DEFAULT_ART'); background-position: center; background-repeat: no-repeat; background-size: 48px; "
		return
	fi
	# Check if "playing" string exists in mpc status
	if mpc status | grep -q "\[playing\]" || mpc status | grep -q "\[paused\]"; then
		echo "background-size: cover; background-position: center; background-image: url('$TMP_ART');"
	else
		echo "background-image: url('$DEFAULT_ART'); background-position: center; background-repeat: no-repeat; background-size: 48px; "
	fi
}

get_artist() {
	if [ "$(mpc current)" = "" ]; then
		echo "Not Playing"
	else
		artist="$(mpc -f "%artist%" current)" # | cut -d'/' -f1)"
		printf "%s\n" "${artist}"
	fi
}

get_title() {
	if [ "$(mpc current)" = "" ]; then
		echo "Music"
	else
		title="$(mpc -f "%title%" current)" # | cut -d'(' -f1)"
		title="$(printf '%s\n' "$title" | sed 's/[[:space:]]*$//')"
		if [ "$title" = "" ]; then
			title="$(mpc --format %file% current)"
		fi
		printf "%s\n" "${title}"
	fi
}

extract_art() {
	NO_ART=false
	MUSIC_DIR="${HOME}/mus"
	TMP_SONG="/tmp/current-song"
	TMP_COVER_PATH="/tmp/ncmpcpp_cover-${USER}.jpg"
	CURRENT_FILE="$MUSIC_DIR/$(mpc --format %file% current)"
	
	check_mpc_data() {
		if [ -z "$current_title" ]; then
			file_name="$(mpc -f %file% current | tr -d '"')"
			file_name="${file_name%.*}" # <--- Safer: removes everything after the last dot
			current_title="${file_name}"
			current_artist='unknown artist'
		fi
	}
	check_mpc_data
	
	if [ ! -f "$CURRENT_FILE" ]; then
		NO_ART=true
		return
	fi
	
	if ffprobe -v error -select_streams v:0 -show_entries stream=codec_type -of default=noprint_wrappers=1 -i "$CURRENT_FILE" > /dev/null 2>&1; then
		ffmpeg \
			-hide_banner \
			-loglevel 0 \
			-y \
			-i "$CURRENT_FILE" \
			-vf "scale=300:-1" \
			"$TMP_COVER_PATH" > /dev/null 2>&1
	else
		NO_ART=true
	fi
}

if [ "$1" = "status" ]; then
	get_status
	mpc idleloop player | while read -r _; do
		get_status;
	done
elif [ "$1" = "art" ]; then
	if [ $(get_status) != "stopped" ]; then
		extract_art
	fi
	get_art
	mpc idleloop player | while read -r _; do
		extract_art;
		get_art;
	done
elif [ "$1" = "artist" ]; then
	get_artist
	mpc idleloop player | while read -r _; do
		get_artist;
	done
elif [ "$1" = "title" ]; then
	get_title
	mpc idleloop player | while read -r _; do
		get_title;
	done
fi
