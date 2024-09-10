return {
  name = "g++ build standalone",
  builder = function()
    local file = vim.fn.expand("%:p")
    local output_file = vim.fn.expand("%:p:r")
    return {
      cmd = { "g++" },
      args = { file, "-o", output_file },
      components = { "default" },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
