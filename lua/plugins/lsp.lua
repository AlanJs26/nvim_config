---@class ExtPluginLspOpts: PluginLspOpts
---@field ensure_installed string[]

return {
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "<leader>cF",
        false,
      },
      {
        "<leader>lF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
        typst = { "typstfmt" },
        python = { "black" },
      },
    },
  },
  {
    "stevearc/overseer.nvim",
    init = function()
      local overseer = require("overseer")

      require("config.toggle.overseer").focus:map("<leader>oF")
      require("config.toggle.overseer").float:map("<leader>of")

      overseer.add_template_hook({ name = ".*run.*" }, function(task_defn, util)
        if not util.has_component(task_defn, "open_output") then
          util.add_component(task_defn, { "open_output", direction = "vertical", on_start = "always" })
        end
        util.remove_component(task_defn, "on_complete_notify")
      end)
      overseer.add_template_hook({ name = ".*build.*" }, function(task_defn, util)
        util.remove_component(task_defn, "on_complete_notify")
      end)

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.cmd("OverseerRun")
        else
          if not tasks[1]:has_component("open_output") then
            tasks[1].add_component(tasks[1], { "open_output", direction = "vertical", on_start = "always" })
          end
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end,
    opts = {
      templates = {
        "builtin",
        "cpp.build_standalone",
        "cpp.run_standalone",
        "c.build_standalone",
        "c.run_standalone",
        "python.run_standalone",
      },
      task_list = {
        bindings = {
          ["o"] = function()
            local overseer = require("overseer")
            local tasks = overseer.list_tasks({ recent_first = true })

            if not vim.tbl_isempty(tasks) then
              overseer.run_action(tasks[1], "open float")
            end
            vim.fn.feedkeys("G")
          end,
        },
      },
    },
    keys = {
      { "<leader>oO", "<cmd>OverseerRun<cr>", desc = "Run task" },
      { "<leader>oB", "<cmd>OverseerLoadBundle<cr>", desc = "Load Bundle" },
      { "<leader>oo", "<cmd>OverseerRestartLast<cr>", desc = "Run last task" },
      { "<leader>or", "<cmd>OverseerQuickAction restart<cr>", desc = "Restart last task" },
      {
        "<leader>ow",
        function()
          vim.cmd("OverseerToggle")

          for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            -- Obtém o buffer associado à janela
            local buffer = vim.api.nvim_win_get_buf(win)
            -- Verifica se o filetype do buffer corresponde ao filetype desejado
            if vim.api.nvim_get_option_value("filetype", { buf = buffer }) == "OverseerList" then
              vim.fn.feedkeys("p")
            end
          end
        end,
        desc = "Task list",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "clangd",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    keys = {
      {
        "<leader>cm",
        false,
      },
      { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
    },
  },
  {
    "folke/trouble.nvim",
    dependencies = {
      "snacks.nvim",
    },
    keys = {
      { "<leader>cs", false },
      { "<leader>cS", false },
      { "<leader>ls", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>lS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
    },
  },
  {
    "nvimdev/lspsaga.nvim",
    opts = {
      lightbulb = {
        sign = false,
      },
      outline = {
        auto_preview = false,
      },
      finder = {
        toggle_or_open = "<CR>",
      },
      ui = {
        theme = "round",
        title = false,
        winblend = 10,
        colors = {
          normal_bg = "#1D202F",
        },
      },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      require("lazyvim.plugins.lsp.keymaps")._keys = {
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
        { "gh", "<cmd>Lspsaga finder<cr>", desc = "References" },
        { "<leader>lh", "<cmd>Lspsaga finder<cr>", desc = "References" },
        { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto Definition", has = "definition" },
        { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
        { "gy", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto T[y]pe Definition" },
        { "<leader>ly", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Goto T[y]pe Definition" },
        { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
        { "K", vim.lsp.buf.hover, desc = "Hover" },
        {
          "gK",
          vim.lsp.buf.signature_help,
          desc = "Signature Help",
          has = "signatureHelp",
        },
        {
          "<c-k>",
          vim.lsp.buf.signature_help,
          mode = "i",
          desc = "Signature Help",
          has = "signatureHelp",
        },
        {
          "<leader>la",
          "<cmd>Lspsaga code_action<cr>",
          desc = "Code Action",
          mode = { "n", "v" },
          has = "codeAction",
        },
        {
          "<leader>ld",
          "<cmd>Lspsaga peek_definition<cr>",
          desc = "Peek Definition",
          mode = { "n" },
          has = "definition",
        },
        { "<leader>lc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
        {
          "<leader>lC",
          vim.lsp.codelens.refresh,
          desc = "Refresh & Display Codelens",
          mode = { "n" },
          has = "codeLens",
        },
        {
          "<leader>lR",
          Snacks.rename.rename_file,
          desc = "Rename File",
          mode = { "n" },
          has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
        },
        { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
        { "<leader>lA", LazyVim.lsp.action.source, desc = "Source Action", has = "codeAction" },
        {
          "]]",
          function()
            Snacks.words.jump(vim.v.count1)
          end,
          has = "documentHighlight",
          desc = "Next Reference",
          cond = function()
            return Snacks.words.is_enabled()
          end,
        },
        {
          "[[",
          function()
            Snacks.words.jump(-vim.v.count1)
          end,
          has = "documentHighlight",
          desc = "Prev Reference",
          cond = function()
            return Snacks.words.is_enabled()
          end,
        },
        {
          "<a-n>",
          function()
            Snacks.words.jump(vim.v.count1, true)
          end,
          has = "documentHighlight",
          desc = "Next Reference",
          cond = function()
            return Snacks.words.is_enabled()
          end,
        },
        {
          "<a-p>",
          function()
            Snacks.words.jump(-vim.v.count1, true)
          end,
          has = "documentHighlight",
          desc = "Prev Reference",
          cond = function()
            return Snacks.words.is_enabled()
          end,
        },
        { "gr", false },
      }

      local unmap = function(...)
        pcall(vim.keymap.del, ...)
      end
      unmap("n", "gri")
      unmap("n", "gra")
      unmap("n", "grn")

      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue", "typescriptreact" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = false,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        ensure_installed = { "lua_ls" },
        -- LSP Server Settings
        servers = {
          lua_ls = {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = "Replace",
                },
                doc = {
                  privateName = { "^_" },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = "Disable",
                  semicolon = "Disable",
                  arrayIndex = "Disable",
                },
              },
            },
          },
          rust_analyzer = {
            settings = {
              ["rust-analyzer"] = {
                assist = {
                  importEnforceGranularity = true,
                  importPrefix = "crate",
                },
                cargo = {
                  allFeatures = true,
                },
                checkOnSave = {
                  command = "clippy",
                },
                inlayHints = { locationLinks = false },
                diagnostics = {
                  enable = true,
                  experimental = {
                    enable = true,
                  },
                },
              },
            },
          },
          tailwindcss = {
            filetypes = { "svelte", "html" },
          },
          cssls = {
            filetypes = { "css" },
          },
        },
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,
    ---@param opts ExtPluginLspOpts
    config = function(_, opts)
      -- setup autoformat
      LazyVim.format.register(LazyVim.lsp.formatter())

      -- setup keymaps
      LazyVim.lsp.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      LazyVim.lsp.setup()
      LazyVim.lsp.on_dynamic_capability(require("lazyvim.plugins.lsp.keymaps").on_attach)

      -- diagnostics signs
      if vim.fn.has("nvim-0.10.0") == 0 then
        if type(opts.diagnostics.signs) ~= "boolean" then
          for severity, icon in pairs(opts.diagnostics.signs.text) do
            local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
          end
        end
      end

      if vim.fn.has("nvim-0.10") == 1 then
        -- inlay hints
        if opts.inlay_hints.enabled then
          LazyVim.lsp.on_supports_method("textDocument/inlayHint", function(client, buffer)
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ""
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end)
        end

        -- code lens
        if opts.codelens.enabled and vim.lsp.codelens then
          LazyVim.lsp.on_supports_method("textDocument/codeLens", function(client, buffer)
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end)
        end
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = LazyVim.config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = opts.ensure_installed or {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
              -- else
              --   ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = vim.tbl_deep_extend(
            "force",
            ensure_installed,
            LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
          ),
          handlers = { setup },
        })
      end

      if LazyVim.lsp.is_enabled("denols") and LazyVim.lsp.is_enabled("vtsls") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        LazyVim.lsp.disable("vtsls", is_deno)
        LazyVim.lsp.disable("denols", function(root_dir, config)
          if not is_deno(root_dir) then
            config.settings.deno.enable = false
          end
          return false
        end)
      end
    end,
  },
}
