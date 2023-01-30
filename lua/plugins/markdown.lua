vim.cmd([[
  autocmd BufEnter,BufNew *.md :setlocal spell
  autocmd FileType markdown,text set spelllang=pt_br,en_us

  " fix last spell error
  autocmd FileType markdown,text inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
  autocmd User Startified set spelllang=pt_br,en_us | inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
]])

return {
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
}
