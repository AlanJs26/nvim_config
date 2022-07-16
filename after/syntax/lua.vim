unlet b:current_syntax
syn include @Vim syntax/vim.vim
syn region embedvim matchgroup=vimEmbedError start="(\[\[" end="\]\])" contains=@Vim
" let b:current_syntax = 'lua'
