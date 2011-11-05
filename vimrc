" vimrc: a monolithic vim setup. {{{1
" Copyright 2009-2011 Tom Vincent <http://www.tlvince.com/contact/>
" vim: set fdm=marker:

" Environment {{{1
"
" A consistent runtime environment.

" Forget about vi and set it first as it modifies future behaviour
set nocompatible
filetype off

" Make vim respect the XDG base directory spec.
set directory=$XDG_CACHE_HOME/vim,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME,/usr/share/vim/vimfiles/
let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"

" Load plugins managed by pathogen
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" General preferences {{{1
"
" Learn about these using vim help.

" File based
filetype plugin on      " Load file type plugins
filetype indent on      " Enable file type based indentation
syntax on               " Enable syntax highlighting

" Tabbing
set tabstop=4           " The number of spaces a tab is
set shiftwidth=4        " Number of spaces to use in auto(indent)
set softtabstop=4       " Just to be clear
set expandtab           " Insert tabs as spaces

" Searching
"set wrapscan            " Wrap searches
set ignorecase          " Ignore search term case...
set smartcase           " ... unless term contains an uppercase character
set incsearch           " Highlight search...
set showmatch           " ... results
set hlsearch            " ... as you type

" Wrapping
set textwidth=70        " Hard-wrap text at nth column
set wrap                " Wrap long lines

" General
set ruler               " Show [line,col] number (in status bar)
set showmode            " Persistent notice of current mode
set history=200         " Number of ":" commands and searches to remember 
set spelllang=de_de     " Speak proper English
set wildmenu            " dmenu style menu for commands
set fillchars=""        " Remove characters in window split
set encoding=utf-8      " Default encoding
set scrolloff=3         " 3 lines of context
set number              " Show line numbers
set undolevels=1000     " Increase number of possible undos.
set wildmode=list:longest,full " Complete to longest  string (list:longest) and then complete all full matches after another (full). Thanks to pbrisbin (http://pbrisbin.com:8080/dotfiles/vimrc).
set mouse=a
set backspace=indent,eol,start          " Allow backspacing on the given values

" Visuals {{{1
"
" Set up gvim, colour schemes and the like.

if has('gui_running')
   if has('win32') || has('win64')
       set guifont=DejaVu_Sans_Mono:h11,Consolas:h11,Courier_New:h11
   else
       set guifont=Monospace\ 11                " Fallback to system default
   endif
   set guioptions-=T                       " Hide toolbar
   set guioptions-=m                       " Hide menu bar
   set guioptions-=r                       " Hide right hand scroll bar
   set guioptions-=L                       " Hide left hand scroll bar
   set background=dark
   colorscheme solarized
else
   set background=dark
   colorscheme zenburn
endif

" Mappings {{{1
"
" vim does funny things with inline comments here, so don't use them.

" Map leader (the dedicated user-mapping prefix key) to comma
let mapleader = ","

" Leader + v to open vimrc in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>

" Leader + t to open a new tab
nmap <leader>t :tabnew<CR>

" Open a file (relative to the current file)
" See: http://vimcasts.org/episodes/the-edit-command/
" Synonyms: {e: edit, where: {w: window, s: split, v: vertical split, t: tab}}
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Silently open a shell in the directory of the current file
if has("win32") || has("win64")
   map , :silent !start cmd /k cd %:p:h <CR>
endif

" Return to normal mode
inoremap jj <ESC>

" Always move between wrapped lines
nnoremap j gj
nnoremap k gk

" Move between splits with CTRL+[hjkl]
nnoremap <C-h> <C-w>h       
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Disable search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" Sudo to write
if has ('unix')
   "cmap w!! w !sudo tee % 
endif

" Function keys {{{2

" Toggle NERDTree plugin
map <F2> :NERDTreeToggle<CR>

" Toggle paste mode (particularly useful to temporarily disable autoindent)
set pastetoggle=<F3>

" Toggle spelling and show it' status
map <F3> :setlocal spell! spell?<CR>

" Disabled keys {{{2

" Disable arrow keys (force good habits)
"nnoremap <up> <nop>
"nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
"inoremap <up> <nop>
"inoremap <down> <nop>
"inoremap <left> <nop>
"inoremap <right> <nop>
"vnoremap <up> <nop>
"vnoremap <down> <nop>
"vnoremap <left> <nop>
"vnoremap <right> <nop>

" Disable help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Plugins {{{1

" NERDTree
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$']

" snipMate
let g:snips_author='Tom Vincent <http://www.tlvince.com/contact/>'
let g:snippets_dir="$XDG_CONFIG_HOME/vim/bundle/snipmate-snippets"

" Autocommands {{{1
if has('autocmd')
   "" Always fold Python files
   "autocmd! Filetype python set foldmethod=indent
   "" Ein Tab entspricht vier Leerzeichen (wie in PEP 8 definiert)
   "" Dies aber nur für python, damit es nicht mit anderen (ruby, c, Makefiles)
   "" kolidiert
   "autocmd! FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4
   "" Start python on F5
   autocmd! FileType python map <F5> :w<CR>:!python2 "%"<CR>

   " Re-source vimrc whenever changes are saved
   "autocmd BufWritePost vimrc source $MYVIMRC

   " Bind leader + p to preview Markdown files
   autocmd! Filetype markdown nmap <leader>p :call PreviewMarkdown()<CR>

   " Fold Markdown files based on the heading level
   autocmd! Filetype markdown set foldmethod=expr foldexpr=HeadingLevel(v:lnum)
endif

" Functions {{{1

" Preview Markdown files, depending on an external script.
function! PreviewMarkdown()
   :write
   :silent !markdown "%"
   :redraw!
endfunction

" Return the level of setext and atx style headers.
" See: http://tech.groups.yahoo.com/group/vim/message/120033
function! HeadingLevel(lnum)
   let l1 = getline(a:lnum)

   " Ignore empty lines
   if l1 =~ '^\*$'
       return '='
   endif

   " Setext-style headers begin on the line below
   let l2 = getline(a:lnum+1)
   if l2 =~ '^=\+\*'
       return '>1'
   elseif l2 =~ '^-\+\*'
       return '>2'

   " Check for atx-style headers
   elseif l1 =~ '^#'
       return '>'.matchend(l1, '^#\+')

   " Otherwise keep the previous foldlevel
   else
       return '='
   endif
endfunction

" Some personal preferences {{{1

" Statusline Format
set statusline=%<%F%h%m%r%h%w%y\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ pos:%o\ lin:%l\,%L\ %P

" map M to :marks
noremap M :marks

"" completion
"set completeopt=longest,menuone
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
 ""\ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

"inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
 ""\ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


"====================
" syntax highlighting
"====================
" Abaqus
"au BufRead,BufNewFile *.inp set filetype=abaqus
"au! Syntax abaqus source /home/martin/.vim/syntax/abaqus.vim

" map key for taglist
noremap <F8> :TlistToggle<CR>

set ls=2
let g:Tex_DefaultTargetFormat = 'pdf'

" These settings are needed for latex-suite
let g:tex_flavor='latex'
set grepprg=grep\ -nH\ $*

set sw=2
set iskeyword+=:

source /home/martin/.config/vim/pythonvimrc
source /home/martin/.config/vim/mylatex.vim

" Replace the word under the cursor ,
:nnoremap <Leader> :%s/\<<C-r><C-w>\>/
