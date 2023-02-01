return {
  'akinsho/bufferline.nvim',
  event = "VimEnter",
  config = function()

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
    ]])
  end
}
