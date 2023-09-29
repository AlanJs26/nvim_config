return {
  {
    'rmagatti/session-lens',
    config = function()
      require('telescope').load_extension('session-lens')
    end
  },
  {
    'rmagatti/auto-session',
    config = function()

      require('user.setup_tasks')
      require('auto-session').setup({
          -- auto_session_root_dir = "C:/Users/alanj/AppData/Local/nvim/session",
          auto_session_suppress_dirs = {'~/', 'G:/Users/Alan/Documents/_Codes', '~/Documents/_Codes'},
          auto_session_enabled = true,
          auto_session_create_enabled = false,

        })

      local wk = require('which-key')

      wk.register({ 
        s = {
          name='+sessions',
          n= {':lua floatwin("SessionSave {{value}}", "New Session")<cr>',                                       'save session'},
          c= {':exec "silent! SessionSave"|let g:auto_session_enabled = v:false|bufdo bwipeout|Alpha<cr>', 'close session'},
          s= {':Telescope session-lens search_session<cr>',                                                'switch session'},
          f= {':SessionSave<cr>',                                                                          'quick save session'},
          r= {':SessionRestore<cr>',                                                                       'restore previous session'},
          -- p= {':Telescope projects projects<cr>',                                                          'switch project'},
          d= {
            function() 
              confirmPopup("Do you really want to delete the session?", function()
                vim.cmd('silent! SessionDelete')
                require('notify')("Deleted Session")
              end)
            end,
            'delete session',
          }
        },
      }, {
        prefix = "<leader>",
        nowait = true,
        mode='n',
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
          rooter_patterns = {'=nvim', '.git', 'package.json', 'Makefile', '!/home/alan', '!~'},
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
