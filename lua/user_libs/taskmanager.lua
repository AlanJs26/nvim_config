local M = {}

local augroupname
local namespace

function M.setup(opts)
  M.tasks = {} -- filetype = { autocmd_id = {id,...}, {command, title, disabled[true|false]},... }
  augroupname = vim.api.nvim_create_augroup('taskmanager_au', {clear = true})
  namespace = vim.api.nvim_create_namespace('taskmanager_highlights')

  M.opts = {
    map_list = {'a','d','f','q','w','e','r','z','x','c','v'},
    group_name = 'tasks',
    prefix = 'term ',
    before = 'w|sp',
    after = 'call feedkeys("i")',
  }

  if opts ~= nil then
    for key, value in pairs(opts) do
      M.opts[key] = value
    end
  end

  M.updateMenu()

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
            prefix = task.prefix or M.opts.prefix,
            unpack(task),
          })
      end
    end

    M.subscribe_filetype(MFiletypeTasks, filetype)
  end

  M.updateMenu()

  -- print(vim.inspect(M.tasks))

end

local function parse_entry(entry)
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

function M.subscribe_filetype(tasks, filetype)
  if tasks.autocmd_id ~= nil then
    return
  end

  tasks.autocmd_id = vim.api.nvim_create_autocmd(
    'BufEnter,BufNew',
    {
      pattern = '*',
      group = augroupname,
      callback = function()
        if vim.o.filetype ~= filetype then
          return
        end
        local wk = require("which-key")

        local opts = {u = {}}

        local enabled_tasks = {}
        for i, task in ipairs(tasks) do
          if task.disabled == false then
            table.insert(enabled_tasks, task)
          else
            opts.u[M.opts.map_list[i]] = {'', 'which_key_ignore'}
          end
        end

        if #tasks - #enabled_tasks > 0 then
          if #enabled_tasks == 1 then
            opts.u[M.opts.map_list[1]] = {'', 'which_key_ignore'}
          end
          wk.register(opts, {prefix = '<leader>', nowait = true, buffer = vim.fn.bufnr('%')})
        end

        local callback = function (task)
          local entry = parse_entry(task[1])
          return function ()
            local commands = ''

            if task.before ~= nil then
              commands = commands .. task.before .. '\n'
            end

            commands = commands .. task.prefix .. entry

            if task.after ~= nil then
              commands = commands .. '\n' ..task.after
            end
            vim.cmd(commands)
          end
        end

        opts = {u = {}}
        if #enabled_tasks > 0 then
          if #enabled_tasks == 1 then
            local task = enabled_tasks[1]
            opts.u = {callback(task), task[2]}
            opts.u.name = nil
          else

            for i, task in ipairs(enabled_tasks) do
              opts.u[M.opts.map_list[i]] = {callback(task), task[2]}
            end
            opts.u.name = M.opts.group_name
            wk.register({u = {'', 'which_key_ignore'}}, {prefix = '<leader>', nowait = true, buffer = vim.fn.bufnr('%')})
          end

          wk.register(opts, {prefix = '<leader>', nowait = true, buffer = vim.fn.bufnr('%')})
        else

          wk.register({u = {'', 'which_key_ignore'}}, {prefix = '<leader>', nowait = true, buffer = vim.fn.bufnr('%')})
        end
        -- vim.fn.feedkeys('i'..vim.inspect(opts))

      end
    }
  )
end

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

  local lines = {}

  for filetype, FiletypeTasks in pairs(M.tasks) do
    if filetype == vim.o.filetype then
      for _, task in ipairs(FiletypeTasks) do
        local disabled = 'enabled'
        if task.disabled then
          disabled = 'disabled'
        end
        table.insert(lines, Menu.item(' ['..disabled..']  ' .. task[2]))
      end
      break
    end
  end

  M.menu = Menu({
    position = "50%",
    size = {
      width = 65,
      height = #lines,
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
    lines = lines,
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
