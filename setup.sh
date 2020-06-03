#!/usr/bin/env bash

source $(dirname $0)/utils/sniff.sh;
source $(dirname $0)/utils/helpers.sh;
dotfiles_dir=`dirname $(readlink_f $0)`

bash_version=$(echo $BASH_VERSION | grep -o '^[0-9]*');
if [ $bash_version -lt 4 ]; then
  echo "Bash version $BASH_VERSION not supported. Must be at least version 4";
  exit 1;
fi

function run() {
  # Run command
  $@
  if [ $? -ne 0 ]; then
      echo "Failed: $@";
      exit 1;
  fi
}

function main() {
  # Prepare templated variables.
  local dfuser="$HOME"
  local dfroot=""
  if is_android; then
    dfroot="" # unused since we assume phone is not rooted
  elif is_linux; then
    dfroot="/root"
  elif is_macos; then
    dfroot="/var/root"
  else
    log_err "Unsupported platform for linking"
    exit 1
  fi

  # Link each entry under `skel` (make sure to handle whitespaces in filenames).
  find skel -name '*.dflink.*' -print0 | while IFS= read -r -d '' entry; do
    local should_link=true
    local should_copy=false
    local should_exec=false

    # Parse flags: `filename.dflink.FLAGS`
    local flags=${entry##*dflink.}
    local should_skip=true
    for (( i=0; i < "${#flags}"; i++)); do
      local flag=${flags:i:1}
      case $flag in
        "c") # copy: overwrites the current file with the latest from the dotfiles
          should_copy=true
          should_link=false
          ;;
        "l") # linux
          is_linux && should_skip=false
          ;;
        "m") # macos
          is_macos && should_skip=false
          ;;
        "t") # template: copies the file to dest if it doesn't already exist
          should_template=true
          should_link=false
          ;;
        "x") # exec: gives the file executable permissions
          should_exec=true
          ;;
        *)
          log_wrn "Unrecognised dflink option: '$flag' for $entry ($flags), skipping"
          continue 2
          ;;
      esac
    done

    # Skipping conditions.
    $should_skip && continue

    # Make source absolute.
    local src="$(pwd)/$entry"

    # Compute destination.
    local dest=${entry##skel}   # trim off leading `skel`
    dest=${dest%%.dflink.*}     # trim off trailing `.dflink.*`
    dest=${dest/"/DFROOT"/$dfroot} # replace DFROOT with `$dfroot`
    dest=${dest/"/DFUSER"/$dfuser} # replace DFUSER with `$dfuser`

    # Ensure directory tree exists.
    mkdir -p "$(dirname "$dest")"

    # Link/Copy.
    if $should_link; then
      link_file "$src" "$dest"
    elif $should_copy || ($should_template && [ ! -e "$dest" ]); then
      rm -rf "$dest"
      cp -a "$src" "$dest" && log_suc "COPY: $dest"
    fi

    # Make executable.
    if $should_exec; then
      chmod +x "$dest" && log_suc "EXEC: $dest"
    fi
  done
}

# Install base packages.
sudo apt-get update
sudo apt-get install -y \
  build-essential \
  copyq \
  coreutils \
  fd-find \
  fzf \
  git \
  irssi \
  jq \
  ncdu \
  nmap \
  neovim \
  python-pip \
  python3-pip \
  ranger \
  ripgrep \
  tmux \
  wget \
  xclip \
  zsh

# Install starship shell
curl -fsSL https://starship.rs/install.sh | bash -s -- -y

# Annoyingly there's no easy way to install exa.
curl -sL https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip > exa.zip
unzip exa.zip
sudo mv exa-linux-x86_64 /usr/local/bin/exa
rm exa.zip

# Install Insomnia
if [ ! -f /etc/apt/sources.list.d/insomnia.list ]; then
  echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
  wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc | sudo apt-key add -
  sudo apt-get update
  sudo apt-get install -y insomnia
fi

# Clean up.
sudo apt-get autoremove -y

main

bash -c "chsh -s $(which zsh)"
echo "Done! Log in and out for the default shell to apply."

# TODO install node
# TODO install nvim plugins

