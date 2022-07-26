vim.api.nvim_set_hl(0, 'StartLogo1',  {fg = "#4b4397" })
vim.api.nvim_set_hl(0, 'StartLogo2',  {fg = "#474798" })
vim.api.nvim_set_hl(0, 'StartLogo3',  {fg = "#444a99" })
vim.api.nvim_set_hl(0, 'StartLogo4',  {fg = "#414e99" })
vim.api.nvim_set_hl(0, 'StartLogo5',  {fg = "#3f5199" })
vim.api.nvim_set_hl(0, 'StartLogo6',  {fg = "#3d5499" })
vim.api.nvim_set_hl(0, 'StartLogo7',  {fg = "#3b5799" })
vim.api.nvim_set_hl(0, 'StartLogo8',  {fg = "#3a5a99" })
vim.api.nvim_set_hl(0, 'StartLogo9',  {fg = "#3a5d98" })
vim.api.nvim_set_hl(0, 'StartLogo10', {fg = "#3b5f97" })
vim.api.nvim_set_hl(0, 'StartLogo11', {fg = "#3c6296" })

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

  if string.match(configfile, '%*') then
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
  dashboard.button("q", "  Quit", ":qa<CR>"),
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

