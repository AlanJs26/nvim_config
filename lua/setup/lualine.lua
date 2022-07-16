vim.cmd([[
" au BufEnter * if len(getbufinfo({'buflisted': 1})) > 1 | set showtabline=2 |endif
au BufEnter,BufLeave,VimEnter * if len(getbufinfo({'buflisted': 1})) == 1 | set showtabline=0| let g:filename=expand('%:t')|let g:showmodified='%m' |else| set showtabline=2| let g:filename=''|let g:showmodified='' |endif

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
    disabled_filetypes = {},
    always_divide_middle = true,
    },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'g:folderName', 'g:filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      --'encoding',
      'g:showmodified',
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
