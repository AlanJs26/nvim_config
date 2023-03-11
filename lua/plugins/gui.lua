vim.g.Hexokinase_highlighters = {'backgroundfull'}

return {
  'markonm/traces.vim',
  'eandrju/cellular-automaton.nvim',
  'sheerun/vim-polyglot',
  { 'elkowar/yuck.vim', ft = 'yuck' },

  { 'mhinz/vim-signify', event = 'VimEnter' },
  {
    'rrethy/vim-hexokinase',
    build = 'make hexokinase'
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
      require('indent_blankline').setup {
        filetype_exclude = {
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
        },
        space_char_clankline = " ",
        show_current_context = true,
        show_current_context_start = false,
      }

      vim.api.nvim_set_hl(0, 'IndentBlanklineChar',  {fg = "#26273b"})
    end
  },
  {
    'nyngwang/NeoZoom.lua',
    -- dependencies = {
    --   'nyngwang/NeoNoName.lua' -- you will need this if you want to use the keymap sample below.
    -- },
    config = function()
      require('neo-zoom').setup { -- use the defaults or UNCOMMENT and change any one to overwrite
        -- left_ratio = 0.2,
        -- top_ratio = 0.03,
        width_ratio = 0.87,
        -- height_ratio = 0.9,
        -- border = 'double',
        -- exclude_filetypes = {
        --   'fzf', 'qf', 'dashboard'
        -- }
        -- scrolloff_on_zoom = 13, -- offset to the top-border.
      }
      local NOREF_NOERR_TRUNC = { silent = true, nowait = true }
      vim.keymap.set('n', 'go', require("neo-zoom").neo_zoom, NOREF_NOERR_TRUNC)

      -- My setup (This requires NeoNoName.lua, and optionally NeoWell.lua)
      -- local cur_buf = nil
      -- vim.keymap.set('n', 'go', function ()
      --   if require('neo-zoom').FLOAT_WIN ~= nil
      --     and vim.api.nvim_win_is_valid(require('neo-zoom').FLOAT_WIN) then
      --     vim.cmd('NeoZoomToggle')
      --     vim.api.nvim_set_current_buf(cur_buf)
      --     return
      --   end
      --   -- don't zoom-in on floating win.
      --     if vim.api.nvim_win_get_config(0).relative ~= '' then return end
      --     cur_buf = vim.api.nvim_get_current_buf()
      --   vim.cmd('NeoZoomToggle')
      --   vim.cmd('wincmd p')
      --   -- local try_get_no_name = require('neo-no-name').get_current_or_first_valid_listed_no_name_buf()
      --   -- if try_get_no_name ~= nil then
      --   --   vim.api.nvim_set_current_buf(try_get_no_name)
      --   -- else
      --   --   vim.cmd('NeoNoName')
      --   -- end
      --   vim.cmd('wincmd p')
      --   -- Post pop-up commands
      --   -- vim.cmd('NeoWellJump')
      -- end, NOREF_NOERR_TRUNC)

    end,
  },
{
    'RRethy/vim-illuminate',
    config = function()
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
    end
},

}
