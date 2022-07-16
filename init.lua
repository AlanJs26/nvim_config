local vimscriptpath = vim.fn.stdpath("config").."\\vimscript\\"

require('settings')
require('plugins')
vim.cmd("source ".. vimscriptpath .."mappings.vim")
vim.cmd("source ".. vimscriptpath .."misc.vim")
vim.cmd("source ".. vimscriptpath .."bufdelete.vim")
require('utils')
require('floatwin')

