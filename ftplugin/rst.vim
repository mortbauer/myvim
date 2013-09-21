" Use four spaces for indentation
setlocal expandtab
setlocal softtabstop=4
setlocal shiftwidth=4

" http://onethingwell.org/post/1591226959/autocomplete-words-in-vim
set complete+=k/usr/share/dict/usa

" Wrap at 80 lines
setlocal textwidth=79

let maplocalleader = ","
" from: http://blog.tuxcoder.com/2008/12/11/vim-restructuretext-macros/
" Restructured Text
" #########################
" Ctrl-u 1:    underline Parts w/ #'s
":nnoremap <buffer> <leader>x dd
nnoremap <buffer> <localleader>1 yypVr#
"inoremap <buffer> <localleader>1 <esc>yypVr#A
" Ctrl-u 2:    underline Chapters w/ *'s
nnoremap  <buffer> <localleader>2 yypVr*
"inoremap <buffer> <localleader>2 <esc>yypVr*A
" Ctrl-u 3:    underline Section Level 1 w/ ='s
nnoremap  <buffer> <localleader>3 yypVr=
"inoremap <buffer> <localleader>3 <esc>yypVr=A
" Ctrl-u 4:    underline Section Level 2 w/ -'s
nnoremap  <buffer> <localleader>4 yypVr-
"inoremap <buffer> <localleader>4 <esc>yypVr-A
" Ctrl-u 5:    underline Section Level 3 w/ ^'s
nnoremap  <buffer> <localleader>5 yypVr^
"inoremap <buffer> <localleader>5 <esc>yypVr^A

