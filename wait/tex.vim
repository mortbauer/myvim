" My Latex commands
"
" Latex
fun! LatexCompile()
 silent !latex -interaction=nonstopmode %
 redraw!
endfun
"map ,l :call LatexCompile()<CR>
"Dvips
fun! DvipsCompile()
 silent !dvips -o %:t:r.ps %:t:r.dvi
 redraw!
endfun
"map ,d :call DvipsCompile()<CR>
"Ps2pdf
fun! Ps2pdfCompile()
 silent !ps2pdf %:t:r.ps
 redraw!
endfun
"map ,p :call Ps2pdfCompile()<CR>
"Latex,Dvips,Ps2PDF
fun! PsTricksCompile()
 :call LatexCompile()
 :call DvipsCompile()
 :call Ps2pdfCompile()
endfun
"map ,a :call PsTricksCompile()<CR>

" use rubber --pdf
fun! Rubber()
  silent !rubber --pdf %
endfun
"map <Leader>r :w<CR>:call Rubber()<CR>

" use texwrapper
set makeprg=texwrapper\ -lw  
set errorformat=%f:%l:%c:%m
"command LaTeX silent make %
"map <Leader>y :w<CR>:make %<<CR>

