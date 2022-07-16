local fn = vim.fn

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

return packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'skywind3000/asyncrun.vim'

  use 'machakann/vim-highlightedyank'
  use 'justinmk/vim-sneak'
  use 'wellle/targets.vim'
  use 'jiangmiao/auto-pairs'
  use 'tpope/vim-surround'

  use 'kana/vim-textobj-user'
  use 'kana/vim-textobj-indent'
  use 'kana/vim-textobj-entire'

  use 'arecarn/vim-selection'
  use { 'arecarn/vim-crunch', event = 'VimEnter' }

  -- if not fn.exists('vscode') then

    -- if vim.fn.has("python3") or vim.fn.has("python")
        use 'honza/vim-snippets'
        use 'SirVer/ultisnips'
    -- end

    use 'nvim-lua/plenary.nvim'
    use { 'MunifTanjim/nui.nvim' }
    use 'ryanoasis/vim-devicons'
    use { 'kyazdani42/nvim-web-devicons' }

    use { 'sheerun/vim-polyglot', event = 'BufRead' }

    use { 'mhinz/vim-startify', config = get_setup('startify'), disable = true }


    use { 'goolord/alpha-nvim', config = get_setup('alpha'), requires = {
      { 'kyazdani42/nvim-web-devicons' }
    } }

    use { 'rmagatti/auto-session', config = get_setup('auto-session') }


    -- use { 'nvim-telescope/telescope-fzf-native.nvim',
      -- run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    -- }

    use { 'nvim-telescope/telescope.nvim', config = get_setup('telescope') }

    use {'jvgrootveld/telescope-zoxide', config = get_setup('zoxide')}

    use { 'AlanJs26/session-lens', config = get_setup('session-lens') }

    use { 'folke/which-key.nvim', config = get_setup('which-key'), keys = "<space>" }

    use { 'akinsho/bufferline.nvim', config = get_setup('bufferline'), event = "VimEnter" }
    use { 'nvim-lualine/lualine.nvim', config = get_setup('lualine'), event = "VimEnter" }

    use { 'kyazdani42/nvim-tree.lua', config = get_setup('nvimtree') }

    use { 'mhinz/vim-signify', event = 'VimEnter' }

    use { 'mg979/vim-visual-multi', branch = 'master', keys = {"çc", "<C-n>"} }

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


    use { 'preservim/nerdcommenter', event = "BufRead", disable = true }

    use { 'numToStr/Comment.nvim', config = get_setup('comment') }

    use { 'folke/zen-mode.nvim', config = get_setup('zen-mode'), cmd = "ZenMode" }

    use { 'folke/tokyonight.nvim', branch = 'main' }
    use { 'rrethy/vim-hexokinase',  run = 'make hexokinase'  }
    use { 'simnalamburt/vim-mundo', cmd = "MundoToggle"  }
    use { 'mtikekar/nvim-send-to-term' }

    use { 'simrat39/symbols-outline.nvim', config = get_setup('symbols-outline'), cmd = { "SymbolsOutline", "SymbolsOutlineOpen" }}

    use { 'nathanaelkane/vim-indent-guides', event = 'BufRead' }

    use { 'mattn/emmet-vim',
       ft = {'markdown', 'html', 'jsxtypescript', 'javascripttypescript', 'javascript', 'javascriptreact'}
    }

    use { 'lervag/vimtex',  ft = {'markdown', 'tex', 'latex'} }
    use { 'plasticboy/vim-markdown',  ft = {'markdown'} }
    use { 'antoinemadec/FixCursorHold.nvim',  ft = {'markdown'} }

    use { 'stevearc/vim-arduino',  ft = {'arduino'} }
  -- end

  use { 'AndrewRadev/splitjoin.vim', keys = "gS" }
  use 'rhysd/clever-f.vim'
  use { 'AndrewRadev/sideways.vim', event = 'BufRead' }
  use 'airblade/vim-rooter'

  use 'tpope/vim-repeat'
  use 'inkarkat/vim-ingo-library'
  -- use 'inkarkat/vim-visualrepeat'
  use { 'inkarkat/vim-ReplaceWithRegister' }

  use {'junegunn/vim-easy-align', event = 'VimEnter'}
  use 'markonm/traces.vim'
  use { 'tpope/vim-abolish'}
  use { 'tpope/vim-fugitive', cmd = 'Git' }

  use { 'tommcdo/vim-exchange', keys = "cx" }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end


end)
