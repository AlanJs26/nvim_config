
vim.cmd([[
highlight link FocusedSymbol DiagnosticVirtualTextInfo
highlight link SymbolsOutlineConnector NonText
]])

vim.g.symbols_outline = {
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = false,
    position = 'right',
    relative_width = true,
    width = 30,
    auto_close = false,
    show_numbers = false,
    show_relative_numbers = false,
    show_symbol_details = false,
    preview_bg_highlight = 'Pmenu',
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = {"<Esc>", "q"},
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
}
