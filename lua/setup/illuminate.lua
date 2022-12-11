  require('illuminate').configure({
      -- providers: provider used to get references in the buffer, ordered by priority
      providers = {
          'lsp',
          'treesitter',
          'regex',
      },
      -- delay: delay in milliseconds
      delay = 100,
      filetype_overrides = {},
      filetypes_denylist = {
          'dirvish',
          'fugitive',
          'alpha',
          'NvimTree',
      },
      under_cursor = true,
      large_file_cutoff = nil,
      large_file_overrides = nil,
      min_count_to_highlight = 2,
  })
vim.cmd([[
    augroup illuminate_augroup
        autocmd!

        autocmd VimEnter * hi illuminatedWord      cterm=underline gui=underline guibg=none
        autocmd VimEnter * hi illuminatedCurWord   cterm=underline gui=underline guibg=none
        autocmd VimEnter * hi illuminatedWordText  cterm=underline gui=underline guibg=none
        autocmd VimEnter * hi illuminatedWordWrite cterm=underline gui=underline guibg=none
        autocmd VimEnter * hi illuminatedWordRead  cterm=underline gui=underline guibg=none

    augroup END
]])
