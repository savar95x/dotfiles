#!/bin/bash
# Capture timestamp right when keybind is pressed
start=$(date +%s%N)

# Launch foot and immediately calculate the difference inside the new window
foot -e bash -c "end=\$(date +%s%N); echo 'End-to-End Startup Time: '\$(( (end - $start) / 1000000 ))' ms'; exec bash"
