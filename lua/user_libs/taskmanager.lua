local M = {}

local augroupname
local namespace
local Terminal = require('toggleterm.terminal').Terminal

M.custom_command = {
  content = '',
  term = nil
}

M.custom_command.input = function()
  vim.ui.input({
      prompt='custom command: ',
      default = vim.g.CustomCommand or M.custom_command.content
    },
    function(result)
      if not result then
        return
      end

      M.custom_command.content = result
      vim.g.CustomCommand = result
      M.custom_command.call()
    end)
end

M.custom_command.call = function()
  if M.custom_command.content == '' then
    M.custom_command.input()
    return
  end

  if type(M.opts.before) == 'function' then
    M.opts.before()
  elseif type(M.opts.before) == 'string' then
    vim.cmd(M.opts.before)
  end

  M.custom_command.term = Terminal:new({
    cmd = M.parse_entry(M.custom_command.content),
    direction = M.opts.direction,
    close_on_exit = false,
  })
  M.custom_command.term:toggle()

  if type(M.opts.after) == 'function' then
    M.opts.after()
  elseif type(M.opts.after) == 'string' then
    vim.cmd(M.opts.after)
  end

end

M.attach_main_map = function(task, index, buflist)
    M.main_task_index = index

    opts = {}
    if task[1] == M.custom_command.input then
      opts[M.opts.main_map] = {M.create_task_runner({M.custom_command.call, 'run custom task'}, M.main_task_index, buflist), task[2]}
    else
      opts[M.opts.main_map] = {M.create_task_runner(task, M.main_task_index, buflist), task[2]}
    end
    local wk = require("which-key")
    for i,bufnr in ipairs(buflist) do
      if vim.fn.bufexists(bufnr) == 1 then
        wk.register(opts, {prefix = '<leader>', nowait = true, buffer = bufnr})
      end
    end
end

M.parse_entry = function(entry)
  if type(entry) == 'function' then
    return entry
  end
  local new_entry = entry
  for m in entry:gmatch("{{(.-)}}") do
    local parsed_value = m

    if string.match(m, "^[gb]:") then
      parsed_value = string.format('expand(%s)', m)
    else
      parsed_value = string.format('expand("%%:%s")', m)
    end

    new_entry = string.gsub(new_entry, '{{'..m..'}}', vim.api.nvim_eval(parsed_value))
  end

  return new_entry
end

M.create_task_runner = function (task, index, buflist)
  local entry = M.parse_entry(task[1])
  term = nil

  return function ()
    M.attach_main_map(task, index, buflist)

    if type(task.before) == 'function' then
      task.before()
    elseif type(task.before) == 'string' then
      vim.cmd(task.before)
    end

    if type(entry) == 'string' then

      if term == nil then
        term = Terminal:new({
          cmd = entry,
          direction = task.direction,
          close_on_exit = false,
        })
      end

      term:toggle()
    else
      entry()
    end

    if type(task.after) == 'function' then
      task.after()
    elseif type(task.after) == 'string' then
      vim.cmd(task.after)
    end




  end
end

function M.setup(opts)
  M.tasks = {} -- filetype = { autocmd_id = {id,...}, {command, title, disabled[true|false]},... }
  augroupname = vim.api.nvim_create_augroup('taskmanager_au', {clear = true})
  namespace = vim.api.nvim_create_namespace('taskmanager_highlights')

  M.opts = {
    map_list = {'a','d','f','q','w','e','r','z','x','c','v'},
    main_map = 'u',
    secondary_map = 'U',
    group_name = 'tasks',
    before = nil,
    after = nil,
    exclude_filetypes = {'NvimTree', 'Alpha', 'WhichKey'},
    direction = 'float',
  }

  M.main_task_index = 1

  M.lines = {}

  if opts ~= nil then
    for key, value in pairs(opts) do
      M.opts[key] = value
    end
  end

  M.updateMenu()

  vim.api.nvim_create_autocmd(
    {'BufEnter','BufNew'},
    {
      pattern = '*',
      group = augroupname,
      callback = function()
        for i,item in ipairs(M.opts.exclude_filetypes) do
          if vim.o.filetype == item then
            return
          end
        end
        tasks = {}
        for ft,ft_tasks in pairs(M.subscribed_tasks) do
          if vim.o.filetype == ft then
            tasks = ft_tasks
            break
          end
        end

        local wk = require("which-key")

        local opts = {[M.opts.secondary_map] = {}}
        local enabled_tasks = {}
        local buflist = {}

        if #tasks == 0 then
          for i,item in ipairs(M.buflist) do
            if item == vim.fn.bufnr('%') then
              return
            end
          end
          table.insert(M.buflist, vim.fn.bufnr('%'))
          buflist = M.buflist

          table.insert(enabled_tasks, {M.custom_command.input, 'run custom task', disabled = false})
        else
          for i,item in ipairs(tasks.buflist) do
            if item == vim.fn.bufnr('%') then
              return
            end
          end
          table.insert(tasks.buflist, vim.fn.bufnr('%'))
          buflist = tasks.buflist

          local has_custom_task = false
          for i, task in ipairs(tasks) do
            if task[1] == M.custom_command.input then
              has_custom_task = true
            end
            if task.disabled == false then
              table.insert(enabled_tasks, task)
            end
            opts[M.opts.secondary_map][M.opts.map_list[i]] = {'', 'which_key_ignore'}
          end

          if has_custom_task == false then
            table.insert(tasks, {M.custom_command.input, 'run custom task', disabled = false})
            table.insert(enabled_tasks, {M.custom_command.input, 'run custom task', disabled = false})
          end

          wk.register(opts, {prefix = '<leader>', nowait = true, buffer = vim.fn.bufnr('%')})
        end



        if #enabled_tasks >= 1 then
          for i, task in ipairs(enabled_tasks) do
            opts[M.opts.secondary_map][M.opts.map_list[i]] = {M.create_task_runner(task, i, buflist), task[2]}
          end
          opts[M.opts.secondary_map].name = M.opts.group_name
        else
          M.main_task_index = 1
        end

        if #enabled_tasks > 0 and M.main_task_index <= #enabled_tasks  then
          task = enabled_tasks[M.main_task_index]
          if task[1] == M.custom_command.input then
            opts[M.opts.main_map] = {M.create_task_runner({M.custom_command.call, 'run custom task'}, M.main_task_index, buflist), task[2]}
          else
            opts[M.opts.main_map] = {M.create_task_runner(task, M.main_task_index, buflist), task[2]}
          end
        else
          opts[M.opts.main_map] = {'', 'which_key_ignore'}
        end
        wk.register(opts, {prefix = '<leader>', nowait = true, buffer = vim.fn.bufnr('%')})
      end
    }
  )

end

function M.register(tasks)

  for filetype, FiletypeTasks in pairs(tasks) do
    if M.tasks[filetype] == nil then
      M.tasks[filetype] = {}
    end
    local MFiletypeTasks = M.tasks[filetype]

    for _, task in ipairs(FiletypeTasks) do
      local found_duplicate = false

      local disabled = task.disabled
      if task.disabled == nil then
        disabled = false
      end

      for _, Mtask in ipairs(MFiletypeTasks) do
        if task[1] == Mtask[1] then
          found_duplicate = true
          Mtask[2] = task[2]
          Mtask.disabled = disabled
        end
      end

      if found_duplicate == false then
        table.insert(MFiletypeTasks, {
            disabled = disabled,
            before = task.before or M.opts.before,
            after = task.after or M.opts.after,
            direction = task.direction or M.opts.direction,
            unpack(task),
          })
      end
    end

    M.subscribe_filetype(MFiletypeTasks, filetype)
  end

  M.updateMenu()

  -- print(vim.inspect(M.tasks))

end



M.buflist = {}
M.subscribed_tasks = {}
function M.subscribe_filetype(tasks, filetype)
  M.subscribed_tasks[filetype] = tasks
  M.subscribed_tasks[filetype].buflist = {}
end


------- Menu

local function add_menu_highlights()
  local buf = vim.api.nvim_get_current_buf()
  local buflines = vim.api.nvim_buf_line_count(buf)

  for i=0,buflines do
    local line = vim.api.nvim_buf_get_lines(buf, i, i+1, false)[1]

    if line ~= nil then
      local start_index = 0
      local end_index = 0

      start_index, end_index = line:find('disabled')

      if start_index ~= nil then
        vim.api.nvim_buf_add_highlight(buf, namespace, 'Error', i, start_index-1, end_index)
      else
        start_index, end_index = line:find('enabled')

        if start_index ~= nil then
          vim.api.nvim_buf_add_highlight(buf, namespace, 'String', i, start_index-1, end_index)
        end
      end
      
    end

  end
end

function M.updateMenu()
  local Menu = require("nui.menu")
  local event = require("nui.utils.autocmd").event

  M.lines = {}

  M.buflist = {}
  for filetype, FiletypeTasks in pairs(M.tasks) do
    if filetype == vim.o.filetype then
      FiletypeTasks.buflist = {}
      for _, task in ipairs(FiletypeTasks) do
        local disabled = 'enabled'
        if task.disabled then
          disabled = 'disabled'
        end
        table.insert(M.lines, Menu.item(' ['..disabled..']  ' .. task[2]))
      end
      break
    end
  end

  M.menu = Menu({
    position = "50%",
    size = {
      width = 65,
      height = #M.lines == 0 and 4 or #M.lines,
    },
    border = {
      style = "single",
      text = {
        top = string.format('[Tasks for "%s"]', vim.o.filetype),
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    lines = M.lines,
    max_width = 20,
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", 'q' },
      submit = { "<CR>", "<Space>" },
    },
    on_submit = function(item)
      local parsed_item = item.text:gsub('%[%w+%]', '')

      for _, FiletypeTasks in pairs(M.tasks) do
        for _, task in ipairs(FiletypeTasks) do
          if string.find(parsed_item, task[2]) ~= nil then
            task.disabled = not task.disabled
            goto exitloop
          end
        end
      end
      ::exitloop::

      M.updateMenu()

      M.menu:mount()
      add_menu_highlights()
    end,
  })

  -- close menu when cursor leaves buffer
  M.menu:on(event.BufLeave, M.menu.menu_props.on_close, { once = true })
end

function _G.openTasksMenu()
  M.menu:mount()
  add_menu_highlights()
end

return M
