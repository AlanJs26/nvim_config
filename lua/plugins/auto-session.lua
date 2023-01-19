  return { 'rmagatti/auto-session', config = function()


require('auto-session').setup({
  -- auto_session_root_dir = "C:/Users/alanj/AppData/Local/nvim/session",
  auto_session_suppress_dirs = {'~/', 'G:/Users/Alan/Documents/_Codes', '~/Documents/_Codes'}
})
  end }
