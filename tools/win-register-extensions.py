"""
  Script to register file extensions in the windows registry.
"""

extensions = set([
  '.vim',
  '.c',
  '.cpp',
  '.h',
  '.h++',
  '.hpp',
  '.java',
  '.js',
  '.css',
  '.php',
  '.txt',
  '.md',
  '.xml',
  '.asc',
])

import sys
import os.path

try:
  from winreg import *
except ImportError:
  print('Unable to import windows registry module.', file=sys.stderr)
  sys.abort()

if len(sys.argv) < 2 or not os.path.isfile(sys.argv[1]):
  print('Usage: {} VIM-EXECUTABLE-PATH VIM-ARGUMENTS'.format(os.path.basename(sys.argv[0])), file=sys.stderr)
  sys.exit(1)

VIM_PATH = '"{}" {}'.format(sys.argv[1], ' '.join(sys.argv[2:]))
PROG_NAME = 'Editor.kafir'

try:
  hkcr = ConnectRegistry(None, HKEY_CURRENT_USER)

  print('Setting up editor \'%s\'...' % PROG_NAME)

  key = CreateKeyEx(hkcr, 'Software\\Classes\\' + PROG_NAME + '\\shell\\open')
  SetValue(key, 'command', REG_SZ, VIM_PATH + ' "%1"')
  CloseKey(key)

  for ext in extensions:
    print('Setting up \'{}\' extension...'.format(ext))

    key = CreateKeyEx(hkcr, 'Software\\Classes\\' + ext)
    SetValue(key, None, REG_SZ, PROG_NAME)
    CloseKey(key)

except OSError as x:
  print('OSError ("{}") thrown'.format(x.strerror), file=sys.stderr)

  if hkcr is not None:
    CloseKey(hkcr)
    del hkcr
