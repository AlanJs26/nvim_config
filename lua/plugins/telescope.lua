return {
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      local telescope = require('telescope')

      telescope.setup {
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<M-d>'] = require('telescope.actions').delete_buffer,
              }
            }
          }
        }
      }
    end
  },
  {
    'jvgrootveld/telescope-zoxide',
    dependencies = {'nvim-telescope/telescope.nvim'},
    config = function()

      -- require('telescope').load_extension('fzf')
      require('telescope').load_extension('zoxide')

      local z_utils = require("telescope._extensions.zoxide.utils")

      require("telescope._extensions.zoxide.config").setup({
          prompt_title = "[ Walking on the shoulders of TJ ]",
          list_command = "zoxide query -l",
          mappings = {
            default = {
              after_action = function(selection)
                -- print("Directory changed to \"" .. selection.path .. "\"")
                vim.cmd("NvimTreeOpen")
              end
            },
            ["<C-s>"] = {
              before_action = function(selection) print("before C-s") end,
              action = function(selection)
                vim.cmd("edit " .. selection.path)
              end
            },
            ["<C-q>"] = { action = z_utils.create_basic_command("split") },
          }
        })

      vim.cmd([[
        autocmd DirChanged * silent exec '!zoxide add "'..expand('%:p:h')..'"'
          ]])
    end,
  },

}
