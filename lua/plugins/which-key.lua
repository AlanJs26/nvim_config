return {
  'folke/which-key.nvim',
  module = 'which-key',
  keys = '<space>',
  config = function()
    local wk = require('which-key')

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

    vim.cmd([[
      highlight default link WhichKey          Operator
      highlight default link WhichKeySeperator DiffAdded
      highlight default link WhichKeyGroup     Identifier
      highlight default link WhichKeyDesc      Function

      function! ExitQuestion(command)
          redraw!
          let choice = confirm("Are you sure you want exit?", "&Yes\n&No", 2)

          if choice == 1
            exec a:command
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

    vim.g.scratchfolder = vim.fn.stdpath("data") .. "/scratch/"
    local auto_session_save_count = 0

    wk.register({
      c = {nil, 'comment'},
      }, {prefix = "<leader>", nowait = true, mode='v' })

      wk.register({
      i = { ':noh<cr>',                    'remove highlights'},
      q = { function()
        local current_buf = vim.api.nvim_get_current_buf()
        local modified_buffers = 0
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if buf ~= current_buf and vim.api.nvim_buf_get_option(buf, 'modified') then
            modified_buffers = modified_buffers+1
          end
        end

        
        if modified_buffers > 0 then
          local utils = require('user_libs.utils')

          utils.confirmPopup('Do you really want to exit?', 'wqa', nil)
        else
          vim.cmd('wqa')
        end
      end,                    'quit save all'},
      n = { ':NvimTreeFindFileToggle<cr>', 'file tree' },
      S = { ':Alpha<cr>',                  'start screen' },
      w = { function()
        auto_session_save_count = auto_session_save_count+1 
        if auto_session_save_count >= 3 then
          vim.cmd('SaveSession')
          auto_session_save_count = 0 
        end
        vim.cmd('w')
      end,                      'write'},
      d = { ':Kwbd<cr>',                   'delete buffer'},
      a = { ':wa<cr>',                     'write all'},
      p = { ':Telescope<cr>',              'Telescope'},
      g = { ':Telescope live_grep<cr>',    'live grep'},
      f = { ':Telescope find_files<cr>',   'find file'},
      b = { ':Telescope buffers<cr>',      'buffers'},


      r = {name = '+open recent',
        r = {":Telescope zoxide list<cr>",     'recent folders'},
        f = {":Telescope oldfiles<cr>",        'recent files'},
      },

      l = {
        name='+lsp',
        d= {':Lspsaga peek_definition<cr>',       'preview definition'},
        s= {':lua vim.lsp.buf.signature_help()<cr>', 'signature help'},
        t= {':Telescope lsp_document_symbols<cr>',   'telescope symbols'},
        r= {':Lspsaga rename<cr>',                   'rename'},
        k= {':PickColor<cr>',                        'Color Picker'},
        c= {':Lspsaga code_action<cr>',              'code action'},
        p= {':Lspsaga diagnostic_jump_prev<cr>',     'previous diagnostic'},
        n= {':Lspsaga diagnostic_jump_next<cr>',     'next diagnostic'},
        f= {':lua vim.lsp.buf.format{async = true}<cr>',     'formatting'},
        w= {':cd %:p:h|pwd<cr>',                     'use current buffer as working dir'},
        m= {':Lspsaga outline<cr>',                  'symbols'},
        l= {':Lspsaga show_line_diagnostics<cr>',    'show diagnostics'},
        -- l= {':lua vim.diagnostic.open_float()<cr>',    'show diagnostics'},
        -- a= {':lua vim.lsp.buf.add_workspace_folder()<cr>',                       'add wosksp folder'},
        -- A= {':lua vim.lsp.buf.remove_workspace_folder()<cr>',                    'remove worksp folder'},
        -- w= {':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', 'list workspaces'},
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
      n= {':lua floatwin("SSave {{value}}", "New Session")<cr>',                                       'save session'},
      c= {':exec "silent! SaveSession"|let g:auto_session_enabled = v:false|bufdo bwipeout|Alpha<cr>', 'close session'},
      s= {':Telescope session-lens search_session<cr>',                                                'switch session'},
      f= {':SaveSession<cr>',                                                                          'quick save session'},
      r= {':RestoreSession<cr>',                                                                       'restore previous session'},
      p= {':Telescope projects projects<cr>',                                                          'switch project'},
    },

    t = {
      name='+window toggle',
      z= {':ZenMode<cr>',                                                          'zen mode'},
      m= {':wincmd ||wincmd _<cr>',                                                'maximize window'},
      n= {':wincmd =<cr>',                                                         'normalize windows'},
      t= {':call v:lua.searchTerminal(v:true,v:true)<cr>',                         'vertical terminal'},
      T= {':exe "sp|term"|exe "SendHere"|set nonumber|norm i<cr>',                 'horizontal terminal'},

      l= {function()
            local qf_exists = false
            for _, win in pairs(vim.fn.getwininfo()) do
              if win["quickfix"] == 1 then
                qf_exists = true
                break
              end
            end
            if qf_exists == true then
              vim.cmd("cclose")
            elseif not vim.tbl_isempty(vim.fn.getqflist()) then
              vim.cmd("copen")
            end
          end,                                                           'quickfix'},

      v= {':vsplit<cr>',                                                           'vertical split'},
      h= {':split<cr>',                                                            'horizontal split'},

      s= {':set scrollbind!<cr>',                                                   'scrollbind'},
      },

      j = {
      name='+toggle',

      b= {':ScrollbarToggle<cr>',                                                  'scrollbar'},
      l= {':call CicleNumberMode()<cr>',                                           'line numbers'},
      L= {':set nonumber norelativenumber|let b:currentNumberMode = 0<cr>',        'hide line numbers'},
      i= {':IndentBlanklineToggle<cr>',                                            'toggle indent guides'},
      w= {':call ToggleWrap(-1)<cr>',                                              'toggle word wrap'},
      s= {':set spell!<cr>',                                                       'spell'},
      S= {':if &laststatus == 0|set laststatus=2|else|set laststatus=0|endif<cr>', 'statusline'},
      g= {':Git<cr>',                                                              'Git' },
      h= {':IlluminateToggle<cr>',                                                            'word highlight'},

      -- m = {":MundoToggle<cr>",     'undo history'},
      m = {":UndotreeToggle<cr>",     'undo history'},

      f = {
        name='+fun',
        r = {':CellularAutomaton make_it_rain<cr>', 'rain'},
        g = {':CellularAutomaton game_of_life<cr>', 'game of life'},
      }
    }
  }, {prefix = "<leader>", nowait = true })

  if vim.fn.has('win32') == 0 then
    wk.register({
        t = {
          p = {':suspend<cr>', 'suspend'}
        }
      }, {prefix = "<leader>", nowait=true, mode= 'n'})
  end

  if vim.fn.getcwd():gsub('\\', '/') == "G:/Users/Alan/Documents/_Codes" then
    wk.register({
        q = { ':call ExitQuestion("wqa")<cr>', 'quit save all'},
      }, {prefix = "<leader>", nowait=true, mode= 'n'})
  end

end }
