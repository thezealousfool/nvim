#!/bin/bash

# Default path value
INSTALL_DIR=$HOME/tools

# If custom path supplied to script, use that
if [ "$#" -ge 1 ]; then
	INSTALL_DIR=$1
fi

# Create INSTALL_DIR if does not exist.
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage

# Make neovim-config directory
mkdir -p $HOME/.config/nvim
cd $HOME/.config/nvim
git clone https://github.com/thezealousfool/nvim.git .

