#!/bin/sh
date=$(date '+%d')
if [ "$(echo $date | cut -c1)" = "0" ]; then
	date=$(echo $date | cut -c2)
fi
echo "$date $(date '+%b %Y')"
