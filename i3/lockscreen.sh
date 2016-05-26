#!/bin/bash

SCREEN_STANDBY_TIME=30
SCREEN_SUSPEND_TIME=180
SCREEN_OFF_TIME=600
LOCK_IMAGE=~/.i3/lockscreen.png
OPTIONS="-e -n"

XSET_OUT="$(xset q)"

grep DPMS <<<"$XSET_OUT" | tail -n 1 | grep -q Enabled && DPMS_ENABLED=1 || DPMS_ENABLED=0
[[ $DPMS_ENABLED -ne 0 ]] && DPMS_VALUES=($(xset q | grep Standby | awk '//{ print $2, $4, $6; }'))
[[ -f $LOCK_IMAGE ]] && OPTIONS="$OPTIONS -i $LOCK_IMAGE"

~/.i3/composite.sh off
xset dpms $SCREEN_STANDBY_TIME $SCREEN_SUSPEND_TIME $SCREEN_OFF_TIME
i3lock $OPTIONS
xset dpms ${DPMS_VALUES[@]}
~/.i3/composite.sh on

[[ $DPMS_ENABLED -eq 0 ]] && xset -dpms
