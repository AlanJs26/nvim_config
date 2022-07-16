local wk = require('which-key')
local tm = require('taskmanager')

wk.setup {
  triggers = {'<space>'},
  icons = {
    separator = '→'
  },
  presets = {
    operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
    motions = false, -- adds help for motions
    text_objects = false, -- help for text objects triggered after entering an operator
    windows = false, -- default bindings on <c-w>
    nav = false, -- misc bindings to work with windows
    z = false, -- bindings for folds, spelling and others prefixed with z
    g = false, -- bindings for prefixed with g
  },
}

vim.g.which_key_use_floating_win = 1

vim.cmd([[
  highlight default link WhichKey          Operator
  highlight default link WhichKeySeperator DiffAdded
  highlight default link WhichKeyGroup     Identifier
  highlight default link WhichKeyDesc      Function

  function! ExitQuestion()
      redraw!
      let choice = confirm("Are you sure you want exit?", "&Yes\n&No", 2)

      if choice == 1
          qa!
      endif
  endfunction


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

  augroup markdown
    autocmd!
    autocmd FileType markdown call MarkdownMappings() 
    autocmd FileType markdown call ToggleWrap(1)
    autocmd CursorHold * if &filetype == "markdown" | update | endif
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
]])

vim.g.scratchfolder = "C:/Users/alanj/AppData/Local/nvim-data/scratch/"

wk.register({
    -- y = {":'<,'>YodeCreateSeditorFloating<cr>", 'create float with paragraph'}, 
    c = {nil, 'comment'},
    --r = {name = 'better replace'},
}, {prefix = "<leader>", nowait = true, mode='v' })

wk.register({
-- Q = { ':lua confirmPopup("Are you sure you want exit?", "qa!", "")<cr>',                  'force quit'},
i = { ':noh<cr>',                  'remove highlights'},
Q = { ':call ExitQuestion()<cr>',  'force quit'},
q = { ':wqa<cr>',                  'quit save all'},
n = { ':NvimTreeToggle<cr>',       'file tree' },
S = { ':Alpha<cr>',             'start screen' },
w = { ':w<cr>',                    'write'},
d = { ':Kwbd<cr>',                 'delete buffer'},
a = { ':wa<cr>',                   'write all'},
p = { ':Telescope<cr>',            'Telescope'},
g = { ':Telescope live_grep<cr>',  'live grep'},
f = { ':Telescope find_files<cr>', 'find file'},
b = {":Telescope buffers<cr>",     'buffers'},

-- y = {"vip:'<,'>YodeCreateSeditorFloating<cr>", 'create float with paragraph'},
-- h = {":lua require('spectre').open()<cr>i",     'find and replace'},

r = {name = '+open recent',
  r = {":Telescope zoxide list<cr>",     'recent folders'},
  f = {":Telescope oldfiles<cr>",        'recent files'},
},

l = {
 name='+lsp',
 d= {':Lspsaga preview_definition<cr>',       'preview definition'},
--  h={':lua vim.lsp.buf.hover()<cr>',                                      'hover'},
 h= {':Lspsaga hover_doc<cr>',                'hover'},
 D= {':lua vim.lsp.buf.definition()<cr>',     'definition'},
 i= {':lua vim.lsp.buf.implementation()<cr>', 'implementation'},
 s= {':lua vim.lsp.buf.signature_help()<cr>', 'signature help'},
-- a= {':lua vim.lsp.buf.add_workspace_folder()<cr>',                       'add wosksp folder'},
-- A= {':lua vim.lsp.buf.remove_workspace_folder()<cr>',                    'remove worksp folder'},
-- w= {':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', 'list workspaces'},
--  t= {':lua vim.lsp.buf.type_definition()<cr>',                           'type definition'},
 t= {':Telescope lsp_document_symbols<cr>',   'telescope symbols'},
 r= {':Lspsaga rename<cr>',                   'rename'},
-- c={':lua vim.lsp.buf.code_action()<cr>',                                 'code action'},
 c= {':Lspsaga code_action<cr>',              'code action'},
 o= {':Lspsaga open_floaterm<cr>',            'float terminal'},
 R= {':lua vim.lsp.buf.references()<cr>',     'references'},
 l= {':Lspsaga show_line_diagnostics<cr>',    'show diagnostics'},
-- l={'<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>',               'show diagnostics'},
 p= {':Lspsaga diagnostic_jump_prev<cr>',     'previous diagnostic'},
 n= {':Lspsaga diagnostic_jump_next<cr>',     'next diagnostic'},
-- p={'<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>',                           'previous diagnostic'},
-- n={'<cmd>lua vim.lsp.diagnostic.goto_next()<cr>',                           'next diagnostic'},
 f= {':lua vim.lsp.buf.formatting()<cr>',     'formatting'},
 w= {':cd %:p:h|pwd<cr>',                     'use current buffer as working dir'},
 m= {':SymbolsOutline<cr>',                   'symbols'}
 },

c = {nil, 'comment'},

o = {
 name='+scratch',
 s= {':exec "Telescope find_files cwd="..g:scratchfolder<cr>', 'browse scratch buffers'},
 g= {':exec "Telescope live_grep cwd="..g:scratchfolder<cr>', 'live grep scratch buffers'},
 n= {function()
    local date = os.date()
    date = string.gsub(date, "/", "-"):gsub("[ :]", "_")
    if vim.o.filetype == "" then
        vim.cmd("w " .. vim.g.scratchfolder .. date .. ".txt")
    else
        vim.cmd("e " .. vim.g.scratchfolder .. date .. ".txt")
    end
 end, 'new scratch buffer'},
 o= {':let myfile = system("ls -t " .. g:scratchfolder.."|head -n 1")|exec "e ".. g:scratchfolder .. myfile<cr>', 'open last scratch buffer'},
},

s = {
 name='+sessions',
 n= {':lua floatwin("SSave {{value}}", "New Session")<cr>', 'save session'},
 c= {':exec "silent! SaveSession"|let g:auto_session_enabled = v:false|bufdo bwipeout|Alpha<cr>',                                         'close session'},
 s= {':Telescope session-lens search_session<cr>',          'switch session'},
 f= {':SaveSession<cr>',                                    'quick save session'},
 r= {':RestoreSession<cr>',                                 'restore previous session'},
},

t = {
 name='+toggle',
 z= {':ZenMode<cr>',                                                          'zen mode'},
 l= {':call CicleNumberMode()<cr>',                                           'line numbers'},
 L= {':set nonumber norelativenumber|let b:currentNumberMode = 0<cr>',        'hide line numbers'},
 i= {':IndentGuidesToggle<cr>',                                               'toggle indent guides'},
 w= {':call ToggleWrap(-1)<cr>',                                              'toggle word wrap'},
 m= {':wincmd ||wincmd _<cr>',                                                'maximize window'},
 n= {':wincmd =<cr>',                                                         'normalize windows'},
 s= {':set spell!<cr>',                                                       'spell'},
 S= {':if &laststatus == 0|set laststatus=2|else|set laststatus=0|endif<cr>', 'statusline'},
 p= {':suspend<cr>',                                                          'suspend'},
 t= {':exe "vsp|term"|exe "SendHere"|norm i<cr>',                             'vertical terminal'},
 T= {':exe "sp|term"|exe "SendHere"|norm i<cr>',                              'horizontal terminal'},

 v= {':vsplit<cr>',                                                           'vertical split'},
 h= {':split<cr>',                                                            'horizontal split'}
 },
}, {prefix = "<leader>", nowait = true })

if vim.v.argv[#vim.v.argv] == 'echo "noquit"' then
  wk.register({
    q = { ':wa|echo "Saved"<cr>',                   'write all'},
    a = "which_key_ignore",

  }, {prefix = "<leader>", nowait=true, mode= 'n'})
end


TaskManager({
c = {
    -- {"w | sp | term gcc '{{p}}' -o {{t:r}} -Wall -ansi -pedantic -O2 -lm&&./{{t:r}}", 'Compile and run'},
    {"w | sp | term gcc \"{{p}}\" -o {{t:r}} -Wall -ansi -pedantic -O2 -lm && \"{{t:r}}.exe\"", 'Compile and run'},
    -- {"w | sp | term gcc \"{{p}}\" -o {{t:r}} -Wall -ansi -pedantic -O2",            'Compile'},
},
cpp = {
    {":w | sp | term g++ '{{p}}' -o {{t:r}}&&./{{t:r}}", 'Compile and run'},
},
python = {
    {":w | sp | term python3 \"{{p}}\"", 'run'},
},
vim = {
    {"source %", 'source current file'},
},
rust = {
    {"w | sp | term cargo run", 'Compile and run'},
},
ps1 = {
    {"w | sp | term powershell.exe -Command \"& '{{p}}'\"", 'Run script'},
},
sh = {
    {"w | sp | term {{p}}", 'Run script'},
},
arduino = {
    {'!killall screen; /home/alan/miniconda3/bin/python /home/alan/Documentos/tools/single-kitty-keys.py arduino "clear -x;echo "compiling..."; arduino-cli compile . && arduino-cli upload -p {{g:arduino_serial_port}} &&screen {{g:arduino_serial_port}}  {{g:arduino_serial_baud}} \r"&', 'Compile and Upload'},
    {'!killall screen; /home/alan/miniconda3/bin/python /home/alan/Documentos/tools/single-kitty-keys.py arduino "screen {{g:arduino_serial_port}}  {{g:arduino_serial_baud}} \r"&', 'Serial Monitor'},
},
})

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
RegisterWKByFiletype({
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

            -- h= {'iheader<TAB>',                       'add Header'},
            n= {':lua create_file("iheader<TAB>", ".", "md")<cr>', 'Create new note'},
        }
    },
    c = {
        m = {
            name='+clang',
            n= {':lua create_file("istart<TAB>", "../:file:", "c")<cr>', 'new c project'},
        }
    },
}, 'n')

