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
  q = { ':lua confirmPopup("Do you really want to leave?", "wqa", nil)<cr>', 'quit save all'},
}, {prefix = "<leader>", nowait=true, mode= 'n'})

vim.g.neovide_scroll_animation_length = 0.1
vim.g.neovide_transparency = 0.9

