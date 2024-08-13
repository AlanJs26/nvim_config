-- vim.g.Hexokinase_highlighters = {'backgroundfull'}

return {
  -- 'eandrju/cellular-automaton.nvim',
  'sheerun/vim-polyglot',
  { 'theRealCarneiro/hyprland-vim-syntax', ft = 'conf' },
  { 'kaarmu/typst.vim', ft = 'typst' },
  {
    dependencies = {
      'othree/html5.vim',
      'pangloss/vim-javascript',
    },
    'evanleck/vim-svelte',
    ft = 'svelte',
  },
  {
    'rcarriga/nvim-notify',
    lazy = true,
    config = function()
      require('notify').setup({
        timeout = 1000
      })
    end
  },
  { 'elkowar/yuck.vim', ft = 'yuck'},

  -- {
  --   'nmac427/guess-indent.nvim',
  --   dependencies = { 'folke/which-key.nvim' },
  --   config = function()
  --     require('guess-indent').setup()
  --     local wk = require('which-key')
  --
  --     wk.register({
  --         l = {
  --           i = {':GuessIndent<cr>', 'Guess indent'}
  --         }
  --       }, {prefix = '<leader>', nowait = true})
  --
  --   end,
  -- },

  {
    "caenrique/swap-buffers.nvim",
    config = function()
      local swap = require('swap-buffers')
      swap.setup()

      vim.keymap.set('n', '<c-w><c-l>', function() swap.swap_buffers('l') end, {desc = 'swap right'})
      vim.keymap.set('n', '<c-w><c-h>', function() swap.swap_buffers('h') end, {desc = 'swap left'})
      vim.keymap.set('n', '<c-w><c-j>', function() swap.swap_buffers('j') end, {desc = 'swap down'})
      vim.keymap.set('n', '<c-w><c-k>', function() swap.swap_buffers('k') end, {desc = 'swap up'})
    end
  },

  {
    'mhinz/vim-signify',
    event = 'VimEnter',
    config = function()
      vim.g.signify_sign_add               = '▎'
      vim.g.signify_sign_delete            = '▎'
      vim.g.signify_sign_delete_first_line = '▎'
      vim.g.signify_sign_change            = '▎'
      vim.g.signify_priority=1
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  {
    "petertriho/nvim-scrollbar", 
    dependencies = { 'kevinhwang91/nvim-hlslens' },
    event = 'BufRead',
    config = function ()
      require("scrollbar").setup({
          show_in_active_only = true,
          hide_if_all_visible = true,
          handle = {
            hide_if_all_visible = true,
          },
          excluded_filetypes = {
            "NvimTree",
            "prompt",
            "TelescopePrompt",
            "noice",
            "alpha",
            "lazy",
            "color-picker"
          }
        })
      require("scrollbar.handlers.search").setup()
    end
  },
  {
    'folke/zen-mode.nvim',
    config =function()
      require("zen-mode").setup {
        window = {
          options = {
            number = false
          }
        },
        plugins = {
          options = {
            enabled = true,
            ruler = false,
            showcmd = false
          }
        },
      }
    end,
    cmd = "ZenMode"
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = function()
      require('ibl').setup {
        exclude = {
          filetypes = {
            "help",
            "terminal",
            "alpha",
            "packer",
            "lspinfo",
            "NvimTree",
            "TelescopePrompt",
            "TelescopeResults",
            "startup-log.txt",
            "Mundo"
          }
        },
      }
      vim.api.nvim_set_hl(0, 'IndentBlanklineChar',  {fg = "#26273b"})
    end
  },
  {
    'nyngwang/NeoZoom.lua',
    lazy = true,
    config = function()
      require('neo-zoom').setup { -- use the defaults or UNCOMMENT and change any one to overwrite
        winopts = {
          offset = {
            width = 0.87,
          }
        }
      }
      local NOREF_NOERR_TRUNC = { silent = true, nowait = true }
      vim.keymap.set('n', 'go', ':NeoZoomToggle<cr>', NOREF_NOERR_TRUNC)

    end,
  },

  { 'echasnovski/mini.cursorword', version = '*', config = function() 
      require('mini.cursorword').setup()

      vim.cmd([[
        " augroup MiniCursorword
        "     autocmd!

        hi MiniCursorword          cterm=underline gui=underline guibg=none
        hi MiniCursorwordCurrent   cterm=underline gui=underline guibg=none
        " autocmd VimEnter * hi illuminatedWordText  cterm=underline gui=underline guibg=none
        " autocmd VimEnter * hi illuminatedWordWrite cterm=underline gui=underline guibg=none
        " autocmd VimEnter * hi illuminatedWordRead  cterm=underline gui=underline guibg=none

        " augroup END
        ]])
    end
  },

  -- {
  --   'RRethy/vim-illuminate',
  --   config = function()
  --     require('illuminate').configure({
  --         -- providers: provider used to get references in the buffer, ordered by priority
  --         providers = {
  --           'lsp',
  --           'treesitter',
  --           'regex',
  --         },
  --         -- delay: delay in milliseconds
  --         delay = 100,
  --         filetype_overrides = {},
  --         filetypes_denylist = {
  --           'dirvish',
  --           'fugitive',
  --           'alpha',
  --           'NvimTree',
  --         },
  --         under_cursor = true,
  --         large_file_cutoff = nil,
  --         large_file_overrides = nil,
  --         min_count_to_highlight = 2,
  --       })
  --     vim.cmd([[
  --         augroup illuminate_augroup
  --             autocmd!
  --
  --             autocmd VimEnter * hi illuminatedWord      cterm=underline gui=underline guibg=none
  --             autocmd VimEnter * hi illuminatedCurWord   cterm=underline gui=underline guibg=none
  --             autocmd VimEnter * hi illuminatedWordText  cterm=underline gui=underline guibg=none
  --             autocmd VimEnter * hi illuminatedWordWrite cterm=underline gui=underline guibg=none
  --             autocmd VimEnter * hi illuminatedWordRead  cterm=underline gui=underline guibg=none
  --
  --         augroup END
  --     ]])
  --   end
  -- },

}
