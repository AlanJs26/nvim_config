:command! VisualBlock execute "normal! \<C-v>" 

let g:mapleader="\<space>"

map ZZ <Nop>
autocmd BufRead * imap <M-k> <up>
imap <c-l> <End>
inoremap <c-h> <c-o>^

command! ReloadTasks source C:\Users\alanj\AppData\Local\nvim\lua\tasks.lua
command! EditTasks e C:\Users\alanj\AppData\Local\nvim\lua\tasks.lua

cnoreabbrev git Git

nnoremap <silent> <M-w>       :close       <CR>
nnoremap <silent> <M-v>       :VisualBlock <CR>
inoremap <silent> <M-v> <Esc> :VisualBlock <CR>

nnoremap <Up>    gk
nnoremap <Down>  gj
imap     <Up>    <C-O>gk
imap     <Down>  <C-O>gj

nnoremap <silent> vs       :vsplit     <CR>

" create lines while in normal mode
nnoremap <silent> <M-o> moo<ESC>`o
nnoremap <silent> <M-O> moO<ESC>`o

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>   :resize -2<CR>
nnoremap <silent> <M-k>   :resize +2<CR>
nnoremap <silent> <M-h>   :vertical resize +2<CR>
nnoremap <silent> <M-l>   :vertical resize -2<CR>

" Better window navigation
nnoremap <C-h>   <C-w>h
nnoremap <C-j>   <C-w>j
nnoremap <C-k>   <C-w>k
nnoremap <C-l>   <C-w>l
nnoremap <C-m>   <C-w>w

" Move cursor while in insert mode
inoremap <silent> <M-h>       <left>
inoremap <silent> <M-j>       <down>
imap <silent> <M-k>       <up> 
inoremap <silent> <M-l>       <right>

nnoremap <C-z> :undo<CR>
inoremap <C-z> <C-O>:undo<CR>

inoremap jj <ESC>
inoremap JJ <ESC>

nmap <M-.> <C-a>
nmap <M-,> <C-x>
xmap <M-.> g<C-a>
xmap <M-,> g<C-x>



" return to last insert position
nnoremap gl `.

nmap <silent>gm %
xmap <silent>gm %

" faster search and replace
nnoremap çr :%s//
nnoremap çg :%g//norm 
nnoremap çf za 

xmap çr :s//
xmap çg :g//norm 
xmap çf za 

" center horizontally
nnoremap <silent> z. :<C-u>normal! zszH<CR>

" line text objects
vnoremap <silent> al :<c-u>norm!0v$h<cr>
vnoremap <silent> il :<c-u>norm!^vg_<cr>
onoremap <silent> al :norm val<cr>
onoremap <silent> il :norm vil<cr>
nnoremap <silent> yal :norm valy<cr>g_
nnoremap <silent> yil :norm vily<cr>g_

" delete word under cursor
nnoremap Ç hBi <esc>ldiWciw <esc>gE
inoremap <C-j> <esc>lBi <esc>ldiWciw <esc>gEa

" creates a new tab using current buffer as main window
function! OpenCurrentAsNewTab()
    let l:currentPos = getcurpos()
    tabedit %
    call setpos(".", l:currentPos)
endfunction

nmap go :call OpenCurrentAsNewTab()<CR>

"very magic mode
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap s/ smagic/
cnoremap \>s/ \>smagic/

" Turn on all other features.
let g:VeryMagicSubstituteNormalise = 1
let g:VeryMagicSubstitute = 1
let g:VeryMagicGlobal = 1
let g:VeryMagicVimGrep = 1
let g:VeryMagicSearchArg = 1
let g:VeryMagicFunction = 1
let g:VeryMagicHelpgrep = 1
let g:VeryMagicRange = 1
let g:VeryMagicEscapeBackslashesInSearchArg = 0
let g:SortEditArgs = 1

" If I type // or ??, I don't EVER want \v, since I'm repeating the previous
" search.
noremap // //<CR>
noremap ?? ??<CR>
" no-magic searching
noremap /v/ /\V
noremap ?V? ?\V

" join motion
nnoremap <silent>J :set operatorfunc=Joinoperator<CR>g@
nnoremap <silent>gJ :set operatorfunc=GJoinoperator<CR>g@
onoremap <silent>J j
func! Joinoperator(submode)
        '[,']join
endfunc
func! GJoinoperator(submode)
        '[,']join!
endfunc 



xnoremap @ :<C-u>call ExecuteMacroOverVisualRange("")<CR>
xnoremap \ :<C-u>call ExecuteMacroOverVisualRange("q")<CR>
nnoremap <silent> \ @q

function! ExecuteMacroOverVisualRange(register)
  echo "@".getcmdline()
  if a:register != ""
    execute ":'<,'>normal @" .. a:register
  else
    execute ":'<,'>normal @".nr2char(getchar())
  endif
endfunction

function! s:WriteCreatingDirs()
  let l:file=expand("%")
  if empty(getbufvar(bufname("%"), '&buftype')) && l:file !~# '\V^\w+\:\/'
    let dir=fnamemodify(l:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
      write
      lcd %:p:h
    endif
  endif
endfunction
command! W call s:WriteCreatingDirs()


" Search for selected text.
" http://vim.wikia.com/wiki/VimTip171
let s:save_cpo = &cpo | set cpo&vim
if !exists('g:VeryLiteral')
  let g:VeryLiteral = 0
endif
function! s:VSetSearch(cmd)
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  normal! gvy
  if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
    let @/ = @@
  else
    let pat = escape(@@, a:cmd.'\')
    if g:VeryLiteral
      let pat = substitute(pat, '\n', '\\n', 'g')
    else
      let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
      let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
      let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
    endif
    let @/ = '\V'.pat
  endif
  normal! gV
  call setreg('"', old_reg, old_regtype)
endfunction
vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<CR>/<C-R>/<CR>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<CR>?<C-R>/<CR>
vmap <kMultiply> *
nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
  \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<CR>
if !hasmapto("<Plug>VLToggle")
  " nmap <unique> <Leader>vl <Plug>VLToggle
endif
let &cpo = s:save_cpo | unlet s:save_cpo


" Terminal management

lua << EOF
function _G.searchTerminal(shouldsplit, preferclose)
local api = vim.api
local bufs = api.nvim_list_bufs()
local currentwin = api.nvim_get_current_win()
local currentbuf = api.nvim_get_current_buf()

local w = api.nvim_win_get_width(currentwin)
local h = api.nvim_win_get_height(currentwin)

local isterm = string.find(api.nvim_buf_get_name(currentbuf), 'term')
--local shouldsplit = true
--local preferclose = true

if isterm then
  if api.nvim_win_get_config(currentwin).relative ~= '' or preferclose then
    api.nvim_win_close(currentwin, false)
  else
    api.nvim_command(':wincmd p')
  end
  return
end

for _,win in ipairs(api.nvim_list_wins()) do
  local buf = api.nvim_win_get_buf(win)
  local bufname = api.nvim_buf_get_name(buf)
  
  if string.find(bufname, 'term') then
    api.nvim_set_current_win(win)
    vim.fn.feedkeys('i')
    return
  end
end

local foundbuffer = nil

for _,buf in ipairs(bufs) do
  if string.find(api.nvim_buf_get_name(buf), 'term')  then
    foundbuffer = buf
    break
  end
end

local floatopts = {
  width = w-15,
  height = h-7,
  relative = 'win',
  row = 3 ,
  col = 7,
  border = 'rounded'
}
if foundbuffer == nil then
  if shouldsplit then
    api.nvim_command(':vsp|term')
    api.nvim_command(':SendHere')
    foundbuffer = api.nvim_get_current_buf()
    vim.fn.setbufvar(foundbuffer, '&buflisted', 0)
  else
    foundbuffer = api.nvim_create_buf(false, false)

    api.nvim_open_win(foundbuffer, true, floatopts )
    api.nvim_command('term')
    api.nvim_command(':SendHere')
    vim.fn.setbufvar(foundbuffer, '&buflisted', 0)
  end
else
  if shouldsplit then
    api.nvim_command(':vsp')
    api.nvim_win_set_buf(0,foundbuffer)
  else
    api.nvim_open_win(foundbuffer, true, floatopts )
  end
end
vim.o.number = false
vim.fn.feedkeys('i')
end
vim.keymap.set('t', '<A-p>', function()searchTerminal(false,false)end, {noremap = true})
EOF

nnoremap <silent> <A-d> :call v:lua.searchTerminal(v:true,v:true)<CR>
tnoremap <silent> <A-d> <C-\><C-n>

" tnoremap <silent> <A-p> <C-\><C-n><C-w>p
nnoremap <silent> <A-p> :call v:lua.searchTerminal(v:false,v:false)<CR>


