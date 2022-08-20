-- require('telescope').load_extension('fzf')
require('telescope').load_extension('zoxide')

local z_utils = require("telescope._extensions.zoxide.utils")

require("telescope._extensions.zoxide.config").setup({
  prompt_title = "[ Walking on the shoulders of TJ ]",
  list_command = "zoxide query -l",
  mappings = {
    default = {
      after_action = function(selection)
        print("Directory changed to \"" .. selection.path .. "\"")
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

