  return { 'numToStr/Comment.nvim', config = function()

require('Comment').setup({
    ---Add a space b/w comment and the line
    ---@type boolean|fun():boolean
    padding = true,

    ---Whether the cursor should stay at its position
    ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
    ---@type boolean
    sticky = true,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|fun():string
    ignore = nil,

    ---LHS of toggle mappings in NORMAL + VISUAL mode
    ---@type table
    toggler = {
        ---Line-comment toggle keymap
        line = '<space>c',
    },

    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    ---@type table
    opleader = {
        ---Line-comment keymap
        line = nil,
        ---Block-comment keymap
        block = nil,
    },

    ---LHS of extra mappings
    ---@type table
    extra = {
        ---Add comment on the line above
        above = nil,
        ---Add comment on the line below
        below = nil,
        ---Add comment at the end of line
        eol = nil,
    },

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---NOTE: If `mappings = false` then the plugin won't create any mappings
    ---@type boolean|table
    mappings = {
        ---Operator-pending mapping
        ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---Extra mapping
        ---Includes `gco`, `gcO`, `gcA`
        extra = false,
        ---Extended mapping
        ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
        extended = false,
    },

    ---Pre-hook, called before commenting the line
    ---@type fun(ctx: CommentCtx):string
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    ---@type fun(ctx: CommentCtx)
    post_hook = nil,
})

-- vim.api.nvim_set_keymap('x', '<space>c', '<Plug>(comment_toggle_blockwise_visual)', {})
vim.api.nvim_set_keymap('x', '<space>c', '<Plug>(comment_toggle_linewise_visual)', {})

local ft = require('Comment.ft')

ft.set('c', '/*%s*/')

  end }
