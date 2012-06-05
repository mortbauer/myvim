" Vim filetype plugin file
" Language:     Melfa-Basic
" Maintainer:   
" Last Change:  2012

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") | finish | endif

" Don't load another plugin for this buffer
let b:did_ftplugin = 1

" Save the compatibility options and temporarily switch to vim defaults
let s:cpo_save = &cpoptions
set cpoptions&vim

" Remove characters up to the first = when evaluating filenames
setlocal includeexpr=substitute(v:fname,'.\\{-}=','','')

" Remove comma from valid filename characters since it is used to
" separate keyword parameters
setlocal isfname-=,

" Define format of comment lines (see 'formatoptions' for uses)
setlocal comments=:'
setlocal commentstring='%s

" Definitions start with a * and assign a NAME, NSET, or ELSET
" Used in [d ^wd and other commands
setlocal define=^\\*\\a.*\\c\\(NAME\\\|NSET\\\|ELSET\\)\\s*=

" Abaqus keywords and identifiers may include a - character
setlocal iskeyword+=-

let b:undo_ftplugin = "setlocal include< includeexpr< isfname<"
    \ . " comments< commentstring< define< iskeyword<"

if has("folding")
    " Fold all Subroutines
    setlocal foldexpr=(getline(v:lnum)=~'^[0-9]*\\s*[*].\\+\\s*$')?'>1':(getline(v:lnum)=~'^[0-9]*\\s*RETURN\\s*$')?'<1':1
    setlocal foldmethod=expr
    let b:undo_ftplugin .= " foldexpr< foldmethod<"
endif

" Set the file browse filter (currently only supported under Win32 gui)
if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "Abaqus Input Files (*.inp *.inc)\t*.inp;*.inc\n" .
    \ "Abaqus Results (*.dat)\t*.dat\n" .
    \ "Abaqus Messages (*.pre *.msg *.sta)\t*.pre;*.msg;*.sta\n" .
    \ "All Files (*.*)\t*.*\n"
    let b:undo_ftplugin .= "|unlet b:browsefilter"
endif

" Define patterns for the matchit plugin
if exists("loaded_matchit") && !exists("b:match_words")
    let b:match_ignorecase = 1
    let b:match_words = 
    \ '\*part:\*end\s*part,' .
    \ '\*assembly:\*end\s*assembly,' .
    \ '\*instance:\*end\s*instance,' .
    \ '\*step:\*end\s*step'
    let b:undo_ftplugin .= "|unlet b:match_ignorecase b:match_words"
endif


let b:undo_ftplugin .= "|unmap <buffer> [[|unmap <buffer> ]]"
    \ . "|unmap <buffer> <LocalLeader><LocalLeader>"

" Restore saved compatibility options
let &cpoptions = s:cpo_save

