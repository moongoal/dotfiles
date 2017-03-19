#!/usr/bin/env python3

import os
import subprocess
import sys

# Set params
todolist = '~/.i3/todo.lst'
bg = '~/img/wallpaper_clean.png'
font, fontsize = '~/.local/share/fonts/Raleway-Regular.ttf', 32
outimg = sys.argv[1]
gravity = 'northwest'
fill = '#11111133' # RGBA
offset = dict(x=10, y=10)

# Normalise paths
bg = os.path.abspath(os.path.expanduser(bg))
font = os.path.abspath(os.path.expanduser(font))
todolist = os.path.abspath(os.path.expanduser(todolist))
outimg = os.path.abspath(os.path.expanduser(outimg))

if os.path.exists(todolist):
  # Build TODO list
  with open(todolist) as f:
    todo = [line.strip('\n \t') for line in f]
  
  # Process list
  text = r'\n  * '.join(('TODO:', *todo))

  # Produce wallpaper
  sp = subprocess.run(
    [
      'convert',
      bg,
      '-font', font,
      '-pointsize', str(fontsize),
      '-fill', fill,
      '-gravity', gravity,
      '-annotate', '+{x}+{y}'.format(x=offset['x'], y=offset['y']), text,
      outimg
    ]
  )

  sys.exit(sp.returncode)
