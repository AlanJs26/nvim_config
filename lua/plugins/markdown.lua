return {
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      vim.g.mkdp_preview_options = {
        disable_sync_scroll = 0,
      }
    end,
    ft = { "markdown" },
  },
}
