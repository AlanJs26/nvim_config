return {
    'numToStr/Comment.nvim',
    event = 'BufRead',
    config = function()

    require('Comment').setup({
        ---Add a space b/w comment and the line
        padding = true,

        ---Whether the cursor should stay at its position
        sticky = true,

        ---Lines to be ignored while comment/uncomment.
        ---Could be a regex string or a function that returns a regex string.
        ---Example: Use '^$' to ignore empty lines
        ignore = nil,

        ---LHS of toggle mappings in NORMAL + VISUAL mode
        toggler = {
            ---Line-comment toggle keymap
            line = '<space>c',
        },
        ---LHS of operator-pending mappings in NORMAL + VISUAL mode
        opleader = {
            ---Line-comment keymap
            line = nil,
            ---Block-comment keymap
            block = nil,
        },

        ---LHS of extra mappings
        extra = {
            ---Add comment on the line above
            above = nil,
            ---Add comment on the line below
            below = nil,
            ---Add comment at the end of line
            eol = nil,
        },

        ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
        mappings = {
            ---Operator-pending mapping
            ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
            basic = true,
            ---Extra mapping
            ---Includes `gco`, `gcO`, `gcA`
            extra = false,
            ---Extended mapping
            ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
            extended = false,
        },
        ---Pre-hook, called before commenting the line
        pre_hook = nil,
        post_hook = nil,
    })

    -- vim.api.nvim_set_keymap('x', '<space>c', '<Plug>(comment_toggle_blockwise_visual)', {})
    vim.api.nvim_set_keymap('x', '<space>c', '<Plug>(comment_toggle_linewise_visual)', {})

    local ft = require('Comment.ft')

    ft.set('c', '/*%s*/')
    ft.set('movy', '# %s')
    ft.set('vhdl', '-- %s')

end }
