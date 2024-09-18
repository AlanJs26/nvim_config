-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = LazyVim.safe_keymap_set
local unmap = function(...)
  pcall(vim.keymap.del, ...)
end

map("n", "u", "<cmd>silent undo<cr>", { desc = "which_key_ignore", remap = true })
map("n", "<C-R>", "<cmd>silent redo<cr>", { desc = "which_key_ignore", remap = true })

map("n", "<leader>lL", "<cmd>Lazy<cr>", { desc = "Lazy" })

unmap("n", "<leader>K")
--
-- Clear search with <esc>
unmap("i", "<esc>")
map({ "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- return to normal mode
map("i", "jj", "<ESC>", { desc = "Normal Mode", remap = true })

-- add lines up and down
map("n", "<M-o>", "moo<ESC>`o", { desc = "Add line down", remap = true })
map("n", "<M-O>", "moO<ESC>`o", { desc = "Add line up", remap = true })

-- replace
map("n", "çr", ":%s//", { desc = "Quick Replace", remap = true })
map("x", "çr", ":s//", { desc = "Quick Replace", remap = true })

map("n", "<S-ScrollWheelDown>", "2zl", { desc = "Scroll right", remap = true })
map("n", "<S-ScrollWheelUp>", "2zh", { desc = "Scroll left", remap = true })

-- buffer
map("n", "<leader>d", LazyVim.ui.bufremove, { desc = "Delete Buffer" })
unmap("n", "<leader>`")
map("n", "<leader>0", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- windows
unmap({ "n" }, "<leader>wd")
unmap({ "n" }, "<leader>-")
unmap({ "n" }, "<leader>wm")

map("n", "<leader>e", "<c-w>", { desc = "Windows", remap = true })
map("n", "vs", "<C-w>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>ed", "<C-W>c", { desc = "Delete Window", remap = true })
LazyVim.toggle.map("<leader>em", LazyVim.toggle.maximize)

map("n", "<M-w>", "<C-w>c", { desc = "Delete window", remap = true })

unmap("n", "<leader>|")
map("n", "ZZ", "<Nop>")
map("n", "-", "Q", { desc = "run last macro", remap = true })

-- save file
map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save File", remap = true })

-- movement
unmap({ "i" }, "<M-j>")
unmap({ "i" }, "<M-k>")
map("i", "<M-k>", "<up>", { desc = "Cursor up", remap = true })
map("i", "<M-j>", "<down>", { desc = "Cursor down", remap = true })
map("i", "<M-h>", "<left>", { desc = "Cursor left", remap = true })
map("i", "<M-l>", "<right>", { desc = "Cursor right", remap = true })

map({ "n", "o" }, "gm", "<Plug>(MatchitNormalForward)")
map({ "x", "v" }, "gm", "<Plug>(MatchitVisualForward)")

map({ "n", "x", "o", "v" }, "gl", "g_", { desc = "Go to end of line", remap = true })

-- surround
unmap("x", "S")
map({ "x", "v" }, "S", [[:<C-u>lua require('mini.surround').add('visual')<CR>]], { silent = true })

-- lazy
unmap("n", "<leader>l")
unmap("n", "<leader>L")

-- diagnostic
unmap("n", "<leader>cd")
map("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- formatting
unmap({ "n", "v" }, "<leader>cf")
unmap({ "v" }, "<leader>cF")
map({ "n", "v" }, "<leader>lf", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- comment
map("n", "<leader>c", "<cmd>norm gcc<cr>", { desc = "Toggle Comment line", remap = true })
map("v", "<leader>c", "<cmd>norm gc<cr>", { desc = "Toggle Comment line", remap = true })

-- tabs
map("n", "<M-l>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<M-h>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
