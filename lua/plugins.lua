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

function get_setup(name)
  return string.format('require("setup.%s")', name)
end


-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  -- Packer can manage itself
  use { 'wbthomason/packer.nvim' }
  -- use { vim.fn.stdpath('data')..'/plugin' }

  -- libs
  use { 'skywind3000/asyncrun.vim' }
  use { 'airblade/vim-rooter' }

  use { 'nvim-lua/plenary.nvim' }
  use { 'MunifTanjim/nui.nvim' }
  use { 'ryanoasis/vim-devicons',
      { 'kyazdani42/nvim-web-devicons' }
  }
  use { 'mtikekar/nvim-send-to-term' }


  -- ui related
  use { 'machakann/vim-highlightedyank' }
  use { 'markonm/traces.vim' }

  use { 'sheerun/vim-polyglot', event = 'BufRead' }

  use { 'folke/zen-mode.nvim', config = get_setup('zen-mode'), cmd = "ZenMode" }
  use { 'rrethy/vim-hexokinase',  run = 'make hexokinase'  }

  use { 'mhinz/vim-signify', event = 'VimEnter' }
  use { 'nathanaelkane/vim-indent-guides', event = 'BufRead' }

  -- ui/ide related plugins
  use { 'nvim-telescope/telescope.nvim', config = get_setup('telescope') }
  use { 'jvgrootveld/telescope-zoxide', config = get_setup('zoxide') }

  use { 'folke/which-key.nvim', config = get_setup('which-key'), module = 'which-key', keys = '<space>' }

  use { 'akinsho/bufferline.nvim', config = get_setup('bufferline'), event = "VimEnter" }
  use { 'nvim-lualine/lualine.nvim', config = get_setup('lualine'), event = "VimEnter" }
  use { 'kyazdani42/nvim-tree.lua', config = get_setup('nvimtree') }

  use { 'simnalamburt/vim-mundo', cmd = "MundoToggle", disable = true  }
  use { 'simrat39/symbols-outline.nvim', config = get_setup('symbols-outline'), cmd = { "SymbolsOutline", "SymbolsOutlineOpen" }}
  use { 'tpope/vim-fugitive', cmd = 'Git' }

  -- theme
  use { 'folke/tokyonight.nvim', branch = 'main' }

  -- writing essentials
  use { 'justinmk/vim-sneak', disable = true }
  use { 'wellle/targets.vim' }
  use { 'jiangmiao/auto-pairs' }
  use { 'tpope/vim-surround' }
  use { 'rhysd/clever-f.vim' }
  use { 'tpope/vim-repeat' }

  use { 'inkarkat/vim-ReplaceWithRegister', requires = {
      { 'inkarkat/vim-ingo-library' }
  } }

  use { 'kana/vim-textobj-user',
      { 'kana/vim-textobj-indent' },
      { 'kana/vim-textobj-entire' }
  }

  use { 'preservim/nerdcommenter', event = "BufRead", disable = true }
  use { 'numToStr/Comment.nvim', config = get_setup('comment') }

  -- less important writing plugins
  use { 'arecarn/vim-selection' }
  use { 'arecarn/vim-crunch', event = 'VimEnter' }

  use { 'mg979/vim-visual-multi', branch = 'master', keys = {"??c", "<C-n>"} }
  use { 'AndrewRadev/splitjoin.vim', keys = "gS" }
  use { 'AndrewRadev/sideways.vim', event = 'BufRead' }
  -- use 'inkarkat/vim-visualrepeat'

  use { 'ggandor/lightspeed.nvim', config = get_setup('lightspeed') }
  use { 'benfrain/pounce.nvim', config = get_setup('pounce'), disable = true }
  use {'junegunn/vim-easy-align', event = 'VimEnter'}
  use { 'tommcdo/vim-exchange', keys = "cx" }
  -- use { 'tpope/vim-abolish'}


  use { 'honza/vim-snippets' }
  use { 'SirVer/ultisnips' }


  -- start menu and sessions
  use { 'mhinz/vim-startify', config = get_setup('startify'), disable = true }
  use { 'goolord/alpha-nvim', config = get_setup('alpha'), requires = {
      { 'kyazdani42/nvim-web-devicons' }
  } }

  use { 'rmagatti/auto-session', config = get_setup('auto-session') }
  use { 'AlanJs26/session-lens', config = get_setup('session-lens') }

  -- lsp
  use { 'neovim/nvim-lspconfig', config = get_setup('lsp'), event = 'BufRead' }

  use {
    'tami5/lspsaga.nvim',
    { 'williamboman/nvim-lsp-installer'},
    { 'ray-x/lsp_signature.nvim' },
    { 'eeeXun/lspkind-nvim' },
    event = 'BufRead'
  }

  use { 'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'quangnguyen30192/cmp-nvim-ultisnips' }
      -- {'hrsh7th/cmp-cmdline'},
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

  use { 'lervag/vimtex',  ft = {'markdown', 'tex', 'latex'} }
  use { 'plasticboy/vim-markdown',  ft = {'markdown'} }
  use { 'antoinemadec/FixCursorHold.nvim',  ft = {'markdown'} }

  use { 'stevearc/vim-arduino',  ft = {'arduino'} }
  -- end




  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end


end)

vim.cmd('source '..custom_compile_path)
