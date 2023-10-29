

if ! [ -d ~/.config/nvim ]; then
  git clone https://github.com/AlanJs26/nvim_config.git ~/.config/nvim
fi

if [ "$1" = "--nvim-appimage" ] && ! [ $(which nvim 2> /dev/null) ]; then
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  ./nvim.appimage --appimage-extract
  sudo mv squashfs-root /
  sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
  rm nvim.appimage
  chmod u+x /usr/bin/nvim
fi
