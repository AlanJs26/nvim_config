return {
  name = "gcc run standalone",
  builder = function()
    local output_file = vim.fn.expand("%:p:r")
    return {
      cmd = { output_file },
      components = {
        {
          "dependencies",
          task_names = {
            "gcc build standalone",
          },
          sequential = true,
        },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "c" },
  },
}
