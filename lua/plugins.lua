local fn = vim.fn
local custom_compile_path =vim.fn.stdpath('data')..'/plugin/packer_compiled.lua'

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- -- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
  compile_path = custom_compile_path,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

local function get_setup(name)
  return string.format('require("setup.%s")', name)
end


-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- Packer can manage itself
  use { 'wbthomason/packer.nvim' }

  -- libs
  use { 'skywind3000/asyncrun.vim' }
  use { 'airblade/vim-rooter' }

  use { 'nvim-lua/plenary.nvim' }
  use { 'MunifTanjim/nui.nvim' }
  use { 'ryanoasis/vim-devicons',
      { 'kyazdani42/nvim-web-devicons' }
  }
  -- use { 'mtikekar/nvim-send-to-term' }


  -- gui related
  use { 'markonm/traces.vim' }
  -- use {
  --   "smjonas/live-command.nvim",
  --   -- live-command supports semantic versioning via tags
  --   -- tag = "1.*",
  --   config = function()
  --     require("live-command").setup {
  --       commands = {
  --         Norm = { cmd = "norm" },
  --       },
  --     }
  --   end,
  -- }

  use { 'eandrju/cellular-automaton.nvim' }

  use { 'RRethy/vim-illuminate',
  config = get_setup('illuminate')}

  use {
    'nyngwang/NeoZoom.lua',
    requires = {
      'nyngwang/NeoNoName.lua' -- you will need this if you want to use the keymap sample below.
      },
      config = get_setup('neo-zoom')
  }

  -- use {
  --   "zbirenbaum/neodim",
  --   event = "LspAttach",
  --   config = function ()
  --     require("neodim").setup({
  --       alpha = 0.35,
  --       blend_color = "#ff0000",
  --       update_in_insert = {
  --         enable = true,
  --         delay = 100,
  --       },
  --       hide = {
  --         virtual_text = true,
  --         signs = true,
  --         underline = true,
  --       }
  --     })
  --   end
  -- }


  use { "petertriho/nvim-scrollbar", requires = { 'kevinhwang91/nvim-hlslens' }, config = function ()
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
        }
      })
    require("scrollbar.handlers.search").setup()

  end }

  use { 'sheerun/vim-polyglot', event = 'BufRead' }

  use { 'folke/zen-mode.nvim', config = get_setup('zen-mode'), cmd = "ZenMode" }
  use { 'rrethy/vim-hexokinase',  run = 'make hexokinase'  }

  use { 'ziontee113/color-picker.nvim', config = function ()
    require('color-picker')
  end }
  use { 'mhinz/vim-signify', event = 'VimEnter' }
  use { 'lukas-reineke/indent-blankline.nvim', event = 'BufRead', config = get_setup('indent-blankline') }

  -- ui/ide related plugins
  use { 'nvim-telescope/telescope.nvim', config = get_setup('telescope') }
  use { 'jvgrootveld/telescope-zoxide', config = get_setup('zoxide') }

  use { 'folke/which-key.nvim', config = get_setup('which-key'), module = 'which-key', keys = '<space>' }

  use { 'akinsho/bufferline.nvim', config = get_setup('bufferline'), event = "VimEnter" }
  use { 'nvim-lualine/lualine.nvim', config = get_setup('lualine'), event = "VimEnter" }
  use { 'kyazdani42/nvim-tree.lua', config = get_setup('nvimtree') }


  -- use { 'simnalamburt/vim-mundo', cmd = "MundoToggle"  }
  use { 'tpope/vim-fugitive', cmd = 'Git' }

  -- theme
  use { 'folke/tokyonight.nvim', branch = 'main' }

  -- writing essentials
  use { 'tpope/vim-repeat' }
  use { 'wellle/targets.vim' }
  use { 'jiangmiao/auto-pairs' }
  use { 'tpope/vim-surround' }
  use { 'rhysd/clever-f.vim' }

  use { 'inkarkat/vim-ReplaceWithRegister', requires = {
      { 'inkarkat/vim-ingo-library' }
  } }

  use { 'kana/vim-textobj-user',
      { 'kana/vim-textobj-indent' },
      { 'kana/vim-textobj-entire' }
  }

  use { 'numToStr/Comment.nvim', config = get_setup('comment') }

  -- less important writing plugins
  -- use { 'arecarn/vim-selection' }
  -- use { 'arecarn/vim-crunch', event = 'VimEnter' }

  use { 'mg979/vim-visual-multi', branch = 'master', keys = {"çc", "<C-n>"} }
  -- use { 'AndrewRadev/splitjoin.vim', keys = "gS" }
  -- use { 'AndrewRadev/sideways.vim', event = 'BufRead' }
  -- use 'inkarkat/vim-visualrepeat'

  use { 'ggandor/lightspeed.nvim', config = get_setup('lightspeed') }
  use {'junegunn/vim-easy-align', event = 'VimEnter'}
  use { 'tommcdo/vim-exchange', keys = {"cx", "X"} }


  -- start menu and sessions
  use { 'goolord/alpha-nvim', config = get_setup('alpha'), requires = {
      { 'kyazdani42/nvim-web-devicons' }
  } }

  use { 'rmagatti/auto-session', config = get_setup('auto-session') }
  use { 'AlanJs26/session-lens', config = get_setup('session-lens') }


  -- snippets
  use { 'rafamadriz/friendly-snippets' }
  use { 'L3MON4D3/LuaSnip', config = get_setup('luasnip') }
  -- use { 'SirVer/ultisnips' }

  -- lsp
  use { 'neovim/nvim-lspconfig', requires = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'glepnir/lspsaga.nvim' } ,
    { 'ray-x/lsp_signature.nvim' } ,
  }, config = get_setup('lsp'), event = 'BufRead' }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'eeeXun/lspkind-nvim' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-calc' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-path' },
      -- { 'quangnguyen30192/cmp-nvim-ultisnips' },
      {'hrsh7th/cmp-cmdline'},
      { 'ziontee113/color-picker.nvim' },
    },
    config = get_setup('cmp')
  }

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
    requires = {
      use {'nvim-treesitter/nvim-treesitter-textobjects'}
    }
  }


  -- language specific 
  use { 'mattn/emmet-vim',
    ft = {'markdown', 'html', 'jsxtypescript', 'javascripttypescript', 'javascript', 'javascriptreact'}
  }

  use {
    "iurimateus/luasnip-latex-snippets.nvim",
    requires = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require'luasnip-latex-snippets'.setup()
      -- or setup({ use_treesitter = true })

      require'setup.latexsnippets'.setup()
      require'setup.markdownsnippets'.setup()
    end,
    ft = { "tex", "markdown" },
  }

  use { 'lervag/vimtex',  ft = {'markdown', 'tex', 'latex'} }
  use { 'plasticboy/vim-markdown',  ft = {'markdown'} }
  -- use { 'antoinemadec/FixCursorHold.nvim',  ft = {'markdown'} }

  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
      ft = { 'markdown' },
  })

  use { 'stevearc/vim-arduino',  ft = {'arduino'}, cond = (not vim.fn.has('win32')) }
  -- end




  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end


end)

vim.cmd('source '..custom_compile_path)
