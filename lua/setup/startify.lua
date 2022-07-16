vim.g.startify_session_dir = 'C:/Users/alanj/AppData/Local/nvim/session'

local startify_ascii_header = {
 '                                           ██\\',
 '                                           \\__|',
 '   ███████\\   ██████\\   ██████\\ ██\\    ██\\ ██\\ ██████\\████\\',
 '   ██  __██\\ ██  __██\\ ██  __██\\\\██\\  ██  |██ |██  _██  _██\\',
 '   ██ |  ██ |████████ |██ /  ██ |\\██\\██  / ██ |██ / ██ / ██ |',
 '   ██ |  ██ |██   ____|██ |  ██ | \\███  /  ██ |██ | ██ | ██ |',
 '   ██ |  ██ |\\███████\\ \\██████  |  \\█  /   ██ |██ | ██ | ██ |',
 '   \\__|  \\__| \\_______| \\______/    \\_/    \\__|\\__| \\__| \\__|',
 '   ',
}

vim.g.startify_custom_header = startify_ascii_header

vim.g.startify_lists = {
  { type = 'sessions',  header = {'   Sessions'}                     },
  { type = 'files',     header = {'   Files'}                        },
  { type = 'dir',       header = {'   Current Directory '.. vim.fn.getcwd()} },
  { type = 'bookmarks', header = {'   Bookmarks'}                    },
}


vim.g.startify_session_autoload = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1

vim.g.webdevicons_enable_startify = 1
vim.g.startify_enable_special = 0

vim.cmd([[
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction
]])



