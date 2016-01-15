#!/usr/bin/bash

# USAGE
#  install.sh [-n]
#
# Checks if packaged or system files need to be updated and update them.
# If -n is passed as first option, print the messages but do not update files.

declare -A FILES

# ["packaged/file/path"]="destination/path"
FILES[vimrc]="~/.vimrc"
FILES[Xresources]="~/.Xresources"
FILES["vim/templates/html.txt"]="~/.vim/templates/html.txt"
FILES["vim/autoload/templates.vim"]="~/.vim/autoload/templates.vim"
FILES["vim/plugin/functions.vim"]="~/.vim/plugin/functions.vim"
FILES["i3/quit.sh"]="~/.i3/quit.sh"
FILES["i3/setbg.sh"]="~/.i3/setbg.sh"
FILES["i3/config"]="~/.i3/config"
FILES["i3/lockscreen.sh"]="~/.i3/lockscreen.sh"

function resolve_file_path {
  # resolve_file_path(file_path)
  #  Resolves and prints a file path
  local file_path="$1"

  perl -e "print(<$1>)"
}

function exit_error {
  # exit_error(msg)
  #  Prints msg to STDERR and exits with 1
  echo "$msg" >&2
  exit 1
}

SKIP=""; [[ "$1" == "-n" ]] && SKIP="yes"

[[ -n "$SKIP" ]] && echo SKIP
exit
cd "$(dirname $0)"

for k in "${!FILES[@]}"; do # k: packaged file
  v="$(resolve_file_path "${FILES[$k]}")" # v: destination file

  if [[ ! -f "$v" ]]; then # Destination file does not exist
    echo "Creating file ${v}..."
    if [[ -f "$k" ]]; then # Packaged file exists
      [[ -n $SKIP ]] && install -T "$k" "$v"
    else
      echo "WARNING: Packaged file $k does not exist" >&2
      continue;
    fi
  fi

  # t_k, t_v: last modification time of k and v
  t_k=$(stat --format=%Y "$k")
  t_v=$(stat --format=%Y "$v")

  [[ $t_k -eq $t_v ]] && continue; # Files have the same date

  if [[ $t_k -gt $t_v ]]; then # packaged file is newer than destination file
    if ! diff -q "$k" "$v" >/dev/null; then
      echo "Updating file ${v}..."
      [[ -n $SKIP ]] && install -T "$k" "$v" || exit_error "Couldn't update file $v"
    fi
  else # packaged file is older than destination file
    if ! diff -q "$k" "$v" >/dev/null; then
      echo "Updating file ${k}..."
      [[ -n $SKIP ]] && install -T "$v" "$k" || exit_error "Couldn't update file $k"
    fi
  fi
done
