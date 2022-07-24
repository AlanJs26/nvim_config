vim.highlight.create('StartLogo1',  {guifg = "#4b4397" },false)
vim.highlight.create('StartLogo2',  {guifg = "#474798" },false)
vim.highlight.create('StartLogo3',  {guifg = "#444a99" },false)
vim.highlight.create('StartLogo4',  {guifg = "#414e99" },false)
vim.highlight.create('StartLogo5',  {guifg = "#3f5199" },false)
vim.highlight.create('StartLogo6',  {guifg = "#3d5499" },false)
vim.highlight.create('StartLogo7',  {guifg = "#3b5799" },false)
vim.highlight.create('StartLogo8',  {guifg = "#3a5a99" },false)
vim.highlight.create('StartLogo9',  {guifg = "#3a5d98" },false)
vim.highlight.create('StartLogo10', {guifg = "#3b5f97" },false)
vim.highlight.create('StartLogo11', {guifg = "#3c6296" },false)

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local fortune = require("alpha.fortune")

-- Inspired by https://github.com/glepnir/dashboard-nvim with my own flair
local header = {
  [[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
  [[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
  [[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
  [[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
  [[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
  [[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
  [[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
  [[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
  [[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
  [[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
  [[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
}

-- Make the header a bit more fun with some color!
local function colorize_header()
  local lines = {}

  for i, chars in pairs(header) do
    local line = {
      type = "text",
      val = chars,
      opts = {
        hl = "StartLogo" .. i,
        shrink_margin = false,
        position = "center",
      },
    }

    table.insert(lines, line)
  end

  return lines
end

function _G.OpenConfig()
  local sessionsfolder = vim.fn.stdpath('data')..'/sessions/'
  local configfile = vim.fn.system('ls -d '..sessionsfolder:gsub('\\','/')..'*|rg nvim\\.vim|head -n1'):gsub('\\', '/'):gsub('%%', '\\%%')

  if configfile == '' then
    vim.api.nvim_command('e '..vim.fn.stdpath('config')..'/init.lua')
  else
    vim.api.nvim_command('source '..configfile)
  end
end

dashboard.section.buttons.val = {
  dashboard.button("e", "  New file", ":ene | startinsert <CR>"),
  dashboard.button("s", "  Recent sessions", ":silent! Telescope session-lens search_session<CR>"),
  dashboard.button("f", "  Recent files", ":Telescope oldfiles<CR>"),
  dashboard.button("r", "  Recent folders", ":Telescope zoxide list<CR>"),
  dashboard.button("c", "  Config", ":lua OpenConfig()<CR>"),
  dashboard.button("q", "ﰌ  Quit", ":qa<CR>"),
}

-- Everyone could use a good fortune cookie from time to time, right?
dashboard.section.footer.val = fortune()
dashboard.section.footer.opts.hl = "NonText"

-- Hide all the unnecessary visual elements while on the dashboard, and add
-- them back when leaving the dashboard.
local group = vim.api.nvim_create_augroup("CleanDashboard", {})

vim.api.nvim_create_autocmd("User", {
  group = group,
  pattern = "AlphaReady",
  callback = function()
    vim.cmd([[
      let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
      if !empty(buffers)
          exe 'bd '.join(buffers, ' ')
      endif
    ]])

    vim.opt.showcmd = false
    vim.opt.showmode = false
    vim.opt.showtabline = 0
    vim.opt.ruler = false
    vim.g.auto_session_enabled = false
    vim.api.nvim_command('echon ""')
  end,
})

vim.api.nvim_create_autocmd("BufUnload", {
  group = group,
  pattern = "<buffer>",
  callback = function()
    local unalowedft = {'', 'alpha', 'TelescopePrompt', 'NvimTree'}
    for _, value in ipairs(unalowedft) do
      if vim.o.filetype == value then
        return
      end
    end
    vim.opt.showtabline = 2
    vim.opt.showmode = true
    vim.opt.laststatus = 2
    vim.opt.showcmd = true
    vim.opt.ruler = true
    vim.g.auto_session_enabled = true
  end,
})

alpha.setup({
  layout = {
    { type = "padding", val = 2 },
    { type = "group", val = colorize_header() },
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    dashboard.section.footer,
  },
  opts = { margin = 5 },
})

local newgroup = vim.api.nvim_create_augroup("newgroup", {})
vim.api.nvim_create_autocmd("VimEnter", {
  group = newgroup,
  pattern = "<buffer>",
  callback = function()
    if vim.o.filetype == '' then
      vim.api.nvim_command(':Alpha')
    end
  end,
})

