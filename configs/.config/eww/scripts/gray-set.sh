#!/bin/sh
path="$HOME/.local/state/grayscale"

vibrant-cli eDP-1 "$(echo "$1/100" | bc -l)"
echo $1 > $path
