require'pounce'.setup{
  accept_keys = "JKLHUIOPYNMÇBFDGTREVCX",
  accept_best_key = "<enter>",
  multi_window = true,
  debug = false,
}

vim.cmd([[
nmap s <cmd>Pounce<CR>
nmap S <cmd>PounceRepeat<CR><CR>
vmap s <cmd>Pounce<CR>
omap gs <cmd>Pounce<CR> 
]])
