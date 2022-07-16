syntax enable
set nowrap
set noswapfile
set splitbelow
set splitright
set hidden
set cmdheight=1
set gdefault
set lazyredraw


set noshowmode
set noruler
set laststatus=0
set noshowcmd




" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo
set encoding=UTF-8
set updatetime=300
set timeoutlen=300

set ignorecase
set smartcase
set cpoptions+=y

" Indent
set expandtab
set tabstop=2
set shiftwidth=2
set cinkeys-=:

set scrolloff=7
" set foldenable!
set foldlevel=99
set foldmethod=syntax
set nospell
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4

" Makes the Conceal color more visible
autocmd BufEnter * highlight Conceal ctermfg=14 ctermbg=242 guifg=#525975 guibg=#24283b

" Cursorline
" set cursorline
highlight CursorLine   cterm=NONE guibg=#2C2F45 guifg=NONE

" Enable the mouse
set mouse=a

set autochdir
set clipboard=unnamedplus

autocmd BufEnter,BufNew *.md :setlocal spell
autocmd FileType markdown,text set spelllang=pt_br,en_us

autocmd BufEnter,BufNew *.tex exec feedkeys('a')
autocmd FileType tex inoremap <C-q> <esc>:wq<cr>

" fix last spell error
autocmd FileType markdown,text inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
autocmd User Startified set spelllang=pt_br,en_us | inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

