
vim.cmd([[
  highlight link LspSagaFinderSelection Search


  " nnoremap <silent>K :Lspsaga hover_doc<CR>
  " inoremap <silent> <C-k> <Cmd>Lspsaga hover_doc<CR>

  " nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
  " tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>

  " inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
  nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
  nnoremap <silent> dn :Lspsaga diagnostic_jump_next<CR>
  nnoremap <silent> dp :Lspsaga diagnostic_jump_prev<CR>
]])

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
  vim.api.nvim_buf_set_keymap(bufnr, ...) end

  require "lsp_signature".on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --...

end


local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }

  if server.name == 'sumneko_lua' then
    server:setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  })
  else
    server:setup(opts)
  end


end)



-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ''
    }
  }
)

nvim_lsp.clangd.setup{
   on_attach = on_attach,
   filetypes = {'arduino', 'c', 'cpp', 'ino'}
}

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true, disable = { 'vim' } },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",
        ["am"] = "@block.outer",
        ["im"] = "@block.inner",
      },
    },
  },
}



--- lsp-saga

local lsp = vim.lsp
local handlers = lsp.handlers

-- Hover doc popup
local pop_opts = { border = "rounded", max_width = 80 }
handlers["textDocument/hover"] = lsp.with(handlers.hover, pop_opts)
handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, pop_opts)

--
require'lspsaga'.init_lsp_saga {
  error_sign   = '',
  warn_sign    = '',
  hint_sign    = '',
  infor_sign   = '',
  border_style = "round",
  code_action_prompt = { enable = false }
}





