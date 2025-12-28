#!/bin/bash

# Colours
source ~/.config/polybar/scripts/colours.sh

# Commands
AWK="/usr/sbin/awk"
BLUETOOTHCTL="/usr/sbin/bluetoothctl"

DEVICE="$($BLUETOOTHCTL info | $AWK 'NR==2 {for (i=2; i<=NF; i++) printf "%s%s", $i, (i==NF?ORS:OFS)}')"
if [ $DEVICE=="" ]; then
    DEVICE="None";
fi
echo "%{F$PRIMARY}Bluetooth:%{F-} $DEVICE";
