#!/bin/bash

# Find the path to your backlight device (usually intel_backlight or amdgpu_bl0)
# We look for the folder inside /sys/class/backlight/
path=$(find /sys/class/backlight/*/brightness | head -n 1)

get_bright() {
    light -G
}

# 1. Output initial brightness
get_bright

# 2. Watch the file for "close_write" events (when the system updates the value)
inotifywait -m -e close_write "$path" | while read -r _; do
    get_bright
done
