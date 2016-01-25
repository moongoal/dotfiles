#!/bin/bash

MODE=$1
OUTFILE=/tmp/screenshot-$(date '+%s').png
COMMON_OPTIONS="-q 100 -d 1"

if [[ $MODE = screen ]]; then
  scrot $COMMON_OPTIONS $OUTFILE
elif [[ $MODE = window ]]; then
  scrot $COMMON_OPTIONS -b -s $OUTFILE
fi
