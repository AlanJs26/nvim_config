call plug#begin('~/AppData/Local/nvim/autoload/plugged')

    Plug 'skywind3000/asyncrun.vim'
    Plug 'tpope/vim-sleuth'

    Plug 'machakann/vim-highlightedyank'
    Plug 'justinmk/vim-sneak'
    Plug 'wellle/targets.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'kqito/vim-easy-replace'

    Plug 'kana/vim-textobj-user'
    Plug 'kana/vim-textobj-indent'
    Plug 'kana/vim-textobj-entire'

    Plug 'arecarn/vim-selection'
    Plug 'arecarn/vim-crunch'

    if !exists('vscode')

      if has("python3")
          Plug 'honza/vim-snippets'
          Plug 'SirVer/ultisnips'
      endif

      Plug 'nvim-lua/plenary.nvim'
      Plug 'MunifTanjim/nui.nvim'
      Plug 'ryanoasis/vim-devicons'

      Plug 'sheerun/vim-polyglot'

      " Plug 'nvim-lua/popup.nvim'
      " Plug 'mhinz/vim-startify'

      Plug 'nvim-telescope/telescope.nvim'
      Plug 'folke/which-key.nvim'

      " Plug 'akinsho/bufferline.nvim'
      " Plug 'nvim-lualine/lualine.nvim'

      " Plug 'kyazdani42/nvim-tree.lua'
      "Plug 'preservim/nerdtree'

      " Plug 'mhinz/vim-signify'

      Plug 'mg979/vim-visual-multi', {'branch': 'master'}

      Plug 'neovim/nvim-lspconfig'
      Plug 'tami5/lspsaga.nvim'
      Plug 'williamboman/nvim-lsp-installer'
      Plug 'hrsh7th/cmp-nvim-lsp'
      Plug 'hrsh7th/cmp-buffer'
      Plug 'hrsh7th/cmp-path'
      Plug 'hrsh7th/cmp-cmdline'
      Plug 'quangnguyen30192/cmp-nvim-ultisnips'
      Plug 'hrsh7th/nvim-cmp'
      Plug 'ray-x/lsp_signature.nvim'
      Plug 'eeeXun/lspkind-nvim'

      " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
      " Plug 'nvim-treesitter/nvim-treesitter-textobjects'

      Plug 'preservim/nerdcommenter'

      " Plug 'folke/zen-mode.nvim'

      Plug 'folke/tokyonight.nvim', { 'branch': 'main' } 
      Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } 
      " Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' } 
      " Plug 'mtikekar/nvim-send-to-term' 

      " Plug 'hoschi/yode-nvim'
      " Plug 'simrat39/symbols-outline.nvim'
      " Plug 'windwp/nvim-spectre'

      " Plug 'reedes/vim-pencil'
      " Plug 'nathanaelkane/vim-indent-guides'

      " Plug 'mattn/emmet-vim', { 'for': ['markdown', 'html', 'jsxtypescript'] }

      Plug 'lervag/vimtex'
      Plug 'plasticboy/vim-markdown'
      " Plug 'antoinemadec/FixCursorHold.nvim', { 'for': ['markdown'] }
      " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

      " Plug 'stevearc/vim-arduino', { 'for': ['arduino'] }
    endif

    " Plug 'AndrewRadev/splitjoin.vim'
    Plug 'rhysd/clever-f.vim'
    " Plug 'AndrewRadev/sideways.vim'
    " Plug 'airblade/vim-rooter'

    "Plug 'rakr/vim-one'
    "Plug 'qwertologe/nextval.vim'
    "Plug 'vim-airline/vim-airline'
    " Plug 'tpope/vim-unimpaired'
    "Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    " Plug 'terryma/vim-expand-region' 

    Plug 'tpope/vim-repeat'
    Plug 'inkarkat/vim-ingo-library'
    " Plug 'inkarkat/vim-visualrepeat'
    Plug 'inkarkat/vim-ReplaceWithRegister'

    Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
    " Plug 'markonm/traces.vim'
    " Plug 'tpope/vim-abolish', { 'on': '<Plug>(abolish-coerce-word)' }
    " Plug 'tpope/vim-fugitive', { 'on': 'Git' }

    " Plug 'tommcdo/vim-exchange'
    " Plug 'zhou13/vim-easyescape'
    


call plug#end()

