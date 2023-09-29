" vim visual multi
let g:VM_leader = 'ç'
let g:VM_maps = {}
let g:VM_mouse_mappings = 1
" let g:VM_maps["select all words in the file"] = 'ça' 


" vim mundo
" nnoremap <silent> çj :MundoToggle<CR>

" fix cursor hold
let g:cursorhold_updatetime = 600

" Crunch math eval
nnoremap <silent>gn i<C-r>=<C-r>+<CR><ESC>
vnoremap <silent>gn di<C-r>=<C-r>+<CR><ESC>
" nmap <silent>gn <plug>(crunch-operator-line)
" xnoremap <silent>gn <plug>(visual-crunch-operator)


" vim targets
" autocmd User targets#mappings#user call targets#mappings#extend({
"     \ 's': { 'separator': [{'d':';'}, {'d':','}, {'d':'.'}, {'d':':'}, {'d':'+'}, {'d':'-'},
"     \                      {'d':'='}, {'d':'~'}, {'d':'_'}, {'d':'*'}, {'d':'#'}, {'d':'/'},
"     \                      {'d':'\'}, {'d':'|'}, {'d':'&'}, {'d':'$'}] },
"     \ 'a': {},
"     \ })
"
" let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr lb ar ab rr rb bb ll al aa'

