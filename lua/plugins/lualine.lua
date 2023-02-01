return { 'nvim-lualine/lualine.nvim', config = function()

vim.cmd([[

au BufEnter,VimEnter * if len(getbufinfo({'buflisted': 1})) <= 1 | set showtabline=0| else| set showtabline=2| endif
au BufDelete * if len(getbufinfo({'buflisted': 1})) <= 2 && &buftype != 'nofile'| set showtabline=0| else| set showtabline=2| endif

let g:folderName = ''
function UpdateFolderNameVar()
    let g:folderName=expand('%:p:h:t')
endfunction

autocmd BufEnter,BufNew * call UpdateFolderNameVar()
]])

local gstatus = {ahead = 0, behind = 0, staged = 0, unstaged = 0}
local function update_gstatus()
  local Job = require'plenary.job'
  Job:new({
    command = 'git',
    args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
    on_exit = function(job, _)
      local res = job:result()[1]
      if type(res) ~= 'string' then
        gstatus.ahead = 0
        gstatus.behind = 0
        return
      end
      local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
      if not ok then 
        ahead, behind = 0, 0 
      end

      gstatus.ahead = tonumber(ahead)
      gstatus.behind = tonumber(behind)
    end,
  }):start()

  Job:new({
    command = 'git',
    args = { 'diff', '--numstat' },
    on_exit = function(job, _)
      local res = job:result()
      gstatus.unstaged = #res
    end,
  }):start()

  Job:new({
    command = 'git',
    args = { 'diff', '--numstat', '--cached' },
    on_exit = function(job, _)
      local res = job:result()
      gstatus.staged = #res
    end,
  }):start()
end


if _G.Gstatus_timer == nil then
  _G.Gstatus_timer = vim.loop.new_timer()
else
  _G.Gstatus_timer:stop()
end
_G.Gstatus_timer:start(0, 2000,  vim.schedule_wrap(update_gstatus))



require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      'NvimTree',
      'alpha',
      'Mundo',
      'undotree',
      'lazy',
      'diff'
    },
    always_divide_middle = true,
    },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      { "vim.fn.expand('%:p:h:t')" },
      { "vim.fn.expand('%:t')" },
      {
        function()
          if vim.o.modified then
            return '●'
          end
          return ''
        end,
        padding = {left = 0, right = 1},
        color = { fg = '#9ece6a' }
      },
    },
    lualine_x = {
      { 
        'diagnostics',
        sources = { "nvim_lsp" },
        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
      },
      {
        'vim.fn.reg_recording() ~= "" and "recording "..vim.fn.reg_recording() or ""',
        color = { fg = '#ffbc03' }
      },
      "vim.o.scrollbind and ' ' or ''",
      {
        function()
          if gstatus.staged + gstatus.unstaged == 0 then
            return ''
          end

          return '痢'..gstatus.staged..'|'..gstatus.unstaged
        end,
        color = { fg = '#545c7e' }
      },
      {
        function ()
          local output = ''
          if gstatus.ahead ~= 0 then
            output = output..gstatus.ahead..' '
          end
          if gstatus.behind ~= 0 then
            output = output..gstatus.behind..''
          end

          if output ~= '' then
            return output
          else
            return ''
          end
        end,
        padding = 0,
        color = { fg = '#545c7e' }
      },
      'filetype'
      },
    lualine_y = {'progress'},
    lualine_z = {
      {
        function()
          local num_selected = math.abs(vim.fn.line(".") - vim.fn.line("v")) + 1
          return num_selected > 1 and num_selected or ''
        end,
        padding = {left = 1, right = 0}
      },
      {
        function()
          local count = vim.fn.wordcount()
          if count['visual_chars'] ~= nil then
            return count['visual_chars']
          else
            return ''
          end
        end,
        padding = {left = 1, right = 0}
      },
      'location'
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {'g:arduino_serial_baud', 'g:arduino_serial_port'}
    },
  tabline = {},
  extensions = {'fugitive'}
  }
  end, event = "VimEnter" }
