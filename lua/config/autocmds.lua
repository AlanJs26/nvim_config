-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.cmd([[
autocmd FileType markdown set spelllang=pt_br,en_us | inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
]])
