
-- Search, open and create terminal with one mapping
function searchTerminal(shouldsplit, preferclose)
  local api = vim.api
  local bufs = api.nvim_list_bufs()
  local currentwin = api.nvim_get_current_win()
  local currentbuf = api.nvim_get_current_buf()

  local w = api.nvim_win_get_width(currentwin)
  local h = api.nvim_win_get_height(currentwin)

  local isterm = string.find(api.nvim_buf_get_name(currentbuf), 'myterm')
  --local shouldsplit = true
  --local preferclose = true

  if isterm then
    if api.nvim_win_get_config(currentwin).relative ~= '' or preferclose then
      api.nvim_win_close(currentwin, false)
    else
      api.nvim_command(':wincmd p')
    end
    return
  end

  for _,win in ipairs(api.nvim_list_wins()) do
    local buf = api.nvim_win_get_buf(win)
    local bufname = api.nvim_buf_get_name(buf)

    if string.find(bufname, 'myterm') then
      api.nvim_set_current_win(win)
      vim.fn.feedkeys('i')
      return
    end
  end

  local foundbuffer = nil

  for _,buf in ipairs(bufs) do
    if string.find(api.nvim_buf_get_name(buf), 'myterm')  then
      foundbuffer = buf
      break
    end
  end

  local floatopts = {
    width = w-15,
    height = h-7,
    relative = 'win',
    row = 3 ,
    col = 7,
    border = 'rounded'
  }
  if foundbuffer == nil then
    if shouldsplit then
      api.nvim_command(':vsp|term')
      -- api.nvim_command(':SendHere')
      foundbuffer = api.nvim_get_current_buf()
      vim.fn.setbufvar(foundbuffer, '&buflisted', 0)
    else
      foundbuffer = api.nvim_create_buf(false, false)

      api.nvim_open_win(foundbuffer, true, floatopts )
      api.nvim_command('term')
      -- api.nvim_command(':SendHere')
      vim.fn.setbufvar(foundbuffer, '&buflisted', 0)
    end
    api.nvim_buf_set_name(foundbuffer, 'myterm')
  else
    if shouldsplit then
      api.nvim_command(':vsp')
      api.nvim_win_set_buf(0,foundbuffer)
    else
      api.nvim_open_win(foundbuffer, true, floatopts )
    end
  end
  vim.o.number = false
  vim.fn.feedkeys('i')
end

vim.keymap.set('n', '<A-p>', function()searchTerminal(false,false)end, {noremap = true, silent = true})
vim.keymap.set('t', '<A-p>', function()searchTerminal(false,false)end, {noremap = true, silent = true})

vim.keymap.set('n', '<A-d>', function()searchTerminal(true,true)end, {noremap = true, silent = true})
vim.keymap.set('t', '<A-d>', "<C-\\><C-n>", {noremap = true, silent = true})


-- command to rename current file
function rename_file( args )
    local old_name = vim.fn.expand('%')
    local new_name = args.args
    initial_buffer = vim.api.nvim_get_current_buf()
    if new_name ~= '' and new_name ~= old_name then
        vim.api.nvim_command('saveas '..new_name)
        vim.api.nvim_command('silent !rm '..old_name)
        vim.cmd('redraw!')
        end_buffer = vim.api.nvim_get_current_buf()

        if initial_buffer ~= end_buffer then
            vim.api.nvim_buf_delete(initial_buffer)
        end

    end
end
vim.api.nvim_create_user_command('Rename', rename_file, { nargs='?' })

vim.cmd('cnoreabbrev rename Rename')

