set nocompatible

" Setup runtime path for plugins
" at the same time it's easy to see what plugins are loaded
" pathogen didn'd really work :(
"set runtimepath+=$HOME/.vim/bundle/vim-conque
set runtimepath+=$HOME/.vim/bundle/git-vim
set runtimepath+=$HOME/.vim/bundle/nerdtree
set runtimepath+=$HOME/.vim/bundle/Command-T
set runtimepath+=$HOME/.vim/bundle/vim-latex

filetype on
filetype plugin indent on

set number
syntax on
colorscheme desert

" Sane default values
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=78
set smarttab
set expandtab
set laststatus=2
set showmatch
set incsearch

"set autoindent
set foldmethod=indent

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Remember more commands and search history
set history=1000

" Make tab completion for files/buffers act like bash
set wildmenu

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" show the cursor position all the time
set ruler		
" display incomplete commands
set showcmd		

" GRB: hide the toolbar in GUI mode
if has("gui_running")
    set go-=T
end

" avoid error msg that have to do with fish shell
if $SHELL =~ 'bin/fish'
    set shell=/bin/sh
endif

" Don't show scroll bars in the GUI
set guioptions-=L
set guioptions-=r

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  "set guifont=Monaco:h12
  "set guifont=Inconsolata-dz:h12
endif

" GRB: use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" GRB: Put useful info in status line
set statusline=%<%f%=\ [%1*%M%*%n%R%H]\ %-19(%3l,%02c%03V%)%O'%02b'
hi User1 term=inverse,bold cterm=inverse,bold ctermfg=red
" Number of screen lines to use for the command-line
set cmdheight=2

" GRB: clear the search buffer when hitting return
nnoremap <CR> :nohlsearch<CR>/<BS>


if version >= 700
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    "let Tlist_Ctags_Cmd='~/bin/ctags'
endif

" higlight misspeled python stuff
if has("gui_running") 
    highlight SpellBad term=underline gui=undercurl guisp=Orange 
endif 

" activate proto syntax hl
augroup filetype
    au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" highlight current line
set cursorline

" better python highlighting - see syntax/python.vim for more details
let python_highlight_all = 1

" formating options for text
" see http://vimcasts.org/episodes/hard-wrapping-text/ for more infos
set formatoptions=t


" highlight variable under cursor (not smart)
au BufRead,BufNewFile *.py,*.pyw,*.c  autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

" different color for autocomplete menu
highlight Pmenu ctermfg=1 ctermbg=4 guibg=grey30


"""""""""""""""""""""
"   Mappings
"""""""""""""""""""""

" remap leader
let mapleader=","

" map F2 to open NERDTree
map <F2> :NERDTreeToggle<CR>

" Insert Date with F3
nmap <F3> a<C-R>=strftime("%Y-%m-%d %a")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d %a")<CR>

" Don't use Ex mode, use Q for formatting
"map Q gq

" Map ESC tp Control + Space
" In Mac OS X, mapping <S-space> does not work
"imap <C-space> <Esc>

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
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/


" spellchecker
nmap <silent> <leader>s :set spell!<CR>
set spelllang=de_de

" open .vimrc in new tab with: ,v
nmap <leader>v :tabedit $MYVIMRC<CR>


" Start python on F5
autocmd FileType python map <F5> :w<CR>:!python "%"<CR>

" tab navigation that is like the firefox one
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>


" load pydict file for autocompletion
" MUST be the absolute path!!!
let g:pydiction_location = '/Users/otte/.vim/ftplugin/pydiction/complete-dict'


" nicer cursor movements
" due to the fact that I use colemak
" left
map <C-n> h
" right
map <C-i> l
" up
map <C-u> k
" down
map <C-e> j


" Soft wrapping text
" http://vimcasts.org/episodes/soft-wrapping-text/
" simply enter :Wrap
command! -nargs=* Wrap set wrap linebreak nolist textwidth=0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             Latex
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
" set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
"let g:tex_flavor='latex'

" use xelatex for compiling (becaus I use the Libertine font)
"let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode $*'

