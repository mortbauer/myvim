" Processes the document until the final pdf
fun! PweaveCompile()
 silent !(pweave -f rst % &> %:t:r.err;rst2latex %:t:r.rst %:t:r.tex &>> %:t:r.err; rubber --pdf %:t:r.tex &>> %:t:r.err ) &
 redraw!
endfun
map <Leader>p :w<CR>:call PweaveCompile()<CR>

" Looks for errors in the generated .err file, very shitty so far
fun! PweaveCopen()
  vimgrep /\(error\|exception\)/gj %:t:r.err
  copen
endfun
map ,a :call PweaveCopen()<CR>


