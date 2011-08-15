""""""""""""""""""""
"    pathogen
""""""""""""""""""""
filetype off
filetype plugin off
filetype indent off

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" How to install plugins:
" =======================
" git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive
" git add .
" git commit
"
""""""""""""""""""""
" General settings
""""""""""""""""""""
set nocompatible
colorscheme molokai

" Editing behaviour {{{
filetype on
filetype plugin on
filetype indent on
syntax on

set encoding=utf-8              " use UTF-8 encoding
set number                      " always show line numbers


" formating options for text
" see http://vimcasts.org/episodes/hard-wrapping-text/ for more infos
set formatoptions=qrn1
set wrap                        " wrap lines
set textwidth=79
set colorcolumn=79
set linebreak
set list
set listchars=tab:▸\ ,eol:¬

" tabs and whitespaces
set tabstop=4                   " a tab is four spaces
set shiftwidth=4                " number of spaces to use for autoindenting
set softtabstop=4
set noexpandtab                 " use whitspace instaed of tab

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set smarttab
                                " if there is only one window
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling

set ttyfast
set cursorline                  " highlight current line


" === search and replace ===
set showmatch
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set ignorecase                  " Make searches case-sensitive only if they contain upper-case characters
set smartcase
set gdefault                    " gdefault applies substitutions globally on lines

set foldmethod=indent
set mouse=a                     " enable using the mouse if terminal emulator

" global undo file
set undofile                    " use global undo
set undodir=~/.vim/undo         " this folder for global undo

" }}}

" Vim behaviour {{{
set hidden                      " Allow backgrounding buffers without writing them, and remember marks/undo for backgrounded buffers
set history=1000                " Remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                " who did ever restore from swap files anyway?
set wildmenu                    " Make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                " first full match
"set wildmode=longest,list       " GRB: use emacs-style tab completion when selecting files, etc
set title                       " change the terminal's title
set novisualbell                " no visual flash on error
set noerrorbells                " don't beep
set ruler                       " show the cursor position all the time
set showcmd                     " show (partial) command in the last line of the screen
                                " this also shows visual selection info
set autoread                    " automatically update the buffer if file got
                                " updated in the meantime: see :help W11

" Enabling copy and paste between vim instances 
set clipboard=unnamed


" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" }}}


""""""""""""""""""""
"   GUI settings
""""""""""""""""""""
if has("gui_running")
    " set color scheme and font
    colorscheme molokai
    set guifont=Monospace\ 9


    " higlight misspeled python stuff differently
    highlight SpellBad term=underline gui=undercurl guisp=Orange 
    

    " hide the toolbar in GUI mode
    set go-=T
    " Don't show scroll bars in the GUI
    set guioptions-=L
    set guioptions-=r
end


" higligt mode
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red

""""""""""""""""""""
" statusline
""""""""""""""""""""
set laststatus=2                " tell VIM to always put a status line in, even
" cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
" format markers:
"   %< truncation point
"   %n buffer number
"   %f relative path to file
"   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
"   %r readonly flag [RO]
"   %y filetype [ruby]
"   %= split point for left and right justification
"   %-35. width specification
"   %l current line number
"   %L number of lines in buffer
"   %c current column number
"   %V current virtual column number (-n), if different from %c
"   %P percentage through buffer
"   %) end of width specification
set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)

" Number of screen lines to use for the command-line
set cmdheight=2


" different color for autocomplete menu
highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30


" activate proto syntax hl
augroup filetype
    au! BufRead,BufNewFile *.proto setfiletype proto
augroup end


if has("autocmd")
  " auto save on losing focus
  autocmd FocusLost * :wa

  " Source the vimrc file after saving it
  autocmd bufwritepost .vimrc source $MYVIMRC
  
  " rm trailing whitesprce for c files
  " http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
  autocmd BufWritePre *.c :%s/\s\+$//e
  autocmd BufWritePre *.cpp :%s/\s\+$//e
  autocmd BufWritePre *.h :%s/\s\+$//e

  " rm trailing whitesprce for python files
  " http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
  autocmd BufWritePre *.py :%s/\s\+$//e
  autocmd FileType python set expandtab

  " highlight variable under cursor (not smart)
  autocmd BufRead,BufNewFile *.py,*.pyw,*.c  autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))
endif


" Octave Syntax
augroup filetypedetect
  autocmd! BufRead,BufNewFile *.m,*.oct setfiletype octave
augroup END


" Soft wrapping text
" http://vimcasts.org/episodes/soft-wrapping-text/
" simply enter :Wrap
command! -nargs=* Wrap set wrap linebreak nolist textwidth=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   Mappings -- Shortcut mappings {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remap leader
let mapleader=","


" additional esc with ii
inoremap ii <ESC>


" clear the search buffer when hitting return
nnoremap <leader><space> :nohlsearch<CR>


" Insert Date 
nmap <leader>st a<C-R>=strftime("<%Y-%m-%d %a>")<CR><Esc>
imap ,st <C-R>=strftime("<%Y-%m-%d %a>")<CR>


" Don't use Ex mode, use Q for formatting
"map Q gq


" toggle list
nmap <leader>sl :set list!<CR>


" map autocompletion to cmd space
if has("gui")
    " C-Space seems to work under gVim on both Linux and win32
    inoremap <C-Space> <C-n>
else " no gui
  if has("unix")
    inoremap <Nul> <C-n>
  else
  " I have no idea of the name of Ctrl-Space elsewhere
  endif
endif


" Substitute word under cursor. VERY useful
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>/


" change working dir to file
map <leader>cd :cd %:p:h<CR>


" use regular regex (not vim style) for search
nnoremap / /\v
vnoremap / /\v


" spellchecker
set spelllang=de_de
nmap <silent> <leader>ss :set spell!<CR>


" open .vimrc in new tab with: ,v
nmap <leader>sv :tabedit $MYVIMRC<CR>


" split window stuff
" open split window
nnoremap <leader>v <C-w>v<C-w>l
" left
nnoremap <C-n> <C-w>h
" down
nnoremap <C-e> <C-w>j
" up
nnoremap <C-u> <C-w>k
" down
nnoremap <C-i> <C-w>l


" Start python on F5
autocmd FileType python map <F5> :w<CR>:!python "%"<CR>


" nicer cursor movements:
" use visible lines instead of real lines for cursor movement
" NOTE: " due to the fact that I use colemak I have mapped AltGr+(n|e|i|u)
" to cursormovements.
map <up> gk
map <down> gj


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              PLUGIN SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""
"  python syntax
""""""""""""""""""""
" better python highlighting - see syntax/python.vim for more details
let python_highlight_all = 1


""""""""""""""""""""
"    PyFlakes
""""""""""""""""""""
" Set this option in your vimrc file to disable quickfix support for pyflakes
let g:pyflakes_use_quickfix = 0



""""""""""""""""""""
"    ConqueTerm
""""""""""""""""""""
nmap <leader>z :ConqueTerm zsh <CR>


""""""""""""""""""""
"     OrgMode
""""""""""""""""""""
nmap <leader>wo :e ~/org/index.org<CR>
let g:org_todo_keywords = ['TODO', '|', 'DONE']
let g:org_todo_keyword_faces = [['TODO', [':foreground red', ':weight bold']], ['DONE', [':foreground green', ':weight bold']]]


""""""""""""""""""""
" a.vim
""""""""""""""""""""
" switch between .h and .cpp
map <C-TAB> :A <CR>


""""""""""""""""""""
" Ack
""""""""""""""""""""
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
:nnoremap <leader>a :LAck 


""""""""""""""""""""
" NERDTree
""""""""""""""""""""
:nnoremap <leader>n :NERDTreeToggle<CR>


""""""""""""""""""""
" git fugitive
""""""""""""""""""""
:nnoremap <leader>gs :Gstatus<CR>
:nnoremap <leader>gd :Gdiff<CR>
:nnoremap <leader>gw :Gwrite<CR>
:nnoremap <leader>gc :Gcommit<CR>


""""""""""""""""""""""""
" SnipMate
""""""""""""""""""""""""
" need to source this file -- http://code.google.com/p/snipmate/issues/detail?id=66
" Why?
source ~/.vim/bundle/snipmate/after/plugin/snipMate.vim


"""""""""""""""""""""""""
"   vim-easymotion      "
"""""""""""""""""""""""""
let g:EasyMotion_leader_key = '<Leader>m'


"""""""""""""""""""""""""
" Command-T options
"""""""""""""""""""""""""
let g:CommandTMaxFiles=2000
let g:CommandTMaxHeight=20
let g:CommandTMatchWindowAtTop=0
set wildignore+=*.o,*.obj,*.pyc


"""""""""""""""""""""""""
" ctags and tag list 
"""""""""""""""""""""""""
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
"set tags=./tags,./../tags,./../../tags,./../../../tags,tags
let Tlist_WinWidth = 40
let Tlist_Use_Right_Window = 1
map <F4> :TlistToggle<cr>


"""""""""""""""""""""""""
"         Latex
"""""""""""""""""""""""""
" important: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" use xelatex for compiling (becaus I use the Libertine font)
let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat = 'pdf'
"let g:Tex_ViewRule_pdf = 'evince'
let g:Tex_MultipleCompileFormats = 'pdf'
