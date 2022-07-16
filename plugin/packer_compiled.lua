-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\alanj\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\alanj\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\alanj\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\alanj\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\alanj\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { 'require("setup.comment")' },
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  ["alpha-nvim"] = {
    config = { 'require("setup.alpha")' },
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["asyncrun.vim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\asyncrun.vim",
    url = "https://github.com/skywind3000/asyncrun.vim"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\auto-pairs",
    url = "https://github.com/jiangmiao/auto-pairs"
  },
  ["auto-session"] = {
    config = { 'require("setup.auto-session")' },
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\auto-session",
    url = "https://github.com/rmagatti/auto-session"
  },
  ["bufferline.nvim"] = {
    config = { 'require("setup.bufferline")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["clever-f.vim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\clever-f.vim",
    url = "https://github.com/rhysd/clever-f.vim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["emmet-vim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\emmet-vim",
    url = "https://github.com/mattn/emmet-vim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind-nvim",
    url = "https://github.com/eeeXun/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspsaga.nvim",
    url = "https://github.com/tami5/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { 'require("setup.lualine")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-cmp"] = {
    config = { 'require("setup.cmp")' },
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { 'require("setup.lsp")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-send-to-term"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-send-to-term",
    url = "https://github.com/mtikekar/nvim-send-to-term"
  },
  ["nvim-tree.lua"] = {
    config = { 'require("setup.nvimtree")' },
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["session-lens"] = {
    config = { 'require("setup.session-lens")' },
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\session-lens",
    url = "https://github.com/AlanJs26/session-lens"
  },
  ["sideways.vim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\sideways.vim",
    url = "https://github.com/AndrewRadev/sideways.vim"
  },
  ["splitjoin.vim"] = {
    keys = { { "", "gS" } },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\splitjoin.vim",
    url = "https://github.com/AndrewRadev/splitjoin.vim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline", "SymbolsOutlineOpen" },
    config = { 'require("setup.symbols-outline")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-zoxide"] = {
    config = { 'require("setup.zoxide")' },
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope-zoxide",
    url = "https://github.com/jvgrootveld/telescope-zoxide"
  },
  ["telescope.nvim"] = {
    config = { 'require("setup.telescope")' },
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["traces.vim"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\traces.vim",
    url = "https://github.com/markonm/traces.vim"
  },
  ultisnips = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  ["vim-ReplaceWithRegister"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-ReplaceWithRegister",
    url = "https://github.com/inkarkat/vim-ReplaceWithRegister"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-arduino"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-arduino",
    url = "https://github.com/stevearc/vim-arduino"
  },
  ["vim-crunch"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-crunch",
    url = "https://github.com/arecarn/vim-crunch"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-easy-align"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-exchange"] = {
    keys = { { "", "cx" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-exchange",
    url = "https://github.com/tommcdo/vim-exchange"
  },
  ["vim-fugitive"] = {
    commands = { "Git" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-hexokinase"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-hexokinase",
    url = "https://github.com/rrethy/vim-hexokinase"
  },
  ["vim-highlightedyank"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-highlightedyank",
    url = "https://github.com/machakann/vim-highlightedyank"
  },
  ["vim-indent-guides"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-indent-guides",
    url = "https://github.com/nathanaelkane/vim-indent-guides"
  },
  ["vim-ingo-library"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-ingo-library",
    url = "https://github.com/inkarkat/vim-ingo-library"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-markdown",
    url = "https://github.com/plasticboy/vim-markdown"
  },
  ["vim-mundo"] = {
    commands = { "MundoToggle" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-mundo",
    url = "https://github.com/simnalamburt/vim-mundo"
  },
  ["vim-polyglot"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-polyglot",
    url = "https://github.com/sheerun/vim-polyglot"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-rooter",
    url = "https://github.com/airblade/vim-rooter"
  },
  ["vim-selection"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-selection",
    url = "https://github.com/arecarn/vim-selection"
  },
  ["vim-signify"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-signify",
    url = "https://github.com/mhinz/vim-signify"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-sneak",
    url = "https://github.com/justinmk/vim-sneak"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-textobj-entire"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-entire",
    url = "https://github.com/kana/vim-textobj-entire"
  },
  ["vim-textobj-indent"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-indent",
    url = "https://github.com/kana/vim-textobj-indent"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-visual-multi"] = {
    keys = { { "", "çc" }, { "", "<C-n>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["which-key.nvim"] = {
    config = { 'require("setup.which-key")' },
    keys = { { "", "<space>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zen-mode.nvim"] = {
    commands = { "ZenMode" },
    config = { 'require("setup.zen-mode")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "C:\\Users\\alanj\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: telescope-zoxide
time([[Config for telescope-zoxide]], true)
require("setup.zoxide")
time([[Config for telescope-zoxide]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require("setup.nvimtree")
time([[Config for nvim-tree.lua]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
require("setup.alpha")
time([[Config for alpha-nvim]], false)
-- Config for: auto-session
time([[Config for auto-session]], true)
require("setup.auto-session")
time([[Config for auto-session]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require("setup.cmp")
time([[Config for nvim-cmp]], false)
-- Config for: session-lens
time([[Config for session-lens]], true)
require("setup.session-lens")
time([[Config for session-lens]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
require("setup.comment")
time([[Config for Comment.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require("setup.telescope")
time([[Config for telescope.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Git lua require("packer.load")({'vim-fugitive'}, { cmd = "Git", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file ZenMode lua require("packer.load")({'zen-mode.nvim'}, { cmd = "ZenMode", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutlineOpen lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutlineOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file MundoToggle lua require("packer.load")({'vim-mundo'}, { cmd = "MundoToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> cx <cmd>lua require("packer.load")({'vim-exchange'}, { keys = "cx", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> çc <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "çc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gS <cmd>lua require("packer.load")({'splitjoin.vim'}, { keys = "gS", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <space> <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "<lt>space>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-n> <cmd>lua require("packer.load")({'vim-visual-multi'}, { keys = "<lt>C-n>", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType arduino ++once lua require("packer.load")({'vim-arduino'}, { ft = "arduino" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'FixCursorHold.nvim', 'vimtex', 'emmet-vim', 'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'emmet-vim'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType jsxtypescript ++once lua require("packer.load")({'emmet-vim'}, { ft = "jsxtypescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascripttypescript ++once lua require("packer.load")({'emmet-vim'}, { ft = "javascripttypescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'emmet-vim'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'emmet-vim'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType latex ++once lua require("packer.load")({'vimtex'}, { ft = "latex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'vim-signify', 'bufferline.nvim', 'lualine.nvim', 'vim-easy-align', 'vim-crunch'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-lspconfig', 'sideways.vim', 'vim-indent-guides', 'vim-polyglot'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\cls.vim]], true)
vim.cmd [[source C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\cls.vim]]
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\cls.vim]], false)
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\tex.vim]], true)
vim.cmd [[source C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\tex.vim]]
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\tex.vim]], false)
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\tikz.vim]], true)
vim.cmd [[source C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\tikz.vim]]
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vimtex\ftdetect\tikz.vim]], false)
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vim-arduino\ftdetect\arduino.vim]], true)
vim.cmd [[source C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vim-arduino\ftdetect\arduino.vim]]
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vim-arduino\ftdetect\arduino.vim]], false)
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vim-markdown\ftdetect\markdown.vim]], true)
vim.cmd [[source C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vim-markdown\ftdetect\markdown.vim]]
time([[Sourcing ftdetect script at: C:\Users\alanj\AppData\Local\nvim-data\site\pack\packer\opt\vim-markdown\ftdetect\markdown.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
