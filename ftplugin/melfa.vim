" Replace the beginning of the line with a number inceremented by ten

fun! LineNumbers()
   %! nl -bt -i 10 -v 10    
   w                       
   %! colrm 1 8          
endfun

"map <Leader>n :w<CR>:%s/^/\=(10*line("."))." "<CR>
map <Leader>n :w<CR>:call LineNumbers()<CR>
