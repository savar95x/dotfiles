#!/bin/sh
((pgrep redshift && pkill redshift && eww update is_active_red=false) || (setsid -f redshift && eww update is_active_red=true)) &
