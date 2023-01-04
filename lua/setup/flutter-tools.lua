
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- require "lsp_signature".on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --...

end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("flutter-tools").setup{
  lsp = {
    on_attach = on_attach,
    capabilities = capabilities
  }
}
