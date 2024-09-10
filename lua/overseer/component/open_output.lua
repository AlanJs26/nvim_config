local constants = require("overseer.constants")
local STATUS = constants.STATUS

---@param task overseer.Task
---@param direction "dock"|"float"|"tab"|"vertical"|"horizontal"
---@param focus boolean
local function open_output(task, direction, focus)
  focus = focus or require("config.toggle.overseer")._focus
  direction = require("config.toggle.overseer")._float and "float" or direction

  if direction == "dock" then
    local window = require("overseer.window")
    window.open({
      direction = "bottom",
      enter = focus,
      focus_task_id = task.id,
    })
  else
    ---@cast direction "float"|"tab"|"vertical"|"horizontal"
    local winid = vim.api.nvim_get_current_win()
    local task_window_id = nil
    local buffer_id = task:get_bufnr()

    local last_bufnr = task.env and task.env["last_bufnr"] or nil

    -- Only open window if there are no windows already open
    local windows = vim.fn.win_findbuf(last_bufnr)
    if #windows == 0 then
      task:open_output(direction)
    else
      task_window_id = windows[1]
    end

    -- Add keymap to exit
    vim.keymap.set("n", "q", function()
      vim.cmd("wincmd q")
    end, { buffer = buffer_id })

    -- Remove line numbers
    windows = vim.fn.win_findbuf(buffer_id)
    if #windows > 0 then
      vim.api.nvim_set_option_value("number", false, { win = windows[1] })
      task_window_id = windows[1]
    end

    -- Focus task window
    if focus and task_window_id ~= nil then
      vim.api.nvim_set_current_win(task_window_id)
      vim.cmd("startinsert")
    elseif direction ~= "float" then
      vim.api.nvim_set_current_win(winid)
    else
      vim.fn.feedkeys("G", "n")
    end

    -- Set current task buffer as last_bufnr
    task.env = vim.tbl_extend("force", task.env or {}, {
      last_bufnr = buffer_id,
    })
  end
end

---@type overseer.ComponentFileDefinition
local comp = {
  desc = "Open task output",
  params = {
    on_start = {
      desc = "Open the output when the task starts",
      type = "enum",
      choices = { "always", "never", "if_no_on_output_quickfix" },
      default = "if_no_on_output_quickfix",
      long_desc = "The 'if_no_on_output_quickfix' option will open the task output on start unless the task has the 'on_output_quickfix' component attached.",
    },
    on_complete = {
      desc = "Open the output when the task completes",
      type = "enum",
      choices = { "always", "never", "success", "failure" },
      default = "never",
    },
    on_result = {
      desc = "Open the output when the task produces a result",
      type = "enum",
      choices = { "always", "never", "if_diagnostics" },
      default = "never",
    },
    direction = {
      desc = "Where to open the task output",
      type = "enum",
      choices = { "dock", "float", "tab", "vertical", "horizontal" },
      default = "dock",
      long_desc = "The 'dock' option will open the output docked to the bottom next to the task list.",
    },
    focus = {
      desc = "Focus the output window when it is opened",
      type = "boolean",
      default = false,
    },
  },
  constructor = function(params)
    -- backwards compatibility
    if params.on_start == true then
      params.on_start = "always"
    elseif params.on_start == false then
      params.on_start = "never"
    end
    ---@type overseer.ComponentSkeleton
    local methods = {}

    if params.on_start ~= "never" then
      methods.on_start = function(self, task)
        if
          params.on_start == "always"
          or (params.on_start == "if_no_on_output_quickfix" and not task:has_component("on_output_quickfix"))
        then
          open_output(task, params.direction, params.focus)
        end
      end
    end

    if params.on_result ~= "never" then
      methods.on_result = function(self, task, result)
        if
          params.on_result == "always"
          or (params.on_result == "if_diagnostics" and not vim.tbl_isempty(result.diagnostics or {}))
        then
          open_output(task, params.direction, params.focus)
        end
      end
    end

    if params.on_complete ~= "never" then
      methods.on_complete = function(self, task, status, result)
        if
          params.on_complete == "always"
          or (params.on_complete == "success" and status == STATUS.SUCCESS)
          or (params.on_complete == "failure" and status == STATUS.FAILURE)
        then
          open_output(task, params.direction, params.focus)
        end
      end
    end

    return methods
  end,
}

return comp
