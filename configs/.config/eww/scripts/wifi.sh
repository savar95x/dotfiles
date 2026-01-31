#!/bin/bash

INTERFACE="wlan0"

get_wifi() {
    ssid=$(iwctl station "$INTERFACE" show | grep "Connected network" | cut -d' ' -f19- | sed 's/^[ \t]*//;s/[ \t]*$//')
    if [ -z "$ssid" ]; then
        echo "Off"
    else
        echo "$ssid"
    fi
}

get_wifi
dbus-monitor --system "sender='net.connman.iwd', interface='org.freedesktop.DBus.Properties', member='PropertiesChanged'" 2> /dev/null | grep --line-buffered "member" | while read -r _; do
    get_wifi
done
