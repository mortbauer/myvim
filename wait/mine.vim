au BufRead,BufNewFile *.pst.tex		set filetype=pst.tex
au BufRead,BufNewFile *.pnw	    source $XDG_CONFIG_HOME/vim/ftplugin/noweb.vim
au BufRead,BufNewFile *.nw	setlocal filetype=rstscript 
au BufRead,BufNewFile *.nw source $XDG_CONFIG_HOME/vim/ftplugin/rst.vim
