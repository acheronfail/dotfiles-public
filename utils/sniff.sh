#!/bin/bash

# A script that checks what environment/device/distribution/os is running
# and makes the information available.

# Set if running within Windows Subsystem for Linux.
wsl=0;
# Set if running on macOS.
macos=0;
# Set if running on Linux.
linux=0;
# Set if running on QNAP.
qnap=0;
# Set if we're running on Android (via termux).
android=0;
# Set if running a standard Linux distrubution (not QNAP).
distro=0;
# Which profile is in use.
profile="normal";

case "$(uname)" in
  "Darwin")
    macos=1;
    ;;
  "Linux")
    linux=1;
    ;;
  *)
    echo "Unsupported platform."
    exit 1;
    ;;
esac

if [[ "$linux" = "1" ]]; then
  if $(command -v getprop > /dev/null 2>&1); then
    android=1;
  elif $(command -v getsysinfo > /dev/null 2>&1); then
    qnap=1;
  elif $(grep -q "Microsoft" /proc/version); then
    wsl=1;
  fi
  if [ -f "/etc/os-release" ]; then
    source "/etc/os-release";
    distro="$ID";
  fi
fi

if [ -f "$DOTFILES_DIR/._profile" ]; then
  profile=$(cat "$DOTFILES_DIR/._profile");
fi

function return_if_set() {
  if [[ "$1" == "1" ]]; then
    return 0;
  fi

  return 1;
}

function is_wsl() {
  return_if_set "$wsl"
  return $?
}

function is_macos() {
  return_if_set "$macos"
  return $?
}

function is_linux() {
  return_if_set "$linux"
  return $?
}

function is_qnap() {
  return_if_set "$qnap"
  return $?
}

function is_android() {
  return_if_set "$android"
  return $?
}

function get_distro() {
  echo "$distro"
}

function get_profile() {
  echo "$profile";
}

export is_wsl;
export is_macos;
export is_linux;
export is_qnap;
export is_android;
export get_distro;
export get_profile;

