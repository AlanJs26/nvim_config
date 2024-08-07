local function get_setup(name)
  return string.format('require("setup.%s")', name)
end
vim.cmd('cnoreabbrev git Git')

return {

  -- libs
  'skywind3000/asyncrun.vim',

  'stevearc/dressing.nvim',
  'nvim-lua/plenary.nvim',
  'MunifTanjim/nui.nvim',
  {
    'akinsho/toggleterm.nvim',
    version="*",
    config = function()
      tt = require("toggleterm")
      tt.setup({
        insert_mappings = false,
        terminal_mappings = false,
        direction = 'float',
        highlights = {
          FloatBorder = {
            guifg = "#7aa2f7"
          }
        }
      })

      local opts = {noremap = true, silent = true}
      vim.keymap.set('t', '<Esc>', "<C-\\><C-n>", opts)
      vim.keymap.set({'n', 't'}, '<A-p>', tt.toggle, opts)
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.install').compilers = {'clang', 'gcc', 'python'}
      require('nvim-treesitter.configs').setup({
          ensure_installed = {
              'bash',
              'fish',
              'c',
              'lua',
              'markdown',
              'python',
              'query',
              'vim',
              'latex',
          }
      })
    end
  },

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
  { 'ziontee113/color-picker.nvim', lazy = true, config = true },
  { 'mbbill/undotree', cmd = "UndotreeToggle"  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "debugloop/telescope-undo.nvim",
    },
    config = function()
      require("telescope").setup({
          extensions = {
            undo = {
              -- telescope-undo.nvim config, see below
            },
          },
        })
      require("telescope").load_extension("undo")
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
  {
    'tpope/vim-fugitive',
    cmd = 'Git',
    keys = {
      {'çs', ':Git<CR>', { noremap = true, silent = true, } }
    },
    config = function()

      vim.keymap.set('n', 'çs', ':Git<CR>', {
        noremap = true,
        silent = true,
      })

      vim.api.nvim_create_autocmd("FileType", {    
        callback = function()                                                                                                                       
          vim.cmd('wincmd L|set nonumber')
          vim.api.nvim_buf_set_keymap(0, "n","q","<cmd>close<cr>",{silent=true})
        end,    
        pattern = { 'git' },                                                                                                               
      })

      vim.api.nvim_create_autocmd("FileType", {    
          callback = function()                                                                                                                       
            vim.api.nvim_buf_set_keymap(0, "n","çs","gq",{silent = true})
            vim.api.nvim_buf_set_keymap(0, "n","q","gq" ,{silent = true})
          end,    
          pattern = { 'fugitive' },                                                                                                               
          group = 'fugitive',                                                                                                                        
        })

    end
  },



}
