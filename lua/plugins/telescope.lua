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
        defaults = {
          file_ignore_patterns = {'node_modules', 'Doxygen', 'lazy-lock.json'}
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
    'LukasPietzschmann/telescope-tabs',
    config = function()
      require('telescope').load_extension 'telescope-tabs'
      require('telescope-tabs').setup({
        entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
          local entry_string = table.concat(vim.tbl_map(function(v)
            return vim.fn.fnamemodify(v, ":h:t") .. '/' .. vim.fn.fnamemodify(v, ":t")
          end, file_paths), ', ')
          return string.format('%d: %s%s', tab_id, entry_string, is_current and ' <' or '')
        end,
        entry_ordinal = function(tab_id, buffer_ids, file_names, file_paths, is_current)
          local entry_string = table.concat(vim.tbl_map(function(v)
            return vim.fn.fnamemodify(v, ":.")
          end, file_paths), ', ')
          return string.format('%d: %s%s', tab_id, entry_string, is_current and ' <' or '')
        end
      })


    end,
    dependencies = { 'nvim-telescope/telescope.nvim' },
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
