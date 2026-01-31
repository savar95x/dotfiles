#!/bin/bash

# Configuration
PID_FILE="/tmp/ffmpeg_recording_pid"
OUTPUT_DIR="$HOME/vids/captures"
mkdir -p "$OUTPUT_DIR"
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
FILENAME="$OUTPUT_DIR/rec_$TIMESTAMP.mp4"

# 1. STOP RECORDING (if already running)
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    
    # Check if process actually exists
    if ps -p "$PID" > /dev/null; then
        kill "$PID"
        rm "$PID_FILE"
        notify-send "Recording Stopped" "Saved to $FILENAME"
        exit 0
    else
        # Stale PID file cleanup
        rm "$PID_FILE"
    fi
fi

# 2. START RECORDING (Menu)

# Ask for Audio Preference
audio_choice=$(echo -e "no-audio\nmic-audio\nsystem-audio" | dmenu -p "Audio:")
[ -z "$audio_choice" ] && exit 0 # Exit if user presses Esc

# Ask for Area Preference
area_choice=$(echo -e "fullscreen\nselect-area" | dmenu -p "Area:")
[ -z "$area_choice" ] && exit 0

# Set Audio Inputs
# 'default' usually works for the default mic. 
# Use 'pavucontrol' to verify your default input device.
AUDIO_FLAGS=""
if [ "$audio_choice" = "mic-audio" ]; then
    AUDIO_FLAGS="-f pulse -i default"
elif [ "$audio_choice" = "system-audio" ]; then
    # To record system audio, you often need the monitor of your output device
    # You might need to change 'default' to the specific monitor source name
    AUDIO_FLAGS="-f pulse -i default.monitor"
fi

# Set Video Area
if [ "$area_choice" = "select-area" ]; then
    # Use slop to get coordinates: X,Y,Width,Height
    # We must ensure width/height are even numbers for x264
    slop_out=$(slop -f "%x %y %w %h") || exit 1
    read -r X Y W H <<< "$slop_out"
    
    # Make sure dimensions are even (required by some codecs)
    W=$((W + W % 2))
    H=$((H + H % 2))
    
    VIDEO_FLAGS="-video_size ${W}x${H} -i :0.0+${X},${Y}"
else
    # Fullscreen detection
    RES=$(xdpyinfo | awk '/dimensions/{print $2}')
    VIDEO_FLAGS="-video_size $RES -i :0.0"
fi

# 3. EXECUTE FFMPEG
# -framerate 60: Smooth recording
# -preset ultrafast: Low CPU usage (bigger file size, but less lag)
notify-send "Recording Started" "Mode: $area_choice | $audio_choice"

ffmpeg \
    -f x11grab -framerate 60 $VIDEO_FLAGS \
    $AUDIO_FLAGS \
    -c:v libx264 -preset ultrafast -crf 25 -pix_fmt yuv420p \
    "$FILENAME" &

# Save the PID so we can kill it later
echo $! > "$PID_FILE"
