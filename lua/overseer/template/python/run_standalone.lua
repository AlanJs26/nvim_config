return {
  name = "python run standalone",
  builder = function()
    local output_file = vim.fn.expand("%")
    return {
      cmd = { "python", output_file },
      components = {
        "default",
      },
    }
  end,
  condition = {
    filetype = { "python" },
  },
}
