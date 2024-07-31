
vim.cmd([[
  autocmd BufEnter,BufNew *.md :setlocal spell
  autocmd FileType markdown,text set spelllang=pt_br,en_us

  autocmd FileType markdown inoremap <C-b> **
  autocmd FileType markdown inoremap <C-i> __

  " fix last spell error
  autocmd FileType markdown,text inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
  autocmd User Startified set spelllang=pt_br,en_us | inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
]])

return {
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip", "lervag/vimtex" },
    config = function()
      require'luasnip-latex-snippets'.setup({
          use_treesitter = false
        })

      require'user.latexsnippets'.setup()
      require'user.markdownsnippets'.setup()
    end,
    ft = { "tex", "markdown" },
  },

  {
    'jbyuki/nabla.nvim',
    ft = {'tex', 'latex', 'markdown'},
    config = function()
      vim.keymap.set('n', 'K', require('nabla').popup)
    end
  },
  -- {
  --   'MeanderingProgrammer/markdown.nvim',
  --   name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
  --   dependencies = { 'nvim-treesitter/nvim-treesitter' },
  --   ft = {'markdown'},
  --   config = function()
  --     require('render-markdown').setup({})
  --   end,
  -- },

  {
    'lervag/vimtex',
    ft = {'markdown', 'tex', 'latex'},
    config = function()
      vim.g.tex_flavor='latex'
      vim.g.vimtex_view_method='zathura'
      vim.g.vimtex_quickfix_mode=0
      vim.g.vim_markdown_math = 1


      vim.g.tex_conceal='abdmg'

      vim.cmd('hi Conceal ctermbg=none')

      vim.o.conceallevel=2
    end
  },
  {
      "OXY2DEV/markview.nvim",
      ft = "markdown",
      branch = 'dev',

      config = {
            modes = { 'n', 'no', 'i' },
            options = {
              hybrid_modes = { 'i' },
            }
      },
      dependencies = {
          -- You may not need this if you don't lazy load
          -- Or if the parsers are in your $RUNTIMEPATH
          "nvim-treesitter/nvim-treesitter",

          "nvim-tree/nvim-web-devicons"
      },
  },

  {
      "iamcco/markdown-preview.nvim",
      build = function() vim.fn["mkdp#util#install"]() end,
      config = function()
        vim.g.mkdp_preview_options = {
          disable_sync_scroll = 1,
        }
      end,
      ft = { 'markdown' },
  },
  -- {
  --   'plasticboy/vim-markdown',
  --   ft = {'markdown'},
  -- },
}
