" unlet! b:current_syntax
" let b:current_syntax = 'lua'
syn include @Vim syntax/vim.vim
syn region embedvim start="(\[\[" end="\]\])" contains=@Vim
