local function get_setup(name)
  return string.format('require("setup.%s")', name)
end

return {

  -- libs
  'skywind3000/asyncrun.vim',

  'stevearc/dressing.nvim',
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',

  'ryanoasis/vim-devicons',
  'kyazdani42/nvim-web-devicons',

  -- theme
  { 'folke/tokyonight.nvim', branch = 'main' },

  -- gui related
  'markonm/traces.vim',
  'eandrju/cellular-automaton.nvim',

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
            "color-picker"
          }
        })
      require("scrollbar.handlers.search").setup()
    end
  },

  { 'sheerun/vim-polyglot' },

  { 'mhinz/vim-signify', event = 'VimEnter' },

  -- ui/ide related plugins
  { 'ziontee113/color-picker.nvim', config = true
  },

  { 'mbbill/undotree', cmd = "UndotreeToggle"  },
  { 'tpope/vim-fugitive', cmd = 'Git' },

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

  { 'echasnovski/mini.ai', config = function() require('mini.ai').setup({
    mappings = {
        around_next = '',
        inside_next = '',
        around_last = '',
        inside_last = '',
    }
  })end, priority = 100, lazy = false},

  {
    "chrisgrieser/nvim-various-textobjs",
    config = function () 
      txtobjs = require("various-textobjs")
      txtobjs.setup({ useDefaultKeymaps = true })
      vim.keymap.set({"o", "x"}, "gG", "Nop")
      vim.keymap.set({"o", "x"}, "ie", txtobjs.entireBuffer)
    end,
  },

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    keys = {'gS'},
    config = function()
      require('treesj').setup()
      vim.keymap.set( {'n'}, 'gS', ':TSJToggle<cr>' )
    end,
  },



  -- less important writing plugins

  { 'mg979/vim-visual-multi', branch = 'master', keys = {"çc", "<C-n>"} },
  -- use 'inkarkat/vim-visualrepeat'

  {'junegunn/vim-easy-align', event = 'VimEnter'},
  { 'tommcdo/vim-exchange', keys = {"cx", "X"} },


  -- start menu and sessions



  -- snippets
  'rafamadriz/friendly-snippets',

  -- lsp



  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', },

  -- language specific 
  { 'mattn/emmet-vim',
    ft = {'markdown', 'html', 'jsxtypescript', 'javascripttypescript', 'javascript', 'javascriptreact'}
  },


  {
    "iurimateus/luasnip-latex-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require'luasnip-latex-snippets'.setup()

      require'user.latexsnippets'.setup()
      require'user.markdownsnippets'.setup()
    end,
    ft = { "tex", "markdown" },
  },

  { 'lervag/vimtex',  ft = {'markdown', 'tex', 'latex'} },
  { 'plasticboy/vim-markdown',  ft = {'markdown'} },

  {
      "iamcco/markdown-preview.nvim",
      build = function() vim.fn["mkdp#util#install"]() end,
      ft = { 'markdown' },
  },

  { 'stevearc/vim-arduino',  ft = {'arduino'}, cond = (not vim.fn.has('win32')) },
}