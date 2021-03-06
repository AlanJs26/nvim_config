
let g:startify_session_dir = '~/AppData/Local/nvim/session'

let s:startify_ascii_header = [
\ '                                        ██\',              
\ '                                        \__|',              
\ '███████\   ██████\   ██████\ ██\    ██\ ██\ ██████\████\', 
\ '██  __██\ ██  __██\ ██  __██\\██\  ██  |██ |██  _██  _██\',
\ '██ |  ██ |████████ |██ /  ██ |\██\██  / ██ |██ / ██ / ██ |',
\ '██ |  ██ |██   ____|██ |  ██ | \███  /  ██ |██ | ██ | ██ |',
\ '██ |  ██ |\███████\ \██████  |  \█  /   ██ |██ | ██ | ██ |',
\ '\__|  \__| \_______| \______/    \_/    \__|\__| \__| \__|',
 \ '',
 \]

let g:startify_custom_header = map(s:startify_ascii_header, '"   ".v:val')

let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']                     },
          \ { 'type': 'files',     'header': ['   Files']                        },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']                    },
          \ ]


let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_persistence = 1

let g:webdevicons_enable_startify = 1

function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

let g:startify_enable_special = 0
