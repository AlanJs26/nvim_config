local options = {
  clipboard   = 'unnamedplus',
  autochdir   = false,
  -- shell       = 'C:/cygwin64/bin/bash.exe',
  mouse       = "a",
  mousemodel  = "extend",
  mousemoveevent = true,
  cursorline  = true,
  spell       = false,
  foldmethod  = "manual",
  foldlevel   = 99,
  scrolloff   = 7,
  shiftwidth  = 2,
  tabstop     = 2,
  expandtab   = true,
  smartcase   = true,
  ignorecase  = true,
  timeoutlen  = 300,
  updatetime  = 250,
  encoding    = "UTF-8",
  undodir     = vim.fn.stdpath("data").."/undo",
  undofile    = true,
  report      = 30,
  lazyredraw  = true,
  gdefault    = true,
  cmdheight   = 0,
  hidden      = true,
  showmode    = false,
  splitright  = true,
  splitbelow  = true,
  number      = true,
  swapfile    = false,
  wrap        = false,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.g.maplocalleader = "ç"

vim.cmd([[
  syntax enable
  set cpoptions+=y
  set cinkeys-=:

  autocmd VimResized * wincmd =

  autocmd BufRead * set scroll=7
  autocmd FileType python set tabstop=4
  autocmd FileType python set shiftwidth=4

  autocmd BufNewFile,BufRead,BufReadPost *.movy set filetype=movy

  if has('win32')
    let g:python3_host_prog = expand('~')..'/miniconda3/python.exe'
  endif

]])


--[[ local function tohex(num)
    local charset = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"}
    local tmp = {}
    repeat
        table.insert(tmp,1,charset[num%16+1])
        num = math.floor(num/16)
    until num==0
    return table.concat(tmp)
end

local color_utils = require('color-picker/utils')

local custom_hi = {
  CmpItemKindField         = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindProperty      = { fg = "#EED8DA", bg = "#B5585F" },
  CmpItemKindEvent         = { fg = "#EED8DA", bg = "#B5585F" },

  CmpItemKindText          = { fg = "#C3E88D", bg = "#9FBD73" },
  CmpItemKindEnum          = { fg = "#C3E88D", bg = "#9FBD73" },
  CmpItemKindKeyword       = { fg = "#C3E88D", bg = "#9FBD73" },

  CmpItemKindConstant      = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindConstructor   = { fg = "#FFE082", bg = "#D4BB6C" },
  CmpItemKindReference     = { fg = "#FFE082", bg = "#D4BB6C" },

  CmpItemKindFunction      = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindStruct        = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindClass         = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindModule        = { fg = "#EADFF0", bg = "#A377BF" },
  CmpItemKindOperator      = { fg = "#EADFF0", bg = "#A377BF" },

  CmpItemKindVariable      = { fg = "#C5CDD9", bg = "#7E8294" },
  CmpItemKindFile          = { fg = "#C5CDD9", bg = "#7E8294" },

  CmpItemKindUnit          = { fg = "#F5EBD9", bg = "#D4A959" },
  CmpItemKindSnippet       = { fg = "#F5EBD9", bg = "#D4A959" },
  CmpItemKindFolder        = { fg = "#F5EBD9", bg = "#D4A959" },

  CmpItemKindMethod        = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindValue         = { fg = "#DDE5F5", bg = "#6C8ED4" },
  CmpItemKindEnumMember    = { fg = "#DDE5F5", bg = "#6C8ED4" },

  CmpItemKindInterface     = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindColor         = { fg = "#D8EEEB", bg = "#58B5A8" },
  CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
}

local function clamp(val, max)
  if val > max then
    return max
  end
  return val
end

for key, value in pairs(custom_hi) do
  pcall(function ()
    local fg_decimal = vim.api.nvim_get_hl_by_name(key, 0).foreground

    local bg_rgb = color_utils.HexToRGB(tohex(fg_decimal))
    local bg_hsl = color_utils.RGBToHSL(unpack(bg_rgb))
    bg_hsl[1] = clamp(bg_hsl[1]+10, 360)
    bg_hsl[2] = clamp(bg_hsl[3]-30, 100)
    bg_hsl[3] = clamp(bg_hsl[3]+15, 100)

    local fg_hex = color_utils.hslToHex(unpack(bg_hsl))


    local opts = value
    opts.bg = fg_decimal
    opts.fg = fg_hex

    vim.api.nvim_set_hl(0, key,  opts)
  end)
end ]]



