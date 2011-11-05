setlocal foldmethod=indent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
"setlocal nowrap
setlocal formatoptions+=c
setlocal formatoptions+=r
" Use the below highlight group when displaying bad whitespace is desired
highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
match BadWhitespace /\s\+$/
