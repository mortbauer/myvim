" vimrc: a monolithic vim setup. {{{1
" Copyright 2009-2011 Tom Vincent <http://www.tlvince.com/contact/>
" vim: set fdm=marker:


" Environment {{{1
"
" A consistent runtime environment.
runtime! archlinux.vim

" Forget about vi and set it first as it modifies future behaviour
set nocompatible
filetype off

" Make vim respect the XDG base directory spec.
set directory=$XDG_CACHE_HOME/vim,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME,/usr/share/vim/vimfiles/
let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
set undodir=$XDG_CONFIG_HOME/vim/tmp

" Load plugins managed by pathogen
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


" General preferences {{{1
"
" Learn about these using vim help.
set ttymouse=urxvt

" Persistent undos
set undofile

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
set nowrapscan            " Wrap searches
set ignorecase          " Ignore search term case...
set smartcase           " ... unless term contains an uppercase character
set incsearch           " Highlight search...
set showmatch           " ... results
set hlsearch            " ... as you type

" Wrapping
"set textwidth=70        " Hard-wrap text at nth column
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
set ls=2
set sw=2
set iskeyword+=:
set cursorline          " Heighlight the line the cursor is in

" Visuals {{{1
"
" Set up gvim, colour schemes and the like.

if has('gui_running')
   if has('win32') || has('win64')
       set guifont=DejaVu_Sans_Mono:h8,Consolas:h8,Courier_New:h8
   else
       set guifont=Monospace\ 10                " Fallback to system default
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

" Statusline Format
set statusline=%<%F%h%m%r%h%w%y\ %{strftime(\"%d/%m/%Y-%H:%M\")}%=\ col:%c%V\ pos:%o\ lin:%l\,%L\ %P

" Mappings {{{1
"
" vim does funny things with inline comments here, so don't use them.

" Insert newline without going into insert mode
map <F8> o<Esc>
map <F9> O<Esc>

" Map leader (the dedicated user-mapping prefix key) to comma
let mapleader = ","

" Replace the word under the cursor ,
nnoremap <Leader> :%s/\<<C-r><C-w>\>/

" Leader + v to open vimrc in a new tab
nmap <leader>v :tabedit $MYVIMRC<CR>

" Leader + t to open a new tab
nmap <leader>t :tabnew<CR>

" M to show marks
noremap M :marks

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
   cmap w!! w !sudo tee % 
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
let g:snips_author='Martin Leopold Ortbauer'
"let g:snips_trigger_key='<S-Tab>'
let g:snippets_dir="$XDG_CONFIG_HOME/vim/bundle/snipmate-snippets,$XDG_CONFIG_HOME/vim/snippets"

" Grammar Check
let g:languagetool_jar="/usr/share/languagetool/LanguageTool.jar"
let g:languagetool_disable_rules="DE_CASE,WHITESPACE_RULE,EN_QUOTES,COMMA_PARENTHESIS_WHITESPACE"    

" Gundo
map <leader>g :GundoToggle<CR>

" Tagbar
nnoremap <F7> :TagbarToggle<CR>

" map key for taglist
noremap <F10> :TlistToggle<CR>

" Tasklist
map <leader>v <Plug>TaskList

" MakeGreen
map <Leader>] <Plug>MakeGreen

" PEP8
let g:pep8_map='<leader>8'

" Pyflakes
"let g:pyflakes_use_quickfix = 0

" notmuch
let g:notmuch_signature = ['mfg Martin' ]
let g:notmuch_initial_search_words = ['tag:unread']
let g:notmuch_folders = [
        \ [ 'unread', 'tag:inbox and tag:unread and not folder:Sent' ],
        \ [ 'inbox',  'tag:inbox and not tag:delete'                ],
        \ [ 'spam',  'tag:spam and not tag:delete'                ],
        \ [ 'sent',  'tag:sent and not tag:delete'                ],
        \ [ 'delete',  'tag:delete'                ],
        \ [ 'deleted',  'tag:deleted'                ],
        \ ]

let g:notmuch_folders_maps = {
        \ 'm':          ':call <SID>NM_new_mail()<CR>',
        \ 's':          ':call <SID>NM_search_prompt()<CR>',
        \ 'q':          ':call <SID>NM_kill_this_buffer()<CR>',
        \ '=':          ':call <SID>NM_folders_refresh_view()<CR>',
        \ '<Enter>':    ':call <SID>NM_folders_show_search()<CR>',
        \ }

" --- --- bindings for search screen {{{2
let g:notmuch_search_maps = {
        \ '<Space>':    ':call <SID>NM_search_show_thread(0)<CR>',
        \ '<Enter>':    ':call <SID>NM_search_show_thread(1)<CR>',
        \ '<C-]>':      ':call <SID>NM_search_expand(''<cword>'')<CR>',
        \ 'I':          ':call <SID>NM_search_mark_read_thread()<CR>',
        \ 'a':          ':call <SID>NM_search_archive_thread()<CR>',
        \ 'A':          ':call <SID>NM_search_mark_read_then_archive_thread()<CR>',
        \ 'D':          ':call <SID>NM_search_delete_thread()<CR>',
        \ 'f':          ':call <SID>NM_search_filter()<CR>',
        \ 'm':          ':call <SID>NM_new_mail()<CR>',
        \ 'o':          ':call <SID>NM_search_toggle_order()<CR>',
        \ 'r':          ':call <SID>NM_search_reply_to_thread()<CR>',
        \ 's':          ':call <SID>NM_search_prompt()<CR>',
        \ ',s':         ':call <SID>NM_search_edit()<CR>',
        \ 't':          ':call <SID>NM_search_filter_by_tag()<CR>',
        \ 'q':          ':call <SID>NM_kill_this_buffer()<CR>',
        \ '+':          ':call <SID>NM_search_add_tags([])<CR>',
        \ '-':          ':call <SID>NM_search_remove_tags([])<CR>',
        \ '=':          ':call <SID>NM_search_refresh_view()<CR>',
        \ '?':          ':echo <SID>NM_search_thread_id() . ''  @ '' . join(<SID>NM_get_search_words())<CR>',
        \ }

" Autocommands {{{1
if has('autocmd')
   autocmd! FileType python map <F5> :w<CR>:!python2 "%"<CR>
   autocmd BufEnter *.m    compiler mlint

   " Re-source vimrc whenever changes are saved
   "autocmd BufWritePost vimrc source $MYVIMRC
endif

" Some personal preferences {{{1

"====================
" syntax highlighting
"====================
" Abaqus
"au BufRead,BufNewFile *.inp set filetype=abaqus
"au! Syntax abaqus source /home/martin/.vim/syntax/abaqus.vim


"source /home/martin/.config/vim/python.vim
"source /home/martin/.config/vim/mylatex.vim
source /home/martin/.config/vim/addr.vim

