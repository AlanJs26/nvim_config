RegisterWKByFiletype({
    c = {
        m = {
            name='+clang',
            n= {':lua create_file("istart<TAB>", "../:file:", "c")<cr>', 'new c project'},
        }
    },
    dart = {
        l = {
            m = {':FlutterOutlineToggle<cr>', 'symbols' }
        }
    },
    markdown = {
        m = {
            name='+markdown',
            b= {'ysiwo<cr>',                            'bold'},
            i= {'ysiwi<cr>',                            'italic'},
            s= {'ysiwu<cr>',                            'strikethrough'},
            e= {'ysiw=<cr>',                            'emphasis'},

            c= {':lua floatwin(\'.!inkscape-figures create "{{value}}" "../Files/"\', "figure name")<cr>',                           'create figure'},
            a= {':.!a=$(ls ../Files/*.svg|xargs -i basename {}|sed \'s/\\.svg//\'|rofi -dmenu);echo "\\![$a](../Files/$a.svg)"<cr>', 'add figure'},
            g= {':!inkscape-figures edit ../Files/ > /dev/null 2>&1 &<CR><CR>:redraw!<CR>',                                          'edit figure'},

            n= {':lua create_file("iheader<TAB>", ".", "md")<cr>', 'Create new note'},
        }
    },
}, 'n')
RegisterWKByFiletype({
    markdown = {
        m = {
            name='+markdown',
            b= {"So<cr>",                       'bold'},
            i= {"Si<cr>",                       'italic'},
            s= {"Su<cr>",                       'strikethrough'},
            e= {"S=<cr>",                       'emphasis'},
        }
    },
}, 'v')

vim.cmd([[
  augroup markdown
    autocmd!
    autocmd FileType markdown call MarkdownMappings() 
    autocmd FileType markdown call ToggleWrap(1)
    " autocmd CursorHold * if &filetype == "markdown" | update | endif
  augroup END

  function! MarkdownMappings()
      nmap mb ysiwo
      nmap mi ysiwi
      nmap ms ysiwu
      nmap me ysiw=

      xmap mb So
      xmap mi Si
      xmap ms Su
      xmap me S=
  endfunction
]])
