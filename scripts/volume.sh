#!/bin/bash

# Usage: volume.sh VOLUME
#
# VOLUME is in the format [0-9]{1-3}%[+-]?
#
# Examples:
#  10%+ Increases the volume by 10%
#  20%- Decreases the volume by 20%
#  100% Sets the volume to 100%

[[ -z "$1" ]] && exit 1

VOL=$1
CURVOL=$(amixer set Master "${VOL}" | tail -n 1 | grep -Eo '[0-9]{1,3}%')
CURVOL=${CURVOL::-1}

pkill -TERM osd-volume
nohup osd-volume "$CURVOL" 1> /dev/null 2>&1 &
