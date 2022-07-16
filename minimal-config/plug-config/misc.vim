" vim visual multi
let g:VM_leader = 'ç'
let g:VM_maps = {}
let g:VM_mouse_mappings = 1
" let g:VM_maps["select all words in the file"] = 'ça' 

" auto pairs
let g:AutoPairsShortcutToggle = ''

" fix cursor hold
let g:cursorhold_updatetime = 600

" Crunch math eval
" nnoremap <silent>gn i<C-r>=<C-r>+<CR><ESC>
" vnoremap <silent>gn di<C-r>=<C-r>+<CR><ESC>
nmap <silent>gn <plug>(crunch-operator-line)
xnoremap <silent>gn <plug>(visual-crunch-operator)

" vim abolish
nmap gç  <Plug>(abolish-coerce-word)

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim targets
autocmd User targets#mappings#user call targets#mappings#extend({
    \ 's': { 'separator': [{'d':';'}, {'d':','}, {'d':'.'}, {'d':':'}, {'d':'+'}, {'d':'-'},
    \                      {'d':'='}, {'d':'~'}, {'d':'_'}, {'d':'*'}, {'d':'#'}, {'d':'/'},
    \                      {'d':'\'}, {'d':'|'}, {'d':'&'}, {'d':'$'}] },
    \ 'a': {},
    \ })

let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa'

" sideways vim
nmap <silent> çi <Plug>SidewaysArgumentInsertBefore
nmap <silent> ça <Plug>SidewaysArgumentAppendAfter
nmap <silent> çI <Plug>SidewaysArgumentInsertFirst
nmap <silent> çA <Plug>SidewaysArgumentAppendLast

omap <silent> aa <Plug>SidewaysArgumentTextobjA
xmap <silent> aa <Plug>SidewaysArgumentTextobjA
omap <silent> ia <Plug>SidewaysArgumentTextobjI
xmap <silent> ia <Plug>SidewaysArgumentTextobjI

autocmd vimEnter * silent! iunmap ça
autocmd vimEnter * silent! iunmap çi

nnoremap <silent> <M-9> :SidewaysJumpLeft<cr>
nnoremap <silent> <M-0> :SidewaysJumpRight<cr>

" clecer f
let g:clever_f_highlight_timeout_ms = 650
let g:clever_f_ignore_case = 1

" Traces
highlight link TracesReplace Substitute
highlight link TracesSearch Substitute

" NERDCommenter
let g:NERDSpaceDelims = 1


" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_exclude_filetypes = ['help', 'NvimTree', 'startify', 'Outline', 'WhichKey', 'which_key']
autocmd BufEnter * highlight IndentGuidesOdd  guibg=#2C2F45 ctermbg=3
autocmd BufEnter * highlight IndentGuidesEven guibg=#282c40 ctermbg=4

" Vim rooter
let g:rooter_patterns = ['=src', '=nvim']
let g:rooter_silent_chdir = 1

"vim hexokinase color preview
let g:Hexokinase_highlighters = ['backgroundfull']

" surround
let g:surround_{char2nr('o')} = "**\r**"
let g:surround_{char2nr('i')} = "*\r*"
let g:surround_{char2nr('=')} = "==\r=="
let g:surround_{char2nr('u')} = "~~\r~~"

" vim markdown
let g:vim_markdown_strikethrough = 1


"markdown preview
let g:md_pdf_viewer="zathura"
let g:md_args = '-V fontfamily="charter"'
let g:vim_markdown_math = 1
" let g:vim_markdown_conceal = 0

let vim_markdown_preview_github=1
let g:mkdp_markdown_css = '~/Downloads/style.css'

" vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

set conceallevel=2
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none

" NvimTree
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_respect_buf_cwd = 1
highlight NvimTreeExecFile guifg=#93ce6a


" Diff highlights and style

highlight DiffAdd ctermbg=4 guifg=#709943 guibg=transparent
highlight DiffChange ctermbg=5 guifg=#3e5380 guibg=transparent
highlight DiffDelete ctermbg=12 guifg=#803d49 guibg=transparent

let g:signify_sign_add               = '▎'
let g:signify_sign_delete            = '▎'
let g:signify_sign_delete_first_line = '▎'
let g:signify_sign_change            = '▎'
let g:signify_priority=1





