local options = {
  clipboard   = 'unnamedplus',
  autochdir   = true,
  -- shell       = 'C:/cygwin64/bin/bash.exe',
  mouse       = "a",
  cursorline  = true,
  spell       = false,
  foldmethod  = "syntax",
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
  cmdheight   = 1,
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

if vim.fn.has('win32') == 2 then
  vim.g.tokyonight_style = 'storm' -- available: night, storm
else
  vim.g.tokyonight_style = 'night' -- available: night, storm
end

vim.g.tokyonight_enable_italic = 1


vim.cmd([[
  colorscheme tokyonight

  syntax enable
  set cpoptions+=y
  set cinkeys-=:

  autocmd BufRead * set scroll=7
  autocmd FileType python set tabstop=4
  autocmd FileType python set shiftwidth=4

  if has('win32')
    let g:python3_host_prog = expand('~')..'/miniconda3/python.exe'
  endif

  autocmd BufEnter,BufNew *.ino :ArduinoChoosePort /dev/ttyUSB0
  autocmd BufEnter,BufNew *.ino :ArduinoSetBaud 115200
  autocmd BufEnter,BufNew *.md :setlocal spell
  autocmd FileType markdown,text set spelllang=pt_br,en_us

  " fix last spell error
  autocmd FileType markdown,text inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
  autocmd User Startified set spelllang=pt_br,en_us | inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

  " --------- Custom highlights

  " highlight on yank
  augroup highlight_yank
      autocmd!
      au TextYankPost * silent! lua vim.highlight.on_yank{higroup="Constant", timeout=700}
  augroup END

  " Makes the Conceal color more visible
  autocmd BufEnter * highlight Conceal ctermfg=14 ctermbg=242 guifg=#525975 guibg=#24283b

  if g:tokyonight_style == 'storm'
    highlight CursorLine   cterm=NONE guibg=#2C2F45 guifg=NONE
  else
    highlight CursorLine   cterm=NONE guibg=#232434 guifg=NONE
  endif

  highlight CmpItemKind guifg=#7aa2f7 
  highlight CmpItemAbbrMatch guifg=#7aa2f7 
  highlight CmpItemAbbrMatchFuzzy guifg=#4c68a6 
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



