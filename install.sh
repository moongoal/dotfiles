#!/bin/bash

# USAGE
#  install.sh [-n]
#
# Checks if packaged or system files need to be updated and update them.
# If -n is passed as first option, print the messages but do not update files.

declare -A FILES

# ["packaged_file_path"]="file_mode|destination_path"
FILES[vimrc]="644|~/.vimrc"
FILES[Xresources]="644|~/.Xresources"
FILES["vim/templates/html.txt"]="644|~/.vim/templates/html.txt"
FILES["vim/autoload/templates.vim"]="644|~/.vim/autoload/templates.vim"
FILES["vim/plugin/functions.vim"]="644|~/.vim/plugin/functions.vim"
FILES["i3/quit.sh"]="744|~/.i3/quit.sh"
FILES["i3/setbg.sh"]="744|~/.i3/setbg.sh"
FILES["i3/config"]="644|~/.i3/config"
FILES["i3/screenshot.sh"]="744|~/.i3/screenshot.sh"
FILES["i3/lockscreen.sh"]="744|~/.i3/lockscreen.sh"

# Execution mode
#   VALUES
#     install: install files from the repository to the system
#     collect: install files from the system to the repository
#     check: prints what files would be installed and what collected
#
#   Every mode works by copying files when they are newer than
#   their destination counterpart ONLY (or when desitation
#   files are missing).
EXEC_MODE="install"

function resolve_file_path {
  # resolve_file_path(file_path)
  #  Resolves and prints a file path
  local file_path="$1"

  perl -e "print(<$1>)"
}

function check_different {
  # check_different(r_file, s_file)
  #  Checks if files are different (r_file = file in repository, s_file = file in system)
  #  and print if file should be collected or installed
  local r_file="$1"
  local s_file="$2"

  if ! diff -q "$r_file" "$s_file" >/dev/null; then
    if [[ "$r_file" -nt "$s_file" ]]; then
      echo "INSTALL $s_file"
    else
      echo "COLLECT $r_file"
    fi
  fi
}

function exit_error {
  # exit_error(msg)
  #  Prints msg to STDERR and exits with 1
  echo "$msg" >&2
  exit 1
}

function print_help {
  echo -e "dotfiles installer\n"
  echo -e "Usage: install.sh\n\t[-i | --install]\n\t[-c | --collect]\n\t[-k | --check]\n\t[-h | --help]\n"

  echo "-i | --install: Install files to the system"
  echo "-c | --collect: Collect files from the system"
  echo "-k | --check: Print which files are to be installed and which to be collected"
  echo "-h | --help: Print this message and exit"
}

while [[ -n $1 ]]; do
  case "$1" in
    --collect | -c)
      EXEC_MODE=collect
      ;;
    --check | -k)
      EXEC_MODE=check
      ;;
    --help | -h)
      EXEC_MODE=help
      ;;
    *)
      exit_error "Unknown option $1"
      ;;
  esac
  shift
done

if [[ $EXEC_MODE == help ]]; then
  print_help
  exit 0
fi

cd "$(dirname $0)"
declare -a fdata

for k in "${!FILES[@]}"; do # k: packaged file
  OLD_IFS="$IFS"
  IFS="|"
  fdata=( ${FILES[$k]} ) # fdata: file data
  IFS="$OLD_IFS"

  mode=${fdata[0]}
  v="$(resolve_file_path "${fdata[1]}")" # v: destination file

  if [[ $EXEC_MODE == collect ]]; then
    install -v -D --mode=$mode -C -T "$v" "$k"
  elif [[ $EXEC_MODE == install ]]; then
    install -v -D --mode=$mode -C -T "$k" "$v"
  elif [[ $EXEC_MODE == check ]]; then
    check_different "$k" "$v"
  else
    exit_error "Unkown execution mode $EXEC_MODE"
  fi
done
