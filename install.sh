#!/usr/bin/env bash

shopt -s expand_aliases
which sudo || alias sudo=" "

GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NORMAL='\033[0;0m'

print_header() {
  echo -e "${GREEN}"
  text="$@"

  mainline="#   $text   #"
  borderline="$(echo "$mainline" | sed 's/./#/g')"

  echo -e $borderline
  echo -e "$mainline"
  echo -e $borderline ${NORMAL}
}

if ! [ -d ~/.config/nvim ]; then
  print_header "Fetching config from AlanJs26/nvim_config"
  git clone https://github.com/AlanJs26/nvim_config.git ~/.config/nvim
else
  GREEN=$YELLOW print_header "Existing neovim config found"
fi

if [ "$1" = "--nvim-appimage" ] && ! [ $(which nvim 2>/dev/null) ]; then
  print_header "Downloading latest neovim appimage for x86_64"
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
  chmod u+x ./nvim-linux-x86_64.appimage
  print_header "Extracting appimage"
  ./nvim-linux-x86_64.appimage --appimage-extract

  print_header "Installing into /usr/bin/nvim"
  sudo mv squashfs-root /neovim
  sudo ln -s /neovim/AppRun /usr/bin/nvim
  rm nvim-linux-x86_64.appimage
  chmod u+x /usr/bin/nvim
fi

if [ $(which apt) ] && [ ! $(which unzip) ]; then
  print_header "Installing unzip"
  sudo apt update && sudo apt install -y unzip
fi
