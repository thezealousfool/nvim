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
echo -e "alias nvim=$INSTALL_DIR/nvim.appimage\n" >> $HOME/"$RC_FILE"
source $HOME/"$RC_FILE"

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

pip3 install --user pynvim jedi # Python code completion
pip3 install --user yapf # Python code-formatting with neoformat
pip3 install --user pylint # Python linting with neomake

# Make neovim-config directory
if [ ! -d "$HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim
fi
cd $HOME/.config/nvim
git clone https://github.com/thezealousfool/nvim.git .

