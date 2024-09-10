return {
  { "theRealCarneiro/hyprland-vim-syntax", ft = "hypr" },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "storm" },
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
      { "<leader>N", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
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
    "nvim-telescope/telescope.nvim",
    opts = {
      pickers = {
        buffers = {
          mappings = {
            i = { ["<CR>"] = require("telescope.actions").select_drop },
          },
        },
      },
    },
    keys = {
      {
        "<leader>,",
        "<cmd>Telescope buffers sort_mru=true sort_lastused=true ignore_current_buffer=true<cr>",
        desc = "Switch Buffer",
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
        dashboard.button("f", " " .. " Find file",       LazyVim.pick()),
        dashboard.button("n", " " .. " New file",        [[<cmd> ene <BAR> startinsert <cr>]]),
        dashboard.button("r", " " .. " Recent files",    LazyVim.pick("oldfiles")),
        -- dashboard.button("g", " " .. " Find text",       LazyVim.pick("live_grep")),
        dashboard.button("c", " " .. " Config",          LazyVim.pick.config_files()),
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
      return dashboard
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  -- {
  --   "nvimdev/dashboard-nvim",
  --   opts = function()
  --     local logo = {
  --       [[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
  --       [[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
  --       [[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
  --       [[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
  --       [[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
  --       [[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
  --       [[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
  --       [[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
  --       [[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
  --       [[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
  --       [[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
  --     }
  --     local function list_filled(value, size)
  --       local list = {}
  --       for i = 1, size do
  --         list[i] = value
  --       end
  --       return list
  --     end
  --
  --     logo = vim.list_extend(list_filled("", 3), logo)
  --     logo = vim.list_extend(logo, list_filled("", 2))
  --
  --     local opts = {
  --       theme = "doom",
  --       hide = {
  --         -- this is taken care of by lualine
  --         -- enabling this messes up the actual laststatus setting after loading a file
  --         statusline = false,
  --       },
  --       config = {
  --         -- header = vim.split(logo, "\n"),
  --         header = logo,
  --       -- stylua: ignore
  --       center = {
  --         { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
  --         { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
  --         { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
  --         -- { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
  --         { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
  --         { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
  --         -- { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
  --         { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
  --         { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
  --       },
  --         footer = function()
  --           local stats = require("lazy").stats()
  --           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --           return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
  --         end,
  --       },
  --     }
  --
  --     for _, button in ipairs(opts.config.center) do
  --       button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  --       button.key_format = "  %s"
  --     end
  --
  --     -- open dashboard after closing lazy
  --     if vim.o.filetype == "lazy" then
  --       vim.api.nvim_create_autocmd("WinClosed", {
  --         pattern = tostring(vim.api.nvim_get_current_win()),
  --         once = true,
  --         callback = function()
  --           vim.schedule(function()
  --             vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
  --           end)
  --         end,
  --       })
  --     end
  --
  --     return opts
  --   end,
  -- },
}
