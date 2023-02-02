local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local function resolve(path)
  return path:gsub('\\', '/'):gsub('/$', '')
end
local vimscriptpath = resolve(vim.fn.stdpath("config").."/vimscript")

vim.g.mapleader = " "

require('lazy').setup('plugins', {
  change_detection = {
    enabled = false 
  }
})

require('settings')
require('user.highlights')
vim.cmd("source ".. vimscriptpath .."/mappings.vim")
vim.cmd("source ".. vimscriptpath .."/misc.vim")
vim.cmd("source ".. vimscriptpath .."/bufdelete.vim")
require('user_libs.utils')
require('user_libs.floatwin')
require('user.language_specific')
require('user.setup_tasks')
