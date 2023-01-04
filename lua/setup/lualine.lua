vim.cmd([[

au BufEnter,VimEnter * if len(getbufinfo({'buflisted': 1})) <= 1 | set showtabline=0| else| set showtabline=2| endif
au BufDelete * if len(getbufinfo({'buflisted': 1})) <= 2 && &buftype != 'nofile'| set showtabline=0| else| set showtabline=2| endif

let g:folderName = ''
function UpdateFolderNameVar()
    let g:folderName=expand('%:p:h:t')
endfunction

autocmd BufEnter,BufNew * call UpdateFolderNameVar()
]])

require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {'NvimTree', 'alpha', 'Mundo'},
    always_divide_middle = true,
    },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'g:folderName', 'vim.o.modified and vim.fn.expand("%:t").." ●" or vim.fn.expand("%:t")', 'vim.o.scrollbind and " " or ""'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'vim.fn.reg_recording() ~= "" and "recording "..vim.fn.reg_recording() or ""',
      'filetype'
      },
    lualine_y = {'progress'},
    lualine_z = {'location'}
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
