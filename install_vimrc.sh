#!/bin/sh

XDG_CONFIG_HOME="${HOME}/.config"
XDG_CACHE_HOME="${HOME}/.cache"

function ensure_directory_exists {
    if [ ! -d "$1" ]; then
      # Control will enter here if $DIRECTORY doesn't exist.
      mkdir -p $1
    fi
}

ensure_directory_exists "${XDG_CACHE_HOME}/vim/swp"
ensure_directory_exists "${XDG_CONFIG_HOME}/vim/tmp"

echo 'export XDG_CONFIG_HOME=$HOME/.config' >> "${HOME}/.zshrc" 
echo 'export XDG_CONFIG_HOME=$HOME/.config' >> "${HOME}/.bashrc" 
echo 'export XDG_CACHE_HOME=$HOME/.cache' >>  "${HOME}/.zshrc" 
echo 'export XDG_CACHE_HOME=$HOME/.cache' >>  "${HOME}/.bashrc" 
# ansi quoting, see: http://stackoverflow.com/a/8802512/1607448
echo $'export VIMINIT=\' let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC\'' >> "${HOME}/.zshrc" 
echo $'export VIMINIT=\' let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC\'' >> "${HOME}/.bashrc" 
