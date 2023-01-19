  return { 'akinsho/bufferline.nvim', config = function()

require("bufferline").setup{
  highlights = {
    fill = {
      bg = '#202336'
    }
  },
  options = {
    persist_buffer_sort = true,
    show_close_icon = false,
    --separator_style = {'', ''},
    
    custom_filter = function(buf,buf_nums)
      local api = vim.api

      local currentwin = api.nvim_get_current_win()
      local currentbuf = api.nvim_win_get_buf(currentwin)

      for _,win in ipairs(api.nvim_list_wins()) do
        local win_buf = api.nvim_win_get_buf(win)
        if win ~= currentwin and currentbuf ~= win_buf and buf == win_buf then
          return false
        end
      end

      return true
    end
  },
}


vim.cmd([[
nmap <silent> <M-[>   :BufferLineCycleNext  <CR>
nmap <silent> <M-]>   :BufferLineCyclePrev  <CR>

nmap <silent> <M-Enter>   :BufferLineMoveNext  <CR>
" nnoremap <silent> <C-[>   :BufferLineMoveNext<CR>

" bufferline
if g:tokyonight_style == 'storm'
  highlight BufferLineBackground cterm=italic gui=italic guibg=#202336 guifg=#4b61a3
  highlight BufferLineCloseButton cterm=italic gui=italic guibg=#202336 guifg=#4b61a3
  highlight BufferlineSeparator guibg=#1D202F guifg=#1D202F
  highlight BufferlineTabSelected guifg=#354166

  highlight BufferLineBufferSelected cterm=bold gui=bold guifg=#91adff
endif
]])
  end, event = "VimEnter" }
