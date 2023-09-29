local M = {}

M.status = {ahead = 0, behind = 0, staged = 0, unstaged = 0, is_git_dir = false}
M.update_status = function()
  local Job = require'plenary.job'

  Job:new({
      command = 'git',
      args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
      on_exit = function(job, _)
        local res = job:result()[1]
        if type(res) ~= 'string' then
          M.status = {ahead = 0, behind = 0, staged = 0, unstaged = 0, is_git_dir = false}
          return
        end
        local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
        if not ok then 
          ahead, behind = 0, 0 
        end

        M.status.is_git_dir = true
        M.status.ahead = tonumber(ahead)
        M.status.behind = tonumber(behind)
      end,
    }):start()

  if M.status.is_git_dir == true then

    Job:new({
        command = 'git',
        args = { 'diff', '--numstat' },
        on_exit = function(job, _)
          local res = job:result()
          M.status.unstaged = #res
        end,
      }):start()

    Job:new({
        command = 'git',
        args = { 'diff', '--numstat', '--cached' },
        on_exit = function(job, _)
          local res = job:result()
          M.status.staged = #res
        end,
      }):start()
  end
end

if _G.Gstatus_timer == nil then
  _G.Gstatus_timer = vim.loop.new_timer()
  _G.Gstatus_timer:start(0, 2000,  vim.schedule_wrap(M.update_status))
else
  _G.Gstatus_timer:start(0, 2000,  vim.schedule_wrap(M.update_status))
end

return M
