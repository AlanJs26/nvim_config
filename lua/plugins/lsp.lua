return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'glepnir/lspsaga.nvim',
      'ray-x/lsp_signature.nvim',
      'hrsh7th/nvim-cmp'
    },
    event = 'BufRead',
    config = function()

      -- Setup lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local nvim_lsp = require('lspconfig')
      local on_attach = function(client, bufnr)

        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        require "lsp_signature".on_attach({
            handler_opts = {
              border = 'single',
            },
            toggle_key = '<M-x>',
            transparency = 10
          })

        -- Mappings.
        local opts = { noremap=true, silent=true }
        -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gD', '<Cmd>Lspsaga peek_definition<CR>', opts)
        buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

        buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
        -- buf_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
        -- buf_set_keymap('i', '<C-k>', '<Cmd>Lspsaga hover_doc<CR>', opts)

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

      require 'nvim-treesitter.install'.compilers = {'clang', 'gcc', 'python'}


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
      local attach_winblend = function(handler)
        return function(err, result, ctx, config)
          local bufnr, winnr = handler(err, result, ctx, config)
          if winnr ~= nil then
            vim.api.nvim_win_set_option(winnr, 'winblend', 10)
          end
          return bufnr, winnr
        end
      end

      local pop_opts = { border = "single", max_width = 80 }
      local lsp_handlers_signature = lsp.with(handlers.signature_help, pop_opts)
      local lsp_handlers_hover = lsp.with(handlers.hover, pop_opts)

      handlers["textDocument/hover"] = attach_winblend(lsp_handlers_hover)
      handlers["textDocument/signatureHelp"] = attach_winblend(lsp_handlers_signature)

      vim.cmd("hi FloatBorder guifg=#7aa2f7 guibg=#1f2335ff")
      vim.cmd("hi NormalFloat guifg=#c0caf5 guibg=#1f2335ff" )




      --- lsp-saga
      -- use custom config

      -- require('lspsaga').setup({
      --   ui = {
      --     theme = 'round',
      --     diagnostic = "",
      --     code_action = "",
      --
      --   },
      --   outline = {
      --     auto_preview = false,
      --   },
      --   symbol_in_winbar = {
      --     enable = true,
      --     show_file = false
      --   },
      --   lightbulb = {
      --     enable = true,
      --     sign = true,
      --     enable_in_insert = true,
      --     sign_priority = 20,
      --     virtual_text = true,
      --   },
      -- })
      require('lspsaga').setup({
          outline = {
            auto_preview = false
          },
          ui = {
            theme = 'round',
            title=false,
            winblend = 10,
            colors = {
              normal_bg = '#1D202F'
            }
          }
        })
      -- require('lspsaga').init_lsp_saga({
      --   border_style = "rounded", 
      --   diagnostic_header = { "", "", "", "" },
      --   -- show_diagnostic_source = true,
      --   code_action_icon = "",
      --   show_outline = {
      --     auto_preview = false,
      --     auto_enter = false,
      --   },
      --   symbol_in_winbar = {
      --     enable = true,
      --     show_file = false
      --   },
      --   code_action_lightbulb = {
      --     enable = true,
      --     sign = true,
      --     enable_in_insert = true,
      --     sign_priority = 20,
      --     virtual_text = true,
      --   },
      -- })


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
      ]])
    end
  },
  {
    'akinsho/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp'
    },
    ft = 'dart',
    config = function()
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
    end
  },
  'j-hui/fidget.nvim'

}
