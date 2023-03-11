return {
  'quarto-dev/quarto-nvim',
  ft = {'quarto'},
  dependencies = {
    'jmbuhr/otter.nvim',
    'neovim/nvim-lspconfig'
  },
  config = function()
    require 'quarto'.setup {
      lspFeatures = {
        enabled = true,
        languages = { 'r', 'python', 'julia' },
        diagnostics = {
          enabled = true,
          triggers = { "BufWrite" }
        },
        completion = {
          enabled = true
        }
      }
    }

    vim.api.nvim_create_autocmd(
      'BufReadPre',
      {
        pattern = '*.qmd',
        callback = function()
          vim.o.filetype = 'markdown'
        end
      }
    )

  end

}
