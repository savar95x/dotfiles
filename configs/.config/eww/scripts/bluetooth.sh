#!/bin/bash
dev="$(bluetoothctl devices Connected | cut -d' ' -f3- | sed 's/^[ \t]*//;s/[ \t]*$//')"

if [ "$dev" ]; then
	echo "$dev"
else
	echo "Off"
fi
get_bt() {
	devices="$(bluetoothctl devices Connected | cut -d' ' -f3- | sed 's/^[ \t]*//;s/[ \t]*$//')"

    if [ -z "$devices" ]; then
        echo "Off"
    else
        echo "$devices" | tr '\n' ',' | sed 's/,$//'
    fi
}

get_bt

dbus-monitor --system "sender='org.bluez'" 2> /dev/null | grep --line-buffered -E "PropertiesChanged|InterfacesAdded|InterfacesRemoved" | while read -r _; do
    get_bt
done
