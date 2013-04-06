
"if exists("b:current_syntax")
    "finish
"endif
"let b:current_syntax = "pweave"

"syntax keyword potionKeyword to times
"highlight link potionKeyword Keyword

let noweb_language="python"
let noweb_backend="rst"
let noweb_fold_code=1

" Processes the document until the final pdf
fun! PweaveRST2PDF()
  silent !(pweave -f rst % &> %:t:r.err;rst2pdf %:t:r.rst &>> %:t:r.err) &
 redraw!
endfun
map <Leader>p :w<CR>:call PweaveRST2PDF()<CR>

fun! PweavePDFLATEX()
 silent !(pweave -f rst % &> %:t:r.err;rst2latex --literal-block-env=minted[framesep=2mm,frame=lines,mathescape]{python} --latex-preamble='\usepackage{minted}' %:t:r.rst %:t:r.tex &>> %:t:r.err; pdflatex -shell-escape %:t:r.tex &>> %:t:r.err ) &
 redraw!
endfun
map <Leader>l :w<CR>:call PweavePDFLATEX()<CR>


map <Leader>k :w<CR>:!'/data/virtualenv/doc3/bin/rstwizard' %<CR>
map <Leader>d :w<CR>:!'/data/virtualenv/doc3/bin/litscript' -ow %:t:r.rst %<CR><CR>

"
" Looks for errors in the generated .err file, very shitty so far
fun! PweaveCopen()
  vimgrep /\(error\|exception\)/gj %:t:r.err
  copen
endfun
map <Leader>a :call PweaveCopen()<CR>

"set commentstring=#%s
source /home/martin/.config/vim/bundle/noweb/syntax/noweb.vim

"function! RnwIsInRCode()
    "let chunkline = search("^<<", "bncW")
    "let docline = search("^@", "bncW")
    "if chunkline > docline
        "return 1
    "else
        "return 0
    "endif
"endfunction

"syn region rstPythonRegion fold start=+<<>>=$+ end=+^@$+	

"let g:tcommentGuessFileType=1
