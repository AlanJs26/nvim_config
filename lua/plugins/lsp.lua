local wk = require('which-key')

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.offsetEncoding = "utf-8"

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  vim.o.signcolumn='yes'

  require("lsp_signature").on_attach({
      handler_opts = {
        border = 'single',
      },
      toggle_key = '<M-x>',
      transparency = 10
  })
  require("nvim-navbuddy").attach(client, bufnr)

  -- Mappings.
  local opts = { noremap=true, silent=true }
  -- buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>Lspsaga peek_definition<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)

  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
  -- buf_set_keymap('i', '<C-k>', '<Cmd>Lspsaga hover_doc<CR>', opts)

  buf_set_keymap('n', 'gh', "<cmd>Lspsaga finder<CR>", opts)
  buf_set_keymap('n', 'dn', "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  buf_set_keymap('n', 'dp', "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)


  wk.register({

    l = {
      name='+lsp',
      d= {':Lspsaga peek_definition<cr>',              'preview definition'},
      s= {':lua vim.lsp.buf.signature_help()<cr>',     'signature help'},
      t= {':Telescope lsp_document_symbols<cr>',       'telescope symbols'},
      r= {':Lspsaga rename<cr>',                       'rename'},
      c= {':Lspsaga code_action<cr>',                  'code action'},
      p= {':Lspsaga diagnostic_jump_prev<cr>',         'previous diagnostic'},
      n= {':Lspsaga diagnostic_jump_next<cr>',         'next diagnostic'},
      f= {':lua vim.lsp.buf.format{async = true}<cr>', 'formatting'},
      l= {':Lspsaga show_line_diagnostics<cr>',        'show diagnostics'},

      m= {':lua require("nvim-navbuddy").open()<cr>',  'symbols'},
      -- m= {':Lspsaga outline<cr>',                  'symbols'},
      -- l= {':lua vim.diagnostic.open_float()<cr>',    'show diagnostics'},
      -- a= {':lua vim.lsp.buf.add_workspace_folder()<cr>',                       'add wosksp folder'},
      -- A= {':lua vim.lsp.buf.remove_workspace_folder()<cr>',                    'remove worksp folder'},
      -- w= {':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', 'list workspaces'},
    },
  }, {
    prefix = "<leader>",
    nowait = true,
    mode='n',
  })


end

return {
  { 'j-hui/fidget.nvim', tag = 'legacy', config = true },
  { 'mfussenegger/nvim-dap' },
  {
    'simrat39/rust-tools.nvim',
    ft = {'rust'},
    config = function()
      local rt = require('rust-tools')

      rt.setup({
        server = {
          on_attach = on_attach,
        },
      })

    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      "SmiteshP/nvim-navbuddy",
      "SmiteshP/nvim-navic",

      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'glepnir/lspsaga.nvim',
      'ray-x/lsp_signature.nvim',
      'hrsh7th/nvim-cmp',
    },
    event = 'BufRead',
    config = function()

      -- mason / lsp_install
      local nvim_lsp = require('lspconfig')

      require('mason').setup()

      wk.register({
        l = {
          M= {':Mason<cr>', 'Mason'},
        },
      }, {
        prefix = "<leader>",
        nowait = true,
        mode='n',
      })

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
                    local buffer_in_client = false
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

          ['pylsp'] = function ()
            nvim_lsp.pylsp.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                  pylsp = {
                    plugins = {
                      pycodestyle = {
                        enabled = false,
                      },
                      -- autopep8 = {
                      --   enabled = false,
                      -- },
                    }
                  }
                }
              })
          end,

          ['lua_ls'] = function ()
            nvim_lsp.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                  Lua = {
                    runtime = {
                      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                      version = 'LuaJIT',
                    },
                    diagnostics = {
                      -- Get the language server to recognize the `vim` global
                      globals = {'vim'},
                    },
                    workspace = {
                      -- Make the server aware of Neovim runtime files
                      library = vim.api.nvim_get_runtime_file("", true),
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                      enable = false,
                    },
                  }
                }
              })
          end,

          ['clangd'] = function()
            nvim_lsp.clangd.setup {
              on_attach = on_attach,
              capabilities = capabilities,
              filetypes = {'arduino', 'c', 'cpp', 'ino'},
              -- cmd = {'C:/tools/clangd_14.0.3/bin/clangd.exe', '--resource-dir','C:/SFML-2.4.2;C:/tools/clangd_14.0.3/lib/clang/14.0.3/include'},
              offsetEncoding = { 'utf-8', 'utf-16', },
              settings = {
                clangd = {
                  -- arguments = {
                  --   "-IC:/SFML-2.4.2/include",
                  --   "-LC:/SFML-2.4.2/lib",
                  --   "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include/c++",
                  --   "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include/c++/mingw32",
                  --   "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include/c++/backward",
                  --   "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include",
                  --   "-IC:/MinGW/include",
                  --   "-IC:/MinGW/lib/gcc/mingw32/6.3.0/include-fixed",
                  -- },
                }
              }
            }
          end,
        })

      require 'nvim-treesitter.install'.compilers = {'clang', 'gcc', 'python'}


      --- Ui config ----
      local lsp = vim.lsp
      local handlers = lsp.handlers

      -- icon
      handlers["textDocument/publishDiagnostics"] = lsp.with(
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




      --- lsp-saga ---

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

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
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


      require("flutter-tools").setup{
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities
        }
      }
    end
  },

}
