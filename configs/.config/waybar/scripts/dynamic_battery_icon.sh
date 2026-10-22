#!/bin/bash

BATTERY=$(ls /sys/class/power_supply/ | grep -i 'bat' | head -n 1)

if [ -n "$BATTERY" ]; then
    CAPACITY=$(cat /sys/class/power_supply/$BATTERY/capacity)
    STATUS=$(cat /sys/class/power_supply/$BATTERY/status)
else
    CAPACITY=0
    STATUS="Unknown"
fi

CAPACITY=${CAPACITY:-0}

COLOR="#ddc7a1"
if [[ "$STATUS" == "Charging" || "$STATUS" == "Full" || "$STATUS" == "Not charging" ]]; then
    COLOR="#a3ae6d"
elif [ "$CAPACITY" -le 14 ]; then
    COLOR="#d67b76"
fi

# Outer body spans x=1 to x=20 (width 19). 
# Starting fill at x=0 and rounding to whole pixels makes the juice edge 100% crisp.
ACTUAL_FILL_WIDTH=$(awk -v cap="$CAPACITY" 'BEGIN { 
    w = 1 + (19 * cap) / 100;
    if (cap > 0 && w < 3) w = 3;
    printf "%.0f", w;
}')

cat <<EOF > /tmp/waybar_battery.svg
<svg xmlns="http://www.w3.org/2000/svg" width="24px" height="24px" viewBox="0 -24 24 24" shape-rendering="geometricPrecision">
  <defs>
    <clipPath id="battery-mask">
      <rect x="1" y="-18" width="19" height="12" rx="3" ry="3"/>
    </clipPath>
  </defs>
  
  <!-- 1. Dark Empty Background -->
  <rect x="1" y="-18" width="19" height="12" rx="3" ry="3" fill="#50494500"/>
  
  <!-- 2. Dynamic Fill (Starts at x=0 so clip-path handles left curve seamlessly, no dark gap!) -->
  <rect x="0" y="-24" width="${ACTUAL_FILL_WIDTH}" height="24" fill="${COLOR}" clip-path="url(#battery-mask)"/>
  
  <!-- 3. Crisp Pixel-Aligned Main Body Outline (1.5px stroke centered so outer edge hits exact integer pixels) -->
  <rect x="1.25" y="-17.75" width="18.5" height="11.5" rx="2.75" ry="2.75" fill="none" stroke="#ddc7a1" stroke-width="1.5"/>
  
  <!-- 4. Crisp Terminal Pill -->
  <path d="M21.5-14.5 h0.5 a1 1 0 0 1 1 1 v3 a1 1 0 0 1 -1 1 h-0.5 Z" fill="#ddc7a1"/>
</svg>
EOF

echo "/tmp/waybar_battery.svg"
