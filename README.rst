myvim
######

My personal vim settings, to use it there need to be done two things:

1. add a line similar to the following to your bashrc::

  export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
  
This actually just sets the place for the vim settings, or just create a
symlink which also works under windows::

  ln -sf ~/.config/vim/vimrc ~/_vimrc
  
2. clone this repo to the path you just specified, in the above case one would do::

  cd $XDG_CONFIG_HOME
  git clone --recursive https://github.com/mortbauer/myvim $XDG_CONFIG_HOME/vim
  

Plug Ins
********
The plug ins are managed by vim-plug.

Installation
============

Download plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
and put it in the "autoload" directory.

Unix
----

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Neovim
------

curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Windows (PowerShell)
--------------------

md ~\vimfiles\autoload
$uri = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
(New-Object Net.WebClient).DownloadFile($uri, $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("~\vimfiles\autoload\plug.vim"))


The first time you open vim with the new settings, you need to open a new shell 
otherwise the VIMINIT you just specified won't be used and then you need to type into vim::

  :PlugInstall
