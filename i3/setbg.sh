#!/bin/bash

BGIMG="/tmp/_i3-background.png"

~/.i3/todo.py "$BGIMG" && feh --no-fehbg --bg-fill "$BGIMG"
