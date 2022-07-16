let g:mapleader = "\<space>"
let g:maplocalleader = "ç"

" Map leader to which_key
" nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
" vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
" let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'


" Not a fan of floating windows for this
let g:which_key_use_floating_win = 1

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function


" Single mappings
lua << EOF
local wk = require('which-key')

wk.register({
    y = {":'<,'>YodeCreateSeditorFloating<cr>", 'create float with paragraph'}, 
    c = {name = 'comment'},
    r = {name = 'better replace'},
}, {prefix = "<leader>", nowait = true, mode='v' })

wk.register({
Q = { ':lua confirmPopup("Are you sure you want exit?", "qa!", "")<cr>',                  'force quit'},
q = { ':wqa<cr>',                  'quit save all'},
w = { ':w<cr>',                    'write'},
d = { ':bdelete<cr>',              'delete buffer'},
a = { ':wa<cr>',                   'write all'},
p = { ':Telescope<cr>',            'Telescope'},
g = { ':Telescope live_grep<cr>',  'live grep'},
f = { ':Telescope find_files<cr>', 'find file'},
i = { ':noh<cr>',                  'no highlights'},

c = {name = 'comment'},
r = {name = 'better replace'},
t = {
 name='+toggle',
 l= {':call CicleNumberMode()<cr>',                                    'line numbers'},
 L= {':set nonumber norelativenumber|let b:currentNumberMode = 0<cr>', 'hide line numbers'},
 w= {':call ToggleWrap(-1)<cr>',                                       'toggle word wrap'},
 m= {':wincmd ||wincmd _<cr>',                                         'maximize window'},
 n= {':wincmd =<cr>',                                                  'normalize windows'},
 s= {':set spell!<cr>',                                                'spell'},
 p= {':suspend<cr>',                                                   'suspend'},
 t= {':exe "vsp|term"|norm i<cr>',                      'vertical terminal'},
 T= {':exe "sp|term"|norm i<cr>',                       'horizontal terminal'},

 v= {':vsplit<cr>',                      'vertical split'},
 h= {':split<cr>',                       'horizontal split'}
 },
}, {prefix = "<leader>", nowait = true })



EOF

function! ScreenMovement(movement)
  if &wrap
    return "g" . a:movement
  else
    return a:movement
  endif
endfunction

function! ToggleWrap(mode)
  onoremap <silent> <expr> j  ScreenMovement("j")
  onoremap <silent> <expr> k  ScreenMovement("k")
  onoremap <silent> <expr> 0  ScreenMovement("0")
  onoremap <silent> <expr> ^  ScreenMovement("^")
  onoremap <silent> <expr> $  ScreenMovement("$")
  nnoremap <silent> <expr> j  ScreenMovement("j")
  nnoremap <silent> <expr> k  ScreenMovement("k")
  nnoremap <silent> <expr> 0  ScreenMovement("0")
  nnoremap <silent> <expr> ^  ScreenMovement("^")
  nnoremap <silent> <expr> g_ ScreenMovement("$")
  if a:mode < 0
  set wrap! linebreak
  elseif a:mode == 0
    set nowrap
  else
    set wrap linebreak
  endif
endfunction

autocmd BufReadPost * :let b:currentNumberMode = 1
function CicleNumberMode()
    if b:currentNumberMode == 0
        set number norelativenumber
    elseif b:currentNumberMode == 1 
        set number relativenumber
    elseif b:currentNumberMode == 2 
        set nonumber relativenumber
        let b:currentNumberMode = -1
    endif
    let b:currentNumberMode = b:currentNumberMode + 1 
endfunction

" Register which key map
" call which_key#register('<Space>', "g:which_key_map")
