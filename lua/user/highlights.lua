if vim.g.tokyonight_style == 'storm' then
    vim.cmd([[
      highlight CursorLine   cterm=NONE guibg=#2C2F45 guifg=NONE

      highlight BufferLineBackground cterm=italic gui=italic guibg=#202336 guifg=#4b61a3
      highlight BufferLineCloseButton cterm=italic gui=italic guibg=#202336 guifg=#4b61a3
      highlight BufferlineSeparator guibg=#1D202F guifg=#1D202F
      highlight BufferlineTabSelected guifg=#354166
      highlight BufferLineBufferSelected cterm=bold gui=bold guifg=#91adff
    ]])
else
    vim.cmd([[highlight CursorLine   cterm=NONE guibg=#232434 guifg=NONE]])
end

vim.cmd([[
    " highlight on yank
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Constant", timeout=700}
    augroup END

    " Makes the Conceal color more visible
    autocmd BufEnter * highlight Conceal ctermfg=14 ctermbg=242 guifg=#525975 guibg=#24283b

    highlight CmpItemKind guifg=#7aa2f7 
    highlight CmpItemAbbrMatch guifg=#7aa2f7 
    highlight CmpItemAbbrMatchFuzzy guifg=#4c68a6 

    syn match Done "DONE" containedin=.*Comment  
    hi Done guifg=#565f89 gui=bold
    hi Todo guibg=none guifg=#bb9af7 gui=italic 
]])
