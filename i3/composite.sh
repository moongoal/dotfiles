#!/bin/bash

MODE=$1

case $MODE in
  on)
    compton -b
    ;;
  off)
    pkill --signal SIGTERM compton
    ;;
  *)
    echo "$0 ERROR: unable to run composite manager, invalid command \"$1\"" >&2
    exit 1
    ;;
esac
