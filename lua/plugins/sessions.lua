return {
  {
    'AlanJs26/session-lens',
    config = function()
      require('telescope').load_extension('session-lens')
    end
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup({
          -- auto_session_root_dir = "C:/Users/alanj/AppData/Local/nvim/session",
          auto_session_suppress_dirs = {'~/', 'G:/Users/Alan/Documents/_Codes', '~/Documents/_Codes'},
          auto_session_enabled = true,
          auto_session_create_enabled = false,

        })
    end 
  },
  -- 'airblade/vim-rooter',
  {
    "ahmedkhalf/project.nvim",
    dependencies = {'nvim-telescope/telescope.nvim'},
    config = function()
      require("project_nvim").setup {
        patterns = {'=src', '=nvim', '.git'},
        exclde_dirs = {'~/', 'G:/Users/Alan/Documents/_Codes', '~/Documents/_Codes'},
      }

      require('telescope').load_extension('projects')
    end
  }
}
