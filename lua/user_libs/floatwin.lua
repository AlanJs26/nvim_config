local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

function _G.floatwin(command, title)
  local input = Input({
    position = "50%",
    size = {
        width = 20,
        height = 2,
    },
    relative = "editor",
    border = {
      style = "single",
      text = {
          top = title,
          top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "Normal:Normal",
    },
  }, {
    prompt = "> ",
    default_value = "",
    on_close = function()
      print("Input closed!")
    end,
    on_submit = function(value)
      local newcommand = command
      for match in command:gmatch("{{(.-)}}") do
        local parsed_value = match

        if string.match(match, "value") then
          newcommand = string.gsub(newcommand, '{{'..match..'}}', value)
        else
          if string.match(match, "^[gb]:") then
            parsed_value = string.format('expand(%s)', match)
          else
            parsed_value = string.format('expand("%%:%s")',match)
          end
          newcommand = string.gsub(newcommand, '{{'..match..'}}', vim.api.nvim_eval(parsed_value))
        end


      end

      vim.api.nvim_command(newcommand)
      -- vim.fn.feedkeys(command)
      -- vim.api.nvim_command("W")
    end,
  })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end





