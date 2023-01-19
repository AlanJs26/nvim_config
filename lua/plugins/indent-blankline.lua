  return { 'lukas-reineke/indent-blankline.nvim', event = 'BufRead', config = function()
local present, indent_blankline = pcall(require, "indent_blankline")
if not present then
	return
end
vim.api.nvim_set_hl(0, 'IndentBlanklineChar',  {fg = "#26273b"})

indent_blankline.setup {
	filetype_exclude = {
		"help",
		"terminal",
		"alpha",
		"packer",
		"lspinfo",
		"NvimTree",
		"TelescopePrompt",
		"TelescopeResults",
		"startup-log.txt",
    "Mundo"
	},
	space_char_clankline = " ",
  show_current_context = true,
  show_current_context_start = false,
}

  end }
