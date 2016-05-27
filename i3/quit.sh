#!/bin/bash

if xmessage -buttons "Yes:0,No:1" -default No -center -timeout 5 "Exit X Session?"; then
  # Terminate composite manager
  CMGR_PID=$(pgrep compton)
  [[ -n $CMGR_PID ]] && kill $CMGR_PID && wait $CMGR_PID

  # Quit window manager
  i3-msg exit
fi
