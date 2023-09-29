return {
  {
    'stevearc/vim-arduino',
    ft = {'arduino'},
    cond = (not vim.fn.has('win32')),
    config = function()
      vim.cmd([[
        autocmd BufEnter,BufNew *.ino :ArduinoChoosePort /dev/ttyUSB0
        autocmd BufEnter,BufNew *.ino :ArduinoSetBaud 115200
      ]])
    end
  },
}
