return { 'nvim-lualine/lualine.nvim', config = function()

vim.api.nvim_create_autocmd({'BufEnter', 'VimEnter'}, {    
  callback = function()                                                                                                                       
    if #vim.fn.getbufinfo({buflisted = 1}) <= 1 then
      vim.o.showtabline = 0
    else
      vim.o.showtabline = 2
    end
  end,    
  pattern = { '*' }                                                                                                               
})

vim.api.nvim_create_autocmd('BufDelete', {    
  callback = function()                                                                                                                       
    local buf_type = vim.api.nvim_buf_get_option(0, "buftype")
    if #vim.fn.getbufinfo({buflisted = 1}) <= 2 and buf_type ~= 'nofile' then
      vim.o.showtabline = 0
    else
      vim.o.showtabline = 2
    end
  end,    
  pattern = { '*' }                                                                                                               
})



require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
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
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = {
      { "vim.fn.expand('%:p:h:t')" },
      { "vim.fn.expand('%:t')" },
      {
        "vim.o.modified and '●' or ''",
        padding = { left = 0, right = 1 },
        color = { fg = '#9ece6a' }
      },
    },
    lualine_x = {
      { 
        'diagnostics',
        sources = { "nvim_lsp" },
        symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' }
      },
      {
        'vim.fn.reg_recording() ~= "" and "recording "..vim.fn.reg_recording() or ""',
        color = { fg = '#ffbc03' }
      },
      "vim.o.scrollbind and ' ' or ''",
      {
        function()
          local status = require('user.git_status').status
          if status.staged + status.unstaged == 0 then
            return ''
          end

          return '痢'..status.staged..'|'..status.unstaged
        end,
        color = { fg = '#545c7e' }
      },
      {
        function ()
          local status = require('user.git_status').status
          local output = ''
          if status.ahead ~= 0 then
            output = output..status.ahead..' '
          end
          if status.behind ~= 0 then
            output = output..status.behind..''
          end

          return output
        end,
        padding = 0,
        color = { fg = '#545c7e' }
      },
      'filetype'
      },
    lualine_y = { 'progress' },
    lualine_z = {
      {
        function()
          local num_selected = math.abs(vim.fn.line(".") - vim.fn.line("v")) + 1
          return num_selected > 1 and num_selected or ''
        end,
        padding = { left = 1, right = 0 }
      },
      {
        "vim.fn.wordcount()['visual_chars'] or ''",
        padding = { left = 1, right = 0 }
      },
      'location'
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = { 'g:arduino_serial_baud', 'g:arduino_serial_port' }
  },
  tabline = {},
  extensions = { 'fugitive' }
  }
  end, event = "VimEnter" }
