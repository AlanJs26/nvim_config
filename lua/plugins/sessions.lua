return {
  {
    'rmagatti/auto-session',
    config = function()

      require('user.setup_tasks')
      require('auto-session').setup({
          -- auto_session_root_dir = "C:/Users/alanj/AppData/Local/nvim/session",
          auto_session_suppress_dirs = {'~/', 'G:/Users/Alan/Documents/_Codes', '~/Documents/_Codes'},
          auto_session_enabled = true,
          auto_session_create_enabled = false,

          session_lens = {
            find_command = { "rg", "--files", "--color", "never", "--sortr", "modified" }
          }

        })

    end 
  },
  -- 'airblade/vim-rooter',

  {
    "chrisgrieser/nvim-early-retirement",
    config = {
      minimumBufferNum = 6,
      notificationOnAutoClose = true
    },
    event = "VeryLazy",
  },

  -- {
  --   "ahmedkhalf/project.nvim",
  --   dependencies = {'nvim-telescope/telescope.nvim'},
  --   config = function()
  --     require("project_nvim").setup {
  --       detection_methods = {"pattern", "lsp"},
  --       patterns = {'=nvim', '.git', 'package.json', 'Makefile', '!/home/alan', '!~'},
  --       exclude_dirs = {'~', '/mnt/DiscoExterno/Users/Alan/Documents/_Codes', '~/Documents/_Codes', '/home/', '/home/alan/'},
  --     }
  --
  --     require('telescope').load_extension('projects')
  --   end
  -- }

  {
    'notjedi/nvim-rooter.lua',
    config = function()
      require('nvim-rooter').setup({
          rooter_patterns = {'=nvim', '.git', 'package.json', 'Makefile', '!/home/alan', '!~', 'Cargo.toml', 'vhdl_ls.toml', 'pyproject.toml'},
          exclude_filetypes = {
            'fugitive',
            'toggleterm',
            'alpha',
            'Mundo',
            'undotree',
            'lazy',
            'diff'
          }

        })
    end
  },


}
