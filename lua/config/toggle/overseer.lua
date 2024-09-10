---@class overseer.user.toggle
local M = {}

local util = LazyVim

M._focus = true
M.focus = util.toggle.wrap({
  name = "Focus",
  get = function()
    return M._focus
  end,

  ---@param state boolean
  set = function(state)
    if state then
      M._focus = true
    else
      M._focus = false
    end
  end,
})

M._float = true
M.float = util.toggle.wrap({
  name = "Float",
  get = function()
    return M._float
  end,

  ---@param state boolean
  set = function(state)
    if state then
      M._float = true
    else
      M._float = false
    end
  end,
})

setmetatable(M, {
  __call = function(m, ...)
    return m.option(...)
  end,
})

return M
