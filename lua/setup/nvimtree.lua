
vim.o.showtabline = 2

require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  respect_buf_cwd = true,
  actions = {
    open_file = {
      quit_on_open = false
    }
  },
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = true,
  hijack_directories   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    --auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

vim.cmd([[
highlight NvimTreeExecFile guifg=#93ce6a
]])



