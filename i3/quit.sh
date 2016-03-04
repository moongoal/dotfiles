#!/bin/bash

xmessage -buttons "Yes:0,No:1" -default No -center -timeout 5 "Exit X Session?" \
  && i3-msg exit
