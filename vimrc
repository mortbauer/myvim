" vimrc: a monolithic vim setup. 
" vim: set fdm=marker ft=vim:

" {{{ ENVIRONMENT 
if !exists("$XDG_CONFIG_HOME")
    let g:xdg_config_home=$HOME.'/.config'
else
    let g:xdg_config_home=$XDG_CONFIG_HOME
endif
if !exists("$XDG_CACHE_HOME")
    let g:xdg_cache_home=$HOME.'/.cache'
else
    let g:xdg_cache_home=$XDG_CACHE_HOME
endif
" Make vim respect the XDG base directory spec.
" from: http://tlvince.com/vim-respect-xdg
if !exists("g:setted_environment") || &cp
    if !isdirectory(g:xdg_cache_home . '/vim/swp')
        call mkdir(g:xdg_cache_home . '/vim/swp', "p")
    endif
    if !isdirectory(g:xdg_cache_home . '/vim/tmp')
        call mkdir(g:xdg_cache_home . '/vim/tmp', "p")
    endif
    if version >= 703
        " Persistent undos
        let &undodir=g:xdg_cache_home . '/vim/tmp'
        set undofile
    endif
    let &directory=g:xdg_cache_home . '/vim/swp/'
    let &backupdir=g:xdg_cache_home . '/vim'
    let &runtimepath=g:xdg_config_home .'/vim' . ',' . $VIMRUNTIME . ',' . $VIM . '/vimfiles'
    execute "set viminfo+=n" . g:xdg_cache_home . '/vim/viminfo'
    let $MYVIMRC=g:xdg_config_home . "/vim/vimrc"
    let g:setted_environment = 1
endif
" }}} Environment
" {{{ Vundle
" Forget about vi and set it first as it modifies future behaviour
 set nocompatible               " be iMproved
 filetype off                   " required!
 call plug#begin('$HOME/.config/vim/plugged')
 " My Bundles here:
 " colorschemes
 Plug 'molokai'
 Plug 'Zenburn'
 Plug 'gmarik/ingretu'
 Plug 'endel/vim-github-colorscheme'
 Plug 'summerfruit256.vim'
 Plug 'ingo-library'
 " use the aur package since it is patched for the used languagetool version
 "Plug 'LanguageTool'
 Plug 'veselosky/vim-rst'
 Plug 'SpellCheck'
 Plug 'tmhedberg/SimpylFold'
 Plug 'rking/ag.vim'
 Plug 'effi/vim-OpenFoam-syntax'
 Plug 'dimasg/vim-mark'
 Plug 'JuliaLang/julia-vim'
 Plug 'chrisbra/Recover.vim'
 Plug 'sjl/gundo.vim'
 Plug 'drmikehenry/vim-fontsize'
 Plug 'scrooloose/nerdcommenter'
 Plug 'editorconfig/editorconfig-vim'
 Plug 'scrooloose/nerdtree'
 Plug 'klen/python-mode'
 Plug 'majutsushi/tagbar'
 Plug 'tshirtman/vim-cython'
 Plug 'lervag/vim-latex'
 Plug 'mustache/vim-mustache-handlebars'
 Plug 'kchmck/vim-coffee-script'
 Plug 'Valloric/MatchTagAlways'
 Plug 'digitaltoad/vim-jade'
 Plug 'noahfrederick/vim-skeleton'
 Plug 'jmcantrell/vim-virtualenv'
 Plug 'peterhoeg/vim-qml'
 Plug 'saltstack/salt-vim'
 Plug 'bling/vim-airline'
 " local repos
 "Plug '/data/devel/vim/molokai-transparent/.git', {'sync':'no'}
 "Plug '/data/devel/vim/vim-ipython/.git', {'sync':'no'}
 " session managment
 Plug 'xolox/vim-misc'
 Plug 'xolox/vim-session'
 call plug#end()

 filetype plugin indent on     " required!
 " NOTE: comments after Plug command are not allowed..
" }}}
" {{{ PREFERENCES 
" stop vim from changing buffer position when switching buffers, 
" http://stackoverflow.com/a/4255960/1607448
    " doesn't seem to be what i want from it
    "if v:version >= 700
      "au BufLeave * let b:winview = winsaveview()
      "au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
    "endif
" vim syntax highlighting is slow for long lines, better disable then be slow
set synmaxcol=150
" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on
" change directory to current file
"set autochdir
"set ttymouse=urxvt " messes up vim inside screen
set mouse=a
" for correct colors with gnu screen
set t_Co=256
" Statusline Format
"set statusline=%<%F%h%m%r%h%w%y\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ pos:%o\ lin:%l\,%L\ %P

" doesn't discard changes when switching buffers, simply hides the buffer
set hidden

" 256 colors if we can
if $TERM =~ "-256color"
  set t_Co=256
endif

" set the window title in screen
if $STY != "" && !has('gui')
  set t_ts=k
  set t_fs=\
endif

" use folding if we can
"if has ('folding')
  "set foldenable
  "set foldmethod=marker
  "set foldmarker={{{,}}}
  "set foldcolumn=0
"endif

" utf-8
if has('multi_byte')
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

" File based
set nosmartindent
set cindent             " Kind of smart identitation
syntax on               " Enable syntax highlighting

" Tabbing
set tabstop=4           " The number of spaces a tab is
set shiftwidth=4        " Number of spaces to use in auto(indent)
set softtabstop=4       " Just to be clear"{{{"}}}
set expandtab           " Insert tabs as spaces

" Searching
set nowrapscan            " Wrap searches
set ignorecase          " Ignore search term case...
set smartcase           " ... unless term contains an uppercase character
set incsearch           " Highlight search...
set showmatch           " ... results
set hlsearch            " ... as you type

" Wrapping
"set textwidth=90        " Hard-wrap text at nth column
set wrap                " Wrap long lines

" General
"set ruler               " Show [line,col] number (in status bar)
set showmode            " Persistent notice of current mode
set history=200         " Number of ":" commands and searches to remember 
set spelllang=en_us     " Speak proper English
set wildmenu            " dmenu style menu for commands
set fillchars=""        " Remove characters in window split
set encoding=utf-8      " Default encoding
set scrolloff=3         " 3 lines of context
set number              " Show line numbers
set undolevels=1000     " Increase number of possible undos.
set wildmode=list:longest,full " Complete to longest  string (list:longest) and then complete all full matches after another (full). Thanks to pbrisbin (http://pbrisbin.com:8080/dotfiles/vimrc).
set backspace=indent,eol,start          " Allow backspacing on the given values
set laststatus=2
set cursorline          " Heighlight the line the cursor is in
" }}} PREFERENCES 
" Visuals {{{
" Set up gvim, colour schemes and the like.

if has('gui_running')
    if has('win32') || has('win64')
       set guifont=DejaVu_Sans_Mono:h12,Consolas:h12,Courier_New:h12
    else
       set guifont=Monospace\ 12                " Fallback to system default
    endif
    set guioptions-=T                       " Hide toolbar
    set guioptions-=m                       " Hide menu bar
    set guioptions-=r                       " Hide right hand scroll bar
    set guioptions-=L                       " Hide left hand scroll bar
    set guioptions+=c                       " console dialogs instead of popups
    set stal=0                              " don't show tabline
    set background=dark
    colorscheme molokai
    set lines=80 columns=80
else
    set background=dark
    let g:zenburn_old_Visual = 1
    let g:zenburn_alternate_Visual = 1
    "colorscheme zenburn
    colorscheme molokai
endif
" }}} Visuals
" Mappings {{{
"
" Map leader (the dedicated user-mapping prefix key) to comma
let mapleader = ","
let maplocalleader = "-"

" maximize current window
map <F5> <C-W>_<C-W><Bar>
" vim does funny things with inline comments here, so don't use them.

" Toggle spelling and show it' status
"nnoremap <F3> :setlocal spell! spell?<CR>

" map <M-a> to list the buffers, entering a number + <CR> will close the list
nnoremap bb :buffers<CR>:buffer<Space>

" fold evrything execpt search results
nnoremap <leader>z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

" Insert newline without going into insert mode
map <F8> o<Esc>
map <F9> O<Esc>

" Replace the word under the cursor ,
nnoremap <leader>R :%s/\<<C-r><C-w>\>/

" M to show marks
noremap M :marks<CR>

" Open a file (relative to the current file)
" See: http://vimcasts.org/episodes/the-edit-command/
" Synonyms: {e: edit, where: {w: window, s: split, v: vertical split, t: tab}}
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

map <leader>t :tabnext<CR>

" Return to normal mode
inoremap jj <ESC>

" Always move between wrapped lines
nnoremap j gj
nnoremap k gk

" Disable search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" save the current file as root
if has ('unix')
    cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
endif

" insert modeline
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

"}}} Mappings
" {{{ Disabled keys 
" Disable arrow keys (force good habits)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
" Disable help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
" }}} Disabled keys 
" {{{ NERDTree
nnoremap <F2> :NERDTreeToggle <CR>
nnoremap <F1> :NERDTree .<CR>
let NERDTreeChDirMode=2
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', '.lo$','.mod$']
" }}} NERDTree
" {{{ python-mode
" TODO, this plugin is responsible for slow vim startup, should be loaded
" dynamically but don't know how
" {{{ pylint
" Load pylint code plugin
let g:pymode_lint = 0

" Switch pylint, pyflakes, pep8, mccabe code-checkers
" Can have multiply values "pep8,pyflakes,mcccabe"
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"

" Skip errors and warnings
let g:pymode_lint_ignore='E701,E231'

" Select errors and warnings
" E.g. "E4,W"
let g:pymode_lint_select = ""

" Run linter on the fly
let g:pymode_lint_onfly = 0

" Check code every save
let g:pymode_lint_write = 0

" Auto open cwindow if errors be finded
let g:pymode_lint_cwindow = 1

" Show error message if cursor placed at the error line
let g:pymode_lint_message = 1

" Auto jump on first error
let g:pymode_lint_jump = 0

" Hold cursor in current window
" when quickfix is open
let g:pymode_lint_hold = 0

" Place error signs
let g:pymode_lint_signs = 1

" Maximum allowed mccabe complexity
let g:pymode_lint_mccabe_complexity = 8

" Minimal height of pylint error window
let g:pymode_lint_minheight = 3

" Maximal height of pylint error window
let g:pymode_lint_maxheight = 6
" }}}
" {{{ pyrope
" Load rope plugin
let g:pymode_rope = 0

" Auto create and open ropeproject
let g:pymode_rope_auto_project = 1

" Enable autoimport
let g:pymode_rope_enable_autoimport = 1

" Auto generate global cache
let g:pymode_rope_autoimport_generate = 1

let g:pymode_rope_autoimport_underlineds = 0

let g:pymode_rope_codeassist_maxfixes = 10

let g:pymode_rope_sorted_completions = 1

let g:pymode_rope_extended_complete = 1

let g:pymode_rope_autoimport_modules = ["os","shutil","datetime"]

let g:pymode_rope_confirm_saving = 1

let g:pymode_rope_global_prefix = "<C-x>p"

let g:pymode_rope_local_prefix = "<C-c>r"

let g:pymode_rope_vim_completion = 1

let g:pymode_rope_guess_project = 1

let g:pymode_rope_goto_def_newwin = ""

let g:pymode_rope_always_show_complete_menu = 0
" }}}
" {{{ folding
" Enable python folding
let g:pymode_folding=1
" }}}
" {{{ run
" Load run code plugin
let g:pymode_run = 0

" Key for run python code
let g:pymode_run_key = '<F5>'
" }}}
" {{{ motion
" Enable python objects and motion
let g:pymode_motion = 0
" }}}
" {{{ virtualenv
let g:pymode_virtualenv = 0
" }}}
" }}}
" {{{ vim-sessions
let g:session_autosave=1
let g:session_autoload=0
let g:session_directory=g:xdg_config_home ."/vim/sessions"
set sessionoptions-=resize
" }}} vim-sessions
" {{{ snipMate
let g:snips_author='Martin Leopold Ortbauer'
let g:snips_trigger_key='<F1>'
let g:snippets_dir=[g:xdg_config_home . "/vim/bundle/snipmate-snippets" ,g:xdg_config_home . "/vim/snippets"]
" }}} snipMate
" {{{ LanguageTool 
" use the aur package, since it is patched for the LanguageTool package of
" archlinux
"let g:languagetool_jar="/usr/share/java/languagetool/languagetool-commandline.jar"
let g:languagetool_disable_rules="EN_UNPAIRED_BRACKETS,CURRENCY,CURRENCY_SPACE,MORFOLOGIK_RULE_EN_US,DE_CASE,WHITESPACE_RULE,EN_QUOTES,COMMA_PARENTHESIS_WHITESPACE"    
"}}}
" {{{ Tagbar
nnoremap <F7> :TagbarToggle<CR>

let g:tagbar_type_vb = {
    \ 'ctagstype' : 'VB',
    \ 'kinds'     : [
        \ 's:subroutines',
        \ 'f:functions',
        \ 'v:variables',
        \ 'g:globals',
        \ 't:types',
        \ 'c:constants',
        \ 'n:names',
        \ 'e:enums',
        \ 'l:labels',
        \ 'F:forms'
    \ ]
\ }
" }}} Tagbar
" {{{  Google Translater 
"noremap <C-T> v /_$\\|"/e-1<CR>d:call Translate("fin","en")<CR>:noh<CR>
" }}}  Google Translater 
" {{{1 Tabular
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
" }}}1 Tabular
" {{{ Latex
""not needed as already provided, probably through LatexBox
function! PsTricks()
    python << EOF
import os
import vim
import subprocess
filepath = vim.current.buffer.name
res = subprocess.call(['latex','-interaction','batchmode',filepath],cwd=os.path.split(filepath)[0],stdout=open(os.devnull,'w'))
subprocess.call(['dvips',os.path.splitext(filepath)[0]],
cwd=os.path.split(filepath)[0],stderr=open(os.devnull,'w'),stdout=open(os.devnull,'w'))
subprocess.call(['ps2pdf',os.path.splitext(filepath)[0]+'.ps'],cwd=os.path.split(filepath)[0],stdout=open(os.devnull,'w'))
EOF
endfunction
"noremap <F5> :call PsTricks()<CR>
"}}} Latex
"{{{ atp seems a good latex suite
let g:atp_folding=1
"}}}
" {{{ skeletons
let g:skeleton_template_dir=g:xdg_config_home . '/vim/skeletons'
" }}}
" Autocommands {{{
if has('autocmd')
endif
" }}} 
" {{{ Completion
"code completion: http://vim.wikia.com/wiki/Omni_completion
"set omnifunc=syntaxcomplete#Complete
" }}}
" {{{ python settings
"augroup vimrc_autocmds
    "autocmd!
    "" highlight characters past column 120
    "autocmd FileType python,pyrex highlight Excess ctermbg=DarkGrey guibg=Black
    "autocmd FileType python,pyrex match Excess /\%80v.*/
    "autocmd FileType python,pyrex set nowrap
"augroup END
" }}}
" {{{ rst
" exclude lisp from syntax highlighting in rst files because of issue https://code.google.com/p/vim/issues/detail?id=108&q=rst
let g:rst_syntax_code_list = ['vim', 'java', 'cpp', 'php', 'python', 'perl']
" }}}
" {{{ SimpylFold
" aslo fold away cython funcs
let s:def_regex = '^\s*\%(class\|def\|cdef\|cpdef\) \w\+'
" }}}
" {{{ MatchTag
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'html.handlebars' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}
" }}}
" {{{ session
let g:session_autosave= 'no'
" }}}
" {{{ Nerdcommenter
let g:NERDCustomDelimiters = {
        \ 'cython': { 'left': '# ', 'right': '' }
    \ }
" }}}
