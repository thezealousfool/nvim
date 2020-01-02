#!/bin/bash

# Default path value
INSTALL_DIR=$HOME/tools
RC_FILE=".bashrc"

# If custom path supplied to script, use that
if [ "$#" -gt 0 ]; then
	INSTALL_DIR=$1
fi

# Create INSTALL_DIR if does not exist.
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
fi

cd "$INSTALL_DIR"
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod +x nvim.appimage
echo "alias nvim=$INSTALL_DIR/nvim.appimage" >> $HOME/"$RC_FILE"
source $HOME/"$RC_FILE"

# Make neovim-config directory
mkdir -p $HOME/.config/nvim
cd $HOME/.config/nvim
git clone https://github.com/thezealousfool/nvim.git .

