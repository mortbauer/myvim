myvim
######

My personal vim settings, to use it there need to be done two things:

1. add a line similar to the following to your bashrc::

  export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
  
  This actually just sets the place for the vim settings
  
2. clone this repo to the path you just specified, in the above cas eone would do::

  cd $XDG_CONFIG_HOME
  git clone --recursive https://github.com/mortbauer/myvim vim
  
The first time you open vim with the new settings, you need to open a new shell 
otherwise the VIMINIT you just specified won't be used and then you need to type into vim::

  :BundleInstall

