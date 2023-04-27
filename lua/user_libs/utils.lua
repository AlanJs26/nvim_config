local Input = require("nui.input")
local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event

local M = {}

function run_action(func)
  if not func then
    return
  end

  if type(func) == 'function' then
    func()
  else
    vim.api.nvim_command(func)
  end
end

function _G.create_file(command, prefix, ext)
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
          top = "Filename",
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
      local new_value = string.gsub(value, '%.%w+$', '')
      new_value = string.format('%s/%s.%s', prefix, new_value, ext)
      new_value = string.gsub(new_value, ":file:", value)

      vim.api.nvim_command(string.format('e %s', new_value))

      vim.wait(100)
      vim.fn.feedkeys(command)
      vim.api.nvim_command("W")
    end,
  })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end


function _G.confirmPopup(query, positive_action, negative_action)
  local input = Menu({
    position = "50%",
    size = {
        width = string.len(query)+5,
        height = 2,
    },
    relative = "editor",
    border = {
      style = "rounded",
      text = {
          top = query,
          top_align = "center",
      },
    },
    win_options = {
      winblend = 10,
      winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
      -- winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    lines = {
      Menu.item("no"),
      Menu.item("yes"),
    },
    keymap = {
      focus_next = { "j", "<Down>", "<Tab>" },
      focus_prev = { "k", "<Up>", "<S-Tab>" },
      close = { "<Esc>", "<C-c>", "n", "q" },
      submit = { "<CR>", "<Space>" },
    },
    on_close = function()
      run_action(negative_action)
    end,
    on_submit = function(item)
      if item.text == 'yes' then
        run_action(positive_action)
      else
        run_action(negative_action)
      end
    end,
  })

  -- mount/open the component
  input:mount()

  vim.keymap.set('n', 'y', function()
    run_action(positive_action)
    input:unmount()
  end , {buffer = true, silent = true})

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end



M.RegisterWKByFiletype = _G.RegisterWKByFiletype
function _G.RegisterWKByFiletype(a, mode)
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



M.floatwin = _G.floatwin
M.create_file = _G.create_file
M.confirmPopup = _G.confirmPopup
M.RegisterWKByFiletype = _G.RegisterWKByFiletype
M.run_action = run_action

return M
