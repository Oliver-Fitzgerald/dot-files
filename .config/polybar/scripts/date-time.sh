#!/bin/bash

# Colours
source ~/.config/polybar/scripts/colours.sh

# Commands
TIMEDATECTL="/usr/sbin/timedatectl"
AWK="/usr/sbin/awk"
CUT="/usr/sbin/cut"

# Parameters
DAY_NAME="$($TIMEDATECTL | $AWK 'NR==1 {print $3}')"
YEAR=$($TIMEDATECTL | $AWK 'NR==1 {print $4}' | $CUT --characters 1-4)
MONTH=$($TIMEDATECTL | $AWK 'NR==1 {print $4}' | $CUT --characters 6-7)
DAY=$($TIMEDATECTL | $AWK 'NR==1 {print $4}' | $CUT --characters 9-10)
TIME=$($TIMEDATECTL | $AWK 'NR==1 {print $5}')

# Script Output
echo "%{F$PRIMARY}$DAY_NAME%{F-} $DAY/$MONTH/$YEAR - $TIME";
