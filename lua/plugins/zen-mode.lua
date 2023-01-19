return {
  'folke/zen-mode.nvim',
  config =function()
  require("zen-mode").setup {
    window = {
        options = {
            number = false
        }
    },
    plugins = {
        options = {
            enabled = true,
            ruler = false,
            showcmd = false
        }
    },
  }
  end,
  cmd = "ZenMode"
}
