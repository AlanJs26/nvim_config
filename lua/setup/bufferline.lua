require("bufferline").setup{
  highlights = {
    fill = {
      guibg = '#202336'
    }
  },
  options = {
    persist_buffer_sort = true,
    show_close_icon = false,
    --separator_style = {'', ''},
  }
}


vim.cmd([[
" bufferline
highlight BufferLineBackground cterm=italic gui=italic guibg=#202336 guifg=#4b61a3
highlight BufferLineCloseButton cterm=italic gui=italic guibg=#202336 guifg=#4b61a3
highlight BufferlineSeparator guibg=#1D202F guifg=#1D202F
highlight BufferlineTabSelected guifg=#354166

highlight BufferLineBufferSelected cterm=bold gui=bold guifg=#91adff
]])
