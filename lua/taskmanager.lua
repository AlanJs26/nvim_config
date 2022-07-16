function IsTableSingle(obj)
  for j,_ in pairs(obj) do
    if j>1 then
      return false
    end
  end
  return true
end
function TaskManager(a)
  local map_list = {'a','d','f','q','w','e','r','z','x','c','v'}
  local wk = require("which-key")
  for k,v in pairs(a) do
    local opts = {u = {}}



    local single = IsTableSingle(v)

    for i,task in ipairs(v) do
      if single == true then
        vim.api.nvim_create_autocmd(
          'BufEnter,BufNew',
          {
            pattern = '*',
            callback = function()
              if vim.o.filetype ~= k then
                return
              end
              local newcommand = task[1]
              for value in task[1]:gmatch("{{(.-)}}") do
                local parsed_value = value
                if string.match(value, "^[gb]:") then
                  parsed_value = string.format('expand(%s)', value)
                else
                  parsed_value = string.format('expand("%%:%s")',value)
                end

                newcommand = string.gsub(newcommand, '{{'..value..'}}', vim.api.nvim_eval(parsed_value))
              end
              wk.register({u = {function()
                  vim.api.nvim_command(newcommand)
                  -- vim.api.nvim_feedkeys('G', 'n', false)
                  vim.api.nvim_feedkeys('i', 'n', false)
                end, task[2]}
              }, {prefix = '<leader>', nowait = true, buffer = vim.fn.bufnr('%')})
            end
          }
          )
      else
        opts['u'][map_list[i]] = task
      end
    end
    if single == false then
      vim.api.nvim_create_autocmd(
        'BufEnter,BufNew',
        {
          pattern = '*',
          callback = function()
            if vim.o.filetype ~= k then
              return
            end

            local newopts = {u={}}
            for key, item in pairs(opts.u) do
                    
              local new_command = item[1]
              for value in item[1]:gmatch("{{(.-)}}") do
                local parsed_value = value
                if string.match(value, "^[gb]:") then
                  parsed_value = string.format('expand(%s)', value)
                else
                  parsed_value = string.format('expand("%%:%s")',value)
                end

                new_command = string.gsub(new_command, '{{'..value..'}}', vim.api.nvim_eval(parsed_value))
              end

              newopts.u[key] = {
                function()
                  vim.api.nvim_command(new_command)
                  -- vim.api.nvim_feedkeys('G', 'n', false)
                  vim.api.nvim_feedkeys('i', 'n', false)
                end, 
                opts.u[key][2]
              }
            end


            newopts.u.name = 'tasks'

            wk.register(newopts, {prefix = '<leader>', nowait = true, buffer = vim.fn.bufnr('%')})
          end
        }
        )
    end
  end
end


function RegisterWKByFiletype(a, mode)
  local wk = require("which-key")
  for filetype,opts in pairs(a) do
    vim.api.nvim_create_autocmd(
      'BufEnter,BufNew',
      {
        pattern = '*',
        callback = function()
          if vim.o.filetype ~= filetype then
            return
          end
          wk.register(opts, {prefix = '<leader>', mode=mode, noremap = false, buffer = vim.fn.bufnr('%')})
        end
      }
      )
  end
end

