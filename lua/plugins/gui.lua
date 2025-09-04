return {
  {
    "nvim-zh/colorful-winsep.nvim",
    config = {
      highlight = "#7aa2f7",
      animate = { enabled = false },
    },
    event = { "WinLeave" },
  },
  {
    "ibhagwan/fzf-lua",
    opts = {
      winopts = {
        width = 0.9,
        height = 0.95,
        -- row = 0.1,
        -- col = 0.05,
        on_create = function()
          vim.keymap.set("t", "<C-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true, buffer = true })
        end,
      },
      defaults = {
        formatter = { "path.filename_first", 1 },
      },
      grep = {
        path_shorten = true,
      },
      git = {
        diff = {
          preview = "git diff --color {ref} -- $(echo {file}|sed -E 's/(\\w+) (.+)/\\2\\/\\1/')",
          -- preview = "echo {file}",
        },
      },
    },
    keys = {
      { "<leader>sC", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      { "<leader>sc", "<cmd>FzfLua changes<cr>", desc = "Changes" },
    },
  },
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      -- One handed keymap recommended, you will be using the mouse
      {
        "<leader>lp",
        function()
          require("oklch-color-picker").pick_under_cursor()
        end,
        desc = "Color pick under cursor",
      },
    },
    opts = {
      patterns = {
        hyprland_color = {
          -- rgba(33ccff)
          format = "hex_literal",
          priority = -2,
          "rgba%(()%x%x%x%x%x%x()%x-%f[%W]%)",
          custom_parse = function(match)
            local hex = tonumber("0x" .. match, 16)
            return hex
          end,
        },
        hex_literal = { priority = -1, "()0x%x%x%x%x%x%x+%f[%W]()" },

        -- Rgb and Hsl support modern and legacy formats:
        -- rgb(10 10 10 / 50%) and rgba(10, 10, 10, 0.5)
        css_rgb = { priority = 0, "()rgba?%(.-%)()" },
        css_hsl = { priority = 0, "()hsla?%(.-%)()" },
        css_oklch = { priority = 0, "()oklch%([^,]-%)()" },

        -- Allows any digits, dots, commas, or whitespace within brackets.
        numbers_in_brackets = false,
      },
    },
  },
  { "theRealCarneiro/hyprland-vim-syntax", ft = "hypr" },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },

  {
    "folke/noice.nvim",
    opts = {
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      cmdline = {
        view = "cmdline",
      },
    },
  },
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      toggle = { map = LazyVim.safe_keymap_set },
      words = { enabled = true },
      scratch = {
        ft = function()
          if require("config.toggle.scratch_ft"):get() and vim.bo.buftype == "" and vim.bo.filetype ~= "" then
            return vim.bo.filetype
          end
          return "markdown"
        end,
      },
    },
    -- stylua: ignore
    keys = {
      { "<leader>>",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>.", require('fzf-lua').git_diff, desc = "Find Files (git-diff)" },
      { "<leader>n", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      { "<leader>N", function() Snacks.notifier.show_history() end, desc = "Notification History" },
      {
        "<leader>un",
        function() Snacks.notifier.hide() end,
        desc = "Dismiss All Notifications",
      },
    },
  },
  {
    "Apeiros-46B/qalc.nvim",
    config = {
      cmd_args = {
        "--set",
        "decimal comma 0",
      },
    },
    keys = {
      { "<leader>lQ", "<cmd>Qalc<cr>", desc = "Calculator Buffer", remap = true },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          {
            "<leader>e",
            group = "windows",
            proxy = "<c-w>",
            expand = function()
              return require("which-key.extras").expand.win()
            end,
          },
          {
            "<leader>>",
            desc = "Toggle Scratch Buffer",
          },
          {
            "<leader>.",
            desc = "Find Files (git-diff)",
            icon = { icon = "󱡠", color = "azure" },
          },
          {
            "<leader>w",
            desc = "Save File",
          },
          {
            "<leader>c",
            mode = { "n", "x" },
            desc = "Toggle Comment Line",
          },
          {
            "<leader>l",
            mode = { "n", "x" },
            desc = "code",
          },
          {
            "<leader>o",
            mode = { "n" },
            group = "overseer",
            icon = "󰙵",
          },
          { "<leader>wm", mode = { "n" }, hidden = true, desc = "which_key_ignore" },
        },
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", false, desc = false },
      { "<leader>E", false, desc = false },

      { "<leader>n", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      -- { "<leader>N", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["<C-.>"] = {
            function(state)
              -- disable root detection
              vim.g.root_spec = { "cwd" }

              local utils = require("neo-tree.utils")
              local manager = require("neo-tree.sources.manager")
              local buffers = require("neo-tree.sources.buffers")

              local refresh = utils.wrap(manager.refresh, "buffers")

              local node = state.tree:get_node()

              while node and node.type ~= "directory" do
                local parent_id = node:get_parent_id()
                node = parent_id and state.tree:get_node(parent_id) or nil
              end

              if not node then
                return
              end

              buffers.navigate(state, node:get_id())

              refresh(state)

              local path = node:get_id()
              vim.cmd("cd " .. path)
            end,
            desc = "Set current working directory",
          },
        },
      },
    },
  },

  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")

      vim.api.nvim_set_hl(0, "DashboardLogo1", { fg = "#4b4397" })
      vim.api.nvim_set_hl(0, "DashboardLogo2", { fg = "#474798" })
      vim.api.nvim_set_hl(0, "DashboardLogo3", { fg = "#444a99" })
      vim.api.nvim_set_hl(0, "DashboardLogo4", { fg = "#414e99" })
      vim.api.nvim_set_hl(0, "DashboardLogo5", { fg = "#3f5199" })
      vim.api.nvim_set_hl(0, "DashboardLogo6", { fg = "#3d5499" })
      vim.api.nvim_set_hl(0, "DashboardLogo7", { fg = "#3b5799" })
      vim.api.nvim_set_hl(0, "DashboardLogo8", { fg = "#3a5a99" })
      vim.api.nvim_set_hl(0, "DashboardLogo9", { fg = "#3a5d98" })
      vim.api.nvim_set_hl(0, "DashboardLogo10", { fg = "#3b5f97" })
      vim.api.nvim_set_hl(0, "DashboardLogo11", { fg = "#3c6296" })

      local header = {
        [[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
        [[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
        [[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
        [[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
        [[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
        [[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
        [[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
        [[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
        [[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
        [[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
        [[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
      }

      local function padding(amount)
        return {
          type = "padding",
          val = amount,
        }
      end

      -- Make the header a bit more fun with some color!
      local function colorized_header()
        local lines = {}

        for i, chars in pairs(header) do
          local line = {
            type = "text",
            val = chars,
            opts = {
              hl = "DashboardLogo" .. i,
              shrink_margin = false,
              position = "center",
            },
          }

          table.insert(lines, line)
        end

        return lines
      end

      dashboard.section.header.type = "group"
      dashboard.section.header.val = colorized_header()

      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file",       '<cmd> lua LazyVim.pick()() <cr>'),
        dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("r", " " .. " Recent files",    '<cmd> lua LazyVim.pick("oldfiles")() <cr>'),
        -- dashboard.button("g", " " .. " Find text",       '[[<cmd> lua LazyVim.pick("live_grep")() <cr>]]'),
        dashboard.button("c", " " .. " Config",          '<cmd> lua LazyVim.pick.config_files()() <cr>'),
        dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        -- dashboard.button("x", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
        dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 4
      if vim.fn.filereadable(require("persistence").current({ branch = true })) == 1 then
        table.insert(dashboard.section.buttons.val, {
          type = "text",
          val = " Session Found!",
          opts = {
            hl = "AlphaFooter",
            shrink_margin = false,
            position = "center",
          },
        })
      end
      return dashboard
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },

          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            Snacks.profiler.status(),
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree", "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },
}
