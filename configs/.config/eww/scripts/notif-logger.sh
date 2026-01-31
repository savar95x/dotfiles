#!/bin/bash

# Dunst passes these arguments automatically in this order:
# $1 = appname
# $2 = summary
# $3 = body
# $4 = icon
# $5 = urgency

# path to your python script
PY_SCRIPT="$HOME/.config/eww/scripts/notifications.py"

# We pass the data to the "add" command we defined in Python.
# We explicitly quote variables to handle spaces/special chars correctly.
python3 "$PY_SCRIPT" add "$1" "$2" "$3"
