#!/bin/bash

# Simple utilities for logging.

color_reset='\033[0m'
color_red='\033[0;31m'
color_green='\033[0;32m'
color_yellow='\033[0;33m'
color_cyan='\033[0;36m'

# Success
log_suc() {
  echo -e "${color_green}[suc] $@${color_reset}"
}

# Info
log_inf() {
  echo -e "${color_cyan}[inf] $@${color_reset}"
}

# Warn
log_wrn() {
  echo -e "${color_yellow}[wrn] $@${color_reset}"
}

# Error
log_err() {
  echo -e "${color_red}[err] $@${color_reset}"
}

# A shim for `readlink -f $YOUR_PATH` so it works cross platform.
readlink_f() {
  target_file=$1;

  cd `dirname $target_file`;
  target_file=`basename $target_file`;

  # Iterate down a (possible) chain of symlinks
  while [ -L "$target_file" ]; do
    target_file=`readlink $target_file`;
    cd `dirname $target_file`;
    target_file=`basename $target_file`;
  done

  # Compute the canonicalized name by finding the physical path
  # for the directory we're in and appending the target file.
  echo "`pwd -P`/$target_file";
}

# `git clone` which doesn't fail.
git_clone() {
  local repo=$1 dst=$2
  if [ -d "$dst" -a -d "$dst/.git" ] ; then
    echo "Refreshing $repo at $dst...";
    cd "$dst";
    git pull;
    cd -;
  else
    git clone $repo $dst;
  fi
}

get_owner() {
  if is_linux; then
    stat -c "%U" "$1" 2> /dev/null
  elif is_macos; then
    stat -f "%Su" "$1"  2> /dev/null
  else
    echo "Unsupported platform for stat"
    echo "Exiting"
    exit 2
  fi
}

link_file() {
  local src=$1
  local dst=$2
  local dst_needs_link=true
  local _sudo=""

  # Walk up the tree until a file/dir is found and find the owner.
  local target="$dst"
  local owner=$(get_owner "$target")
  while [[ -z "$owner" ]]; do
    target=$(dirname "$target")
    owner=$(get_owner "$target")
  done

  # If destination is root, then run actions as root.
  if [[ "$owner" == "root" ]]; then
    _sudo="sudo"
  fi

  # Check if already linked, otherwise delete destination.
  if [[ -e "$dst" ]]; then
    local current_link=`readlink "$dst"`
    if [[ "$current_link" == "$src" ]]; then
      log_suc "LINK(Up to date): [$owner] $dst "
      dst_needs_link=false
    else
      log_err "$current_link :::: $src"
      log_wrn "Removing $dst..."
      $_sudo rm -rf "$dst"
    fi
  fi

  # Link if not already linked.
  if [[ "$dst_needs_link" == "true" ]]; then
    $_sudo mkdir -p "$(dirname "$dst")"
    $_sudo ln -sf "$(readlink_f "$src")" "$dst"
    if [[ "$?" = "0" ]]; then
      log_suc "LINK: [$owner] "$(readlink_f $src)" $dst..."
    else
      log_err "FAIL(link): [$owner] "$(readlink_f $src)" $dst..."
    fi
  fi
}

export -f log_suc;
export -f log_inf;
export -f log_wrn;
export -f log_err;
export -f git_clone;
export -f link_file;
export -f readlink_f;
