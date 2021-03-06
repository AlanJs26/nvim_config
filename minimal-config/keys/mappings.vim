:command! VisualBlock execute "normal! \<C-v>" 

map ZZ <Nop>

nnoremap <silent> <M-w>       :close       <CR>
nnoremap <silent> <M-v>       :VisualBlock <CR>

nnoremap <Up>    gk
nnoremap <Down>  gj
imap     <Up>    <C-O>gk
imap     <Down>  <C-O>gj

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

if !exists('g:vscode')
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


  nmap <silent> <M-[>   :BufferLineCycleNext  <CR>
  nmap <silent> <M-]>   :BufferLineCyclePrev  <CR>
  nnoremap <silent> <C-[>   :BufferLineMoveNext<CR>


  nnoremap <C-z> :undo<CR>
  inoremap <C-z> <C-O>:undo<CR>



  nnoremap <silent>??s :Git<CR>

  nnoremap <silent> ??j :MundoToggle<CR>
else

  function FocusSidebar()
    call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')
    sleep 300m
    call VSCodeNotify('workbench.action.focusSideBar')
  endfunction
  nnoremap  <silent> <space>w        :  <CR>
  nnoremap  <silent> <space>a        :Wall  <CR>
  nnoremap  <silent> <space>n        <Cmd>call FocusSidebar()<CR>
  nnoremap  <silent> <space>f        <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap  <silent> <space>g        <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  nnoremap  <silent> <space>d        <Cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>

  " nnoremap  <silent> <space>cc       <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>
  " nnoremap  <silent> <space>c<space> <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>
  " vnoremap  <silent> <space>cc       <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>
  " vnoremap  <silent> <space>c<space> <Cmd>call VSCodeNotify('editor.action.commentLine')<CR>


  xmap <space>c <Plug>VSCodeCommentary
  nmap <space>c <Plug>VSCodeCommentary
  omap <space>c <Plug>VSCodeCommentary
  nmap <space>c<space> <Plug>VSCodeCommentaryLine
  nmap <space>cc  <Plug>VSCodeCommentaryLine
endif

function! OpenCurrentAsNewTab()
    let l:currentPos = getcurpos()
    tabedit %
    call setpos(".", l:currentPos)
endfunction

"nnoremap <silent> <C-t>       :tabnew      <CR>
"nnoremap <silent> <C-[>       :tabNext      <CR>
"nnoremap <silent> <C-\>       :tabprevious  <CR>
"nnoremap <silent> <C-w>       :tabclose     <CR>
nmap go :call OpenCurrentAsNewTab()<CR>

lua << EOF
function _G.searchTerminal()
  local currentbuf = vim.api.nvim_get_current_buf()
  local currentbufname = vim.api.nvim_buf_get_name(currentbuf)
  
  if string.find(currentbufname, 'term') then
    vim.api.nvim_command(':wincmd p')
    return
  end

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win);
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    
    if string.find(bufname, 'term') then
      vim.api.nvim_set_current_win(win)
      vim.fn.feedkeys('i')
      return
    end
  end
end
EOF

nnoremap <silent> <A-d> :vsp<bar>term<CR>:SendHere<CR>i
tnoremap <silent> <A-d> <C-\><C-n>

tnoremap <silent> <A-p> <C-\><C-n><C-w>p
nnoremap <silent> <A-p> :call v:lua.searchTerminal()<CR>
" nnoremap <silent> <expr> <A-p> v:lua.searchTerminal()

nnoremap <silent> vs       :vsplit     <CR>
" nnoremap <silent> hs       :split     <CR>

inoremap <silent> <M-v> <Esc> :VisualBlock <CR>


" Original

nnoremap <silent> <M-o> moo<ESC>`o
nnoremap <silent> <M-O> moO<ESC>`o
nnoremap <silent> \ @q

"very magic mode
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
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

" return to last insert position
nnoremap gl `.


nmap <silent>gm %
xmap <silent>gm %

" faster search and replace
nnoremap ??r :%s//
nnoremap ??g :%g//norm 
nnoremap ??f za 

" center horizontally
nnoremap <silent> z. :<C-u>normal! zszH<CR>

" line text objects
:vnoremap <silent> al :<c-u>norm!0v$h<cr>
:vnoremap <silent> il :<c-u>norm!^vg_<cr>
:onoremap <silent> al :norm val<cr>
:onoremap <silent> il :norm vil<cr>
:nnoremap <silent> yal :norm valy<cr>g_
:nnoremap <silent> yil :norm vily<cr>g_


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


let g:user_emmet_leader_key='??'

let g:easyescape_chars = { "j": 1, "k": 1, "J": 1, "K": 1 }
let g:easyescape_timeout = 100
" inoremap jk <ESC>
" inoremap kj <ESC>
" inoremap JK <ESC>
" inoremap KJ <ESC>

inoremap jj <ESC>
inoremap JJ <ESC>

nmap <M-.> <C-a>
nmap <M-,> <C-x>
xmap <M-.> g<C-a>
xmap <M-,> g<C-x>

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

nnoremap ?? hEdiWdF h
inoremap <C-j> <ESC>hEdiWdF i

" autocmd FileType html imap <silent> <C-Space>  <C-O>:call emmet#expandAbbr(3, "")<CR>

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange("")<CR>
xnoremap \ :<C-u>call ExecuteMacroOverVisualRange("q")<CR>

function! ExecuteMacroOverVisualRange(register)
  echo "@".getcmdline()
  if a:register != ""
    execute ":'<,'>normal @" .. a:register
  else
    execute ":'<,'>normal @".nr2char(getchar())
  endif
endfunction


