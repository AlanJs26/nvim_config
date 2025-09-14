-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.cmd([[
autocmd FileType markdown set spelllang=pt_br,en_us | inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
autocmd FileType qml set shiftwidth=4|set tabstop=4
autocmd BufNewFile,BufRead,BufReadPost *.typ set filetype=typst
autocmd BufNewFile,BufRead,BufReadPost *.gazebo set filetype=xml
autocmd BufNewFile,BufRead,BufReadPost *.wbt set filetype=vrml
autocmd BufNewFile,BufRead,BufReadPost *.proto set filetype=vrml
autocmd BufNewFile,BufRead,BufReadPost *.launch set filetype=xml
autocmd BufNewFile,BufRead,BufReadPost *.urdf set filetype=xml
]])
