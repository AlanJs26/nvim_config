local options = {
  clipboard   = 'unnamedplus',
  autochdir   = true,
  -- shell       = 'C:/cygwin64/bin/bash.exe',
  mouse       = "a",
  cursorline  = true,
  spell       = false,
  foldmethod  = "syntax",
  foldlevel   = 99,
  scrolloff   = 7,
  shiftwidth  = 2,
  tabstop     = 2,
  expandtab   = true,
  smartcase   = true,
  ignorecase  = true,
  timeoutlen  = 300,
  updatetime  = 250,
  encoding    = "UTF-8",
  undodir     = vim.fn.stdpath("config").."\\.vim\\undo",
  undofile    = true,
  report      = 30,
  lazyredraw  = true,
  gdefault    = true,
  cmdheight   = 1,
  hidden      = true,
  showmode    = false,
  splitright  = true,
  splitbelow  = true,
  number      = true,
  swapfile    = false,
  wrap        = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.g.maplocalleader = "ç"

vim.g.tokyonight_style = 'storm' -- available: night, storm
vim.g.tokyonight_enable_italic = 1


vim.cmd([[
  colorscheme tokyonight

  syntax enable
  set cpoptions+=y
  set cinkeys-=:

  autocmd BufRead * set scroll=7
  autocmd FileType python set tabstop=4
  autocmd FileType python set shiftwidth=4

  " Makes the Conceal color more visible
  autocmd BufEnter * highlight Conceal ctermfg=14 ctermbg=242 guifg=#525975 guibg=#24283b

  " Cursorline
  highlight CursorLine   cterm=NONE guibg=#2C2F45 guifg=NONE

  if has('win32')
    let g:python3_host_prog = expand('~')..'/miniconda3/python.exe'
  endif

  autocmd BufEnter,BufNew *.ino :ArduinoChoosePort /dev/ttyUSB0
  autocmd BufEnter,BufNew *.ino :ArduinoSetBaud 115200
  autocmd BufEnter,BufNew *.md :setlocal spell
  autocmd FileType markdown,text set spelllang=pt_br,en_us

  " fix last spell error
  autocmd FileType markdown,text inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
  autocmd User Startified set spelllang=pt_br,en_us | inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
]])
