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

    for k,_ in pairs(tasks) do
      RegisterWKByFiletype({
        [k] = {
          h = {
            name = 'config',
            t = {':lua openTasksMenu()<cr>', 'Enabled tasks'},
            e = {function() vim.api.nvim_command("e "..tasks_path) end, 'Edit tasks'},
            r = {Setup_tasks, 'Reload tasks'}
          }
        },
      }, 'n')

    end
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
