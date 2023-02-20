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
  -- {
  --   'echasnovski/mini.move',
  --   version = false,
  --   config = function()
  --     require('mini.move').setup({
  --     -- Module mappings. Use `''` (empty string) to disable one.
  --     mappings = {
  --       -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
  --       left = '<M-h>',
  --       right = '<M-l>',
  --       down = '<M-j>',
  --       up = '<M-k>',
  --
  --       -- Move current line in Normal mode
  --       line_left = '<M-h>',
  --       line_right = '<M-l>',
  --       line_down = '<M-j>',
  --       line_up = '<M-k>',
  --     },
  --
  --     -- Options which control moving behavior
  --     options = {
  --       -- Automatically reindent selection during linewise vertical move
  --       reindent_linewise = true,
  --     },
  --   })
  -- end
  -- },
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

  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter' },
    keys = {'gS'},
    config = function()
      require('treesj').setup({
          use_default_keymaps = false
      })
      vim.keymap.set( {'n'}, 'gS', ':TSJToggle<cr>' )
    end,
  },



  -- less important writing plugins

  {
    'mg979/vim-visual-multi',
    branch = 'master',
    keys = {"çc", "<C-n>"},
  },
  -- use 'inkarkat/vim-visualrepeat'

  {'junegunn/vim-easy-align', event = 'VimEnter'},
  { 'tommcdo/vim-exchange', keys = {"cx", "X"} },



  -- language specific 
  { 'mattn/emmet-vim',
    ft = {'markdown', 'html', 'jsxtypescript', 'javascripttypescript', 'javascript', 'javascriptreact'}
  },

}
