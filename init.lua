local function resolve(path)
  return path:gsub('\\', '/'):gsub('/$', '')
end
local vimscriptpath = resolve(vim.fn.stdpath("config").."/vimscript")

require('plugins')
require('settings')
vim.cmd("source ".. vimscriptpath .."/mappings.vim")
vim.cmd("source ".. vimscriptpath .."/misc.vim")
vim.cmd("source ".. vimscriptpath .."/bufdelete.vim")
require('user_libs.utils')
require('user_libs.floatwin')
require('user.setup_tasks')
require('user.language_specific')



