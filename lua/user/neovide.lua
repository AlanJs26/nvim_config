if not vim.g.neovide then
  return
end


local fontsize = 11

local neovide_set_font_size = function(size)
  -- vim.o.guifont = "FiraCode Nerd Font:h"..size
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h"..size
end

neovide_set_font_size(fontsize)


vim.keymap.set('n', '<C-=>', function()
  fontsize = fontsize + 0.5
  neovide_set_font_size(fontsize)
end)

vim.keymap.set('n', '<C-->', function()
  fontsize = fontsize - 0.5
  neovide_set_font_size(fontsize)
end)


vim.keymap.set({'n','v'}, '<C-S-V>', 'p', {noremap = true, silent = true})
vim.keymap.set({'t','!'}, '<C-S-V>', '<C-R>+', {noremap = true, silent = true})
vim.keymap.set('n', '<C-S-C>', 'y', {noremap = true, silent = true})

require("which-key").register({
    q = {  function()
      confirmPopup('Do you really want to leave?', function()
        local current_buf = vim.api.nvim_get_current_buf()
        local modified_buffers = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if buf ~= current_buf and vim.api.nvim_buf_get_option(buf, 'modified') then
            modified_buffers = modified_buffers+1
          end
        end

        local utils = require('user_libs.utils')

        local terminals = require('toggleterm.terminal').get_all(true)

        if modified_buffers > 0 then
          utils.confirmPopup('There are unsaved buffers. Do you really want to exit?', 'wqa', nil)
        elseif #terminals > 0 then
          utils.confirmPopup('There are '..#terminals..' active terminals. Do you really want to exit?', function()
            for _,term in ipairs(terminals) do
              term:shutdown()
            end
            vim.cmd('wqa')
          end, nil)
      else
        vim.cmd('wqa')
      end
    end, nil)
  end, 'quit save all'},
}, {prefix = "<leader>", nowait=true, mode= 'n'})

vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_transparency = 0.9

