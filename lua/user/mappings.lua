
-- local opts = {silent=true,noremap=true}
--
-- vim.keymap.set('n','<M-l>', ':vertical resize -4<CR>', opts)
-- vim.keymap.set('n', '<M-h>', ':vertical resize +4<CR>', opts)
--
-- local function conditional_resize(dir)
--     return function()
--         local pos = vim.api.nvim_win_get_position(0) 
--
--         if (pos[1] == 1 and pos[2] == 0) or (pos[1] ~= 1 and pos[2] == 0) then
--             if dir == 'up' then
--                 vim.cmd('resize +4')
--             else
--                 vim.cmd('resize +4')
--             end
--
--         end
--     end
-- end
--
-- vim.keymap.set('n', '<M-k>', conditional_resize('up'), opts)
--
-- vim.keymap.set('n', '<M-j>', conditional_resize('down'), opts)

-- command to rename current file
local function rename_file( args )
    local old_name = vim.fn.expand('%')
    local new_name = args.args
    local initial_buffer = vim.api.nvim_get_current_buf()
    if new_name ~= '' and new_name ~= old_name then
        vim.api.nvim_command('saveas '..new_name)
        vim.api.nvim_command('silent !rm '..old_name)
        vim.cmd('redraw!')
        local end_buffer = vim.api.nvim_get_current_buf()

        if initial_buffer ~= end_buffer then
            vim.api.nvim_buf_delete(initial_buffer)
        end

    end
end
vim.api.nvim_create_user_command('Rename', rename_file, { nargs='?' })

vim.cmd('cnoreabbrev rename Rename')

