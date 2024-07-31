
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
