#!/bin/sh
# read system info
read -r host < /proc/sys/kernel/hostname
read -r kernel < /proc/sys/kernel/osrelease
. /etc/os-release

# Get wm from xinitrc
#while read -r line; do
    #[ "${line#exec }" = "$line" ] || wm="${line#exec }"
#done < "$HOME/.xinitrc"
wm="2bwm"

# Colors and palette method stolen from dylanaraps pftech
# https://github.com/dylanaraps/pfetch
c0='[0m';
c1='[31m'; c2='[32m'
c3='[33m'; c4='[34m'
c5='[35m'; c6='[36m'
c7='[37m'; c8='[38m'
palette="[7m$c1 $c1 $c2 $c2 $c3 $c3 $c4 $c4 $c5 $c5 $c6 $c6 [m"

# Output
printf '%s\n' "

    ${c5}     .-.         ${USER}${c0}@${c5}${host}
    ${c5}  __/   (        ${c6}os${c0}      ${PRETTY_NAME}
    ${c5}, '-.____\\       ${ARTR3}${c6}kernel${c0}  ${kernel}
    ${c5} u=='/  \\        ${c6}shell${c0}   ${SHELL##*/}
    ${c5}    /_/  \\       ${c6}wm${c0}      ${wm}
    ${c5}  .-''   |

"
