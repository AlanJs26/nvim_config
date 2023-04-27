local function get_setup(name)
  return string.format('require("setup.%s")', name)
end

return {

  -- libs
  'skywind3000/asyncrun.vim',

  'stevearc/dressing.nvim',
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',

  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', },

  'ryanoasis/vim-devicons',
  'kyazdani42/nvim-web-devicons',

  -- theme
  {
    'folke/tokyonight.nvim',
    branch = 'main',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = 'storm'
      if vim.fn.has('win32') == 1 then
        vim.g.tokyonight_style = 'night'
      end

      require('tokyonight').setup({
        style = vim.g.tokyonight_style,
        transparent = false,
      })

      vim.cmd([[ colorscheme tokyonight ]])
    end
  },

  -- ui/ide related plugins
  { 'ziontee113/color-picker.nvim', config = true },

  { 'mbbill/undotree', cmd = "UndotreeToggle"  },
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    config = function()
      vim.api.nvim_create_autocmd("FileType", {    
          callback = function()                                                                                                                       
            vim.api.nvim_buf_set_keymap(0, "n","çs","gq",{})
          end,    
          pattern = { 'fugitive' },                                                                                                               
          group = 'fugitive',                                                                                                                        
        })

    end
  },

  -- writing essentials
  'tpope/vim-repeat',
  'jiangmiao/auto-pairs',
  'tpope/vim-surround',
  'rhysd/clever-f.vim',

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
      txtobjs = require("various-textobjs")
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

  -- less important writing plugins
  'junegunn/vim-easy-align',
  'tommcdo/vim-exchange',


  {
    'mg979/vim-visual-multi',
    branch = 'master',
    keys = {"çc", { "<C-n>", mode = {'v', 'n'} }},
  },
  -- use 'inkarkat/vim-visualrepeat'

  -- language specific 
  { 'mattn/emmet-vim',
    ft = {'markdown', 'html', 'jsxtypescript', 'javascripttypescript', 'javascript', 'javascriptreact'}
  },

}
