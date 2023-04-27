local tm = require('user_libs.taskmanager')
local wk = require('which-key')

function Setup_tasks()
    local unalowedft = {'alpha', 'TelescopePrompt', 'NvimTree'}
    for _, value in ipairs(unalowedft) do
        if vim.o.filetype == value then
            return
        end
    end
    package.loaded.tasks = nil

    local tasks = require('tasks')

    tm.setup()
    tm.register(tasks)

    local function resolve(path)
      return path:gsub('\\', '/'):gsub('/$', '')
    end
    local tasks_path = resolve(vim.fn.stdpath("config").."/lua/tasks.lua")

    wk.register({
        U = {
            t = {':lua openTasksMenu()<cr>', 'Enabled tasks'},
            e = {function()

                local ui = vim.api.nvim_list_uis()[1]
                local w = ui.width
                local h = ui.height

                local buffer = vim.api.nvim_create_buf(0, 0)
                local win = vim.api.nvim_open_win(buffer, true, {
                  relative='editor',
                  width = w-15,
                  height = h-7,
                  style = 'minimal',
                  border = 'rounded',
                  row = 3 ,
                  col = 7,
                })

                vim.api.nvim_command("e "..tasks_path)
                vim.api.nvim_buf_set_option(buffer, 'buflisted', false)

            end, 'Edit tasks'},
            r = {Setup_tasks, 'Reload tasks'}
        }
    }, {prefix = "<leader>", nowait = true, mode='n' })

    -- for k,_ in pairs(tasks) do
    --   RegisterWKByFiletype({
    --     [k] = {
    --       h = {
    --         name = 'config',
    --         t = {':lua openTasksMenu()<cr>', 'Enabled tasks'},
    --         e = {function() vim.api.nvim_command("e "..tasks_path) end, 'Edit tasks'},
    --         r = {Setup_tasks, 'Reload tasks'}
    --       }
    --     },
    --   }, 'n')
    -- end
end

-- if pcall(function() local _ = tm.tasks end) then
--     Setup_tasks()
-- else
--     tm = require('user_libs.taskmanager')
-- end
--
local auid = nil

if auid == nil then
    auid = vim.api.nvim_create_autocmd(
        'BufRead',
        {
            pattern = '*',
            callback = function()
                Setup_tasks()
                if auid then
                    vim.api.nvim_del_autocmd(auid)
                end
            end
        }
        )
end
