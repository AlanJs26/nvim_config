if ! [ -d ~/.config/nvim ]; then
  git clone https://github.com/AlanJs26/nvim_config.git ~/.config/nvim
fi

if [ "$1" = "--nvim-appimage" ] && ! [ $(which nvim 2>/dev/null) ]; then
  curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
  chmod u+x ./nvim.appimage
  ./nvim.appimage --appimage-extract
  if [ $(which sudo) ]; then
    sudo mv squashfs-root /
    sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
  else
    mv squashfs-root /
    ln -s /squashfs-root/AppRun /usr/bin/nvim
  fi
  rm nvim.appimage
  chmod u+x /usr/bin/nvim
fi
