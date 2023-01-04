

-- Setup lspconfig.
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require('cmp_nvim_lsp').default_capabilities()


local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)

  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  require "lsp_signature".on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)

end


-- mason / lsp_install

require('mason').setup()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup()

mason_lspconfig.setup_handlers({
  function (server_name) -- default handler
    nvim_lsp[server_name].setup({
      on_attach = on_attach,
      capabilities = capabilities
    })
  end,
  ['pyright'] = function()
    nvim_lsp.pyright.setup({
      on_attach = function(client, bufnr)
        -- prevent duplicate pyright clients
        for _,v in ipairs(vim.lsp.get_active_clients({name = 'pyright'})) do
          buffer_in_client = false
          for bufid,_ in pairs(v.attached_buffers) do
            if bufid == bufnr then
              buffer_in_client = true
              break
            end
          end

          if v.id ~= client.id and buffer_in_client == false then
            vim.lsp.stop_client(client.id)
            vim.lsp.buf_attach_client(bufnr, v.id)
            break
          end

        end

        on_attach(client, bufnr)
      end,
      capabilities = capabilities,
    })
  end,

  ['sumneko_lua'] = function ()
    nvim_lsp.sumneko_lua.setup({
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
end,
})


-- clangd
nvim_lsp.clangd.setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  filetypes = {'arduino', 'c', 'cpp', 'ino'},
  -- cmd = {'C:/tools/clangd_14.0.3/bin/clangd.exe', '--resource-dir','C:/SFML-2.4.2;C:/tools/clangd_14.0.3/lib/clang/14.0.3/include'},
  settings = {
    clangd = {
      arguments = {
        "-IC:/SFML-2.4.2/include",
        "-LC:/SFML-2.4.2/lib",
        "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include/c++",
        "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include/c++/mingw32",
        "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include/c++/backward",
        "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include",
        "-IC:/MinGW/include",
        "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include-fixed",
      },
    }
  }
}

require 'nvim-treesitter.install'.compilers = {'clang', 'gcc'}
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




local lsp = vim.lsp
local handlers = lsp.handlers

-- icon
lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = ' '
    }
  }
)


-- Hover doc popup
local pop_opts = { border = "rounded", max_width = 80 }
handlers["textDocument/hover"] = lsp.with(handlers.hover, pop_opts)
handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, pop_opts)

--- lsp-saga
-- use custom config
require('lspsaga').init_lsp_saga({
  border_style = "rounded", 
  diagnostic_header = { "", "", "", "" },
  -- show_diagnostic_source = true,
  code_action_icon = "",
  show_outline = {
    auto_preview = false,
    auto_enter = false,
  },
  symbol_in_winbar = {
    enable = true,
    show_file = false
  },
  code_action_lightbulb = {
    enable = true,
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = true,
  },
})

vim.keymap.set('n', 'gh', "<cmd>Lspsaga lsp_finder<CR>", {silent = true})
vim.keymap.set('n', 'dn', "<cmd>Lspsaga diagnostic_jump_next<CR>", {silent = true})
vim.keymap.set('n', 'dp', "<cmd>Lspsaga diagnostic_jump_prev<CR>", {silent = true})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.cmd([[
  highlight link LspSagaFinderSelection Search

  sign define LspDiagnosticsSignHint        text=
  sign define LspDiagnosticsSignError       text=
  sign define LspDiagnosticsSignWarning     text=
  sign define LspDiagnosticsSignInformation text=

  " nnoremap <silent>K :Lspsaga hover_doc<CR>
  " inoremap <silent> <C-k> <Cmd>Lspsaga hover_doc<CR>

  " inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
]])



