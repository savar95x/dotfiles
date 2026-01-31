#!/bin/bash

get_vol() {
    pamixer --get-volume
}

get_vol

pactl subscribe | grep --line-buffered "sink" | while read -r _; do
    get_vol
done
