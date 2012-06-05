" Vim syntax file for the MELFA-BASIC IV robot programming language.
" Language: MELFA-BASIC IV
" Maintainer: 
" Last Change: 

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
"
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

let b:undo_ftplugin = "setlocal include< includeexpr< isfname<"
    \ . " comments< commentstring< define< iskeyword<"

if has("folding")
    " Fold all Subroutines
    setlocal foldexpr=(getline(v:lnum)=~'^\\s*[0-9]*\\s*[*].\\+\\s*$')?'>1':1
    "setlocal foldexpr=(getline(v:lnum)=~'^\\s*[0-9]*\\s*[*].\\+\\s*$')?'>1':(getline(v:lnum)=~'^[0-9]*\\s*RETURN\\s*$')?'<1':1
    setlocal foldmethod=expr
    let b:undo_ftplugin .= " foldexpr< foldmethod<"
endif


syn case match

" Numeric Functions
syn keyword melfaFunction ABS CINT DEG EXP FIX INT LEN LN LOG MAX MIN RAD SGN 
      \ SQR STRPOS RND ASC CVI CVS CVD VAL 

" Trigonometric Functions
syn keyword melfaFunction ATN ATN2 COS SIN TAN

" Characterstring Functions
syn keyword melfaFunction BIN$ CHR$ HEX$ LEFT$ MID$ MIRRORS$ MKI$ MKS$ MKD$ 
      \ RIGHT$ STR$ CKSUM$

" Position Variable Functions
syn keyword melfaFunction DIST FRAM RDFL1 SETFL1 RDFL2 SETFL2 ALIGN INV PTOJ 
      \ JTOP ZONE ZONE2 POSCQ POSMID CALARC SETJNT SETPOS

" Instructions related to movement control
syn keyword melfaFunction ACCEL CMP CMPG CNT FINE JNT JOINT JOVRD JRC LOADSET
      \ MOV MVA MVC MVR MVR2 MVR3 MVS OADL OFF ON OVRD POS PREC SERVO SPD
      \ SPDOPT TOOL TORQ WTH WTHIF XYZ 

" Instructions related to program control
syn keyword melfaStatement CALLP CASE CLOSE CLR COLCHK COM DLY ELSE END ENDIF
      \ ERR ERROR FOR FPRM GOSUB GOTO HCLOSE HLT HOPEN IF INPUT IV NEXT OFF ON
      \ OPEN PRINT REM RESET RETURN SELECT SKIP STOP THEN WAIT WEND WHILE 

" Definition instructions
syn keyword melfaStatement ACT ARCH BASE CHAR DEF DIM DOUBLE FLOAT FN INTE IO JNT PLT POS TOOL XYZ 

" Multi-task related
syn keyword melfaStatement ERR GETM PRIORITY RELM RESET XCLR XLOAD XRST XRUN XSTP 

" Others
syn keyword melfaStatement CHRSRCH


" Specify comment region
syn region melfaComment start=+'+ end=+$+ contains=melfaTodo

" Specify string region
syn region melfaString start=+"+ end=+"+ end=+$+

" Specify job header region
syn region melfaHeader start=+/+ end=+$+ contains=melfaNumbers

syn match melfaNumbers "[0-9]"

syn keyword melfaTodo contained TODO FIXME


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_basic_syn_inits")
  if version < 508
    let did_basic_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink melfaComment Comment
  HiLink melfaString String
  HiLink melfaNumbers Number
  HiLink melfaBoolean Boolean

  HiLink melfaFunction Function

  HiLink melfaStatement Statement
  HiLink melfaConditional Conditional
  HiLink melfaRepeat Repeat
  HiLink melfaLabel Label
  HiLink melfaOperator Operator

  HiLink melfaHeader PreProc

  HiLink melfaType Type

  HiLink melfaSpecial Special

  HiLink melfaTodo Todo

  delcommand HiLink
endif

let b:current_syntax = "melfa"

" vim: ts=8
