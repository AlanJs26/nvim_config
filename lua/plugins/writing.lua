return {
  -- writing essentials
  'tpope/vim-repeat',
  {
    'jiangmiao/auto-pairs',
    config = function()
      vim.g.AutoPairsShortcutToggle = ''
      vim.g.AutoPairsMapCh = 0
      vim.cmd([[
        au Filetype python let b:AutoPairs = AutoPairsDefine({"f'":"'", "r'":"'"})
      ]])
    end
  },
  -- {
  --   'tpope/vim-surround',
  --   config = function()
  --     vim.g["surround_"..vim.fn.char2nr('q')] = "\"\r\""
  --     vim.g["surround_"..vim.fn.char2nr('o')] = "**\r**"
  --     vim.g["surround_"..vim.fn.char2nr('i')] = "*\r*"
  --     vim.g["surround_"..vim.fn.char2nr('=')] = "==\r=="
  --     vim.g["surround_"..vim.fn.char2nr('u')] = "~~\r~~"
  --   end
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
          -- Configuration here, or leave empty to use defaults
        })
    end
  },
  { 
    'rhysd/clever-f.vim',
    config = function() 
      vim.g.clever_f_highlight_timeout_ms = 650
      vim.g.clever_f_ignore_case = 1
    end
  },

  {
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      dependencies = { 'rafamadriz/friendly-snippets' },
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
      event = "BufRead"
    },
  },

  {
    'inkarkat/vim-ReplaceWithRegister',
    dependencies = {
      { 'inkarkat/vim-ingo-library' }
    } 
  },
  {
    'echasnovski/mini.ai',
    priority = 100,
    lazy = false,
    config = function()
      require('mini.ai').setup({
          mappings = {
            around_next = '',
            inside_next = '',
            around_last = '',
            inside_last = '',
          }
        })
    end
  },

  {
    "chrisgrieser/nvim-various-textobjs",
    config = function () 
      local txtobjs = require("various-textobjs")

      txtobjs.setup({ useDefaultKeymaps = true })

      vim.api.nvim_del_keymap("o", "gG")
      vim.api.nvim_del_keymap("x", "gG")
      vim.api.nvim_del_keymap("x", "r")

      vim.api.nvim_clear_autocmds({
          pattern = "markdown,toml",
          group = "VariousTextobjs"
        })

      vim.keymap.set({"o", "x"}, "ie", txtobjs.entireBuffer)
    end,
  },

  -- {
  --   'Wansmer/treesj',
  --   dependencies = { 'nvim-treesitter', },
  --   lazy = true,
  --   keys = {'gS'},
  --   config = function()
  --     require('treesj').setup({
  --         use_default_keymaps = false,
  --         check_syntax_error = false,
  --         dot_repeat = false,
  --         cursor_behaior = 'hold',
  --         langs = {
  --           python = {
  --             list = {
  --               both = {
  --                 recursive = true,
  --                 separator = '',
  --                 last_separator = false
  --               }
  --             }
  --           }
  --         }
  --     })
  --     vim.keymap.set('n', 'gS', require('treesj').toggle )
  --   end,
  -- },

  {
    'AndrewRadev/splitjoin.vim',
    config = function()
      vim.cmd([[
        let g:splitjoin_split_mapping = ''
        let g:splitjoin_join_mapping = ''
        let g:splitjoin_quiet = 1
        let g:splitjoin_normalize_whitespace = 1

        let g:splitjoin_curly_brace_padding = 1

        let g:splitjoin_python_brackets_on_separate_lines = 1
      ]])
      vim.keymap.set('n', 'gS', ':SplitjoinSplit<cr>' )
      vim.keymap.set('n', 'GS', ':SplitjoinJoin<cr>' )
    end

  },

  {
    'ggandor/lightspeed.nvim', config = function()

      require'lightspeed'.setup {
        ignore_case = true,
        exit_after_idle_msecs = { unlabeled = 1000, labeled = 1200 },
        --- s/x ---
        jump_to_unique_chars = { safety_timeout = 400 },
        match_only_the_start_of_same_char_seqs = true,
        force_beacons_into_match_width = false,
        -- Display characters in a custom way in the highlighted matches.
        substitute_chars = { ['\r'] = '¬', },
        -- Leaving the appropriate list empty effectively disables "smart" mode,
        -- and forces auto-jump to be on or off.
        -- These keys are captured directly by the plugin at runtime.
        limit_ft_matches = 4,
        repeat_ft_with_target_char = false,
      }

      local opts = {noremap = true}

      vim.keymap.set('n', ';', '<Plug>Lightspeed_;_sx', opts)
      vim.keymap.set('n', ',', '<Plug>Lightspeed_,_sx', opts)
      vim.keymap.set('n', 'gs', '<Plug>Lightspeed_omni_s', opts)

      vim.keymap.set('n', 'X', '<Plug>Lightspeed_omni_s', opts)

    end 
  },

  -- less important writing plugins
  {
    'junegunn/vim-easy-align',
    config = function()

      vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
      vim.keymap.set('n', 'gaip', '<Plug>(EasyAlign)ip')
      vim.keymap.set('n', 'gaap', '<Plug>(EasyAlign)ip')

    end
  },
  { 
    'tommcdo/vim-exchange', 
    config = function()
      vim.keymap.set('x', 'X', '<Plug>(Exchange)')
    end
  },


  {
    'mg979/vim-visual-multi',
    branch = 'master',
    init = function()
      vim.cmd([[
        autocmd BufEnter * silent! iunmap ça
        autocmd BufEnter * silent! iunmap çi

        let g:VM_leader = 'ç'     
        let g:VM_maps = {}
        let g:VM_set_statusline = 0
        let g:VM_mouse_mappings = 1
        let g:VM_silent_exit = 1
        let g:VM_show_warnings = 0
        let g:VM_custom_remaps = {'gl': '$'}
        let g:VM_maps["Add Cursor Down"] = '<C-c>' 
        let g:VM_custom_remaps["gl"] = '$BE' 
      ]])

    end
  },
  -- use 'inkarkat/vim-visualrepeat'


  -- language specific 
  {
    'mattn/emmet-vim',
    ft = {'markdown', 'html', 'jsxtypescript', 'javascripttypescript', 'javascript', 'javascriptreact', 'typescriptreact'},
    config = function()
      vim.g.user_emmet_install_global = 1
      vim.g.user_emmet_leader_key='ç'
    end
  },

}
