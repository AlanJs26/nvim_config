function neozoom_wk()
  local wk = require('which-key')
  wk.register({
    t = {
      o = {':NeoZoomToggle<cr>', 'NeoZoom'},
    }
  }, {prefix = "<leader>", nowait = true })
end

function sessions_wk()
  local wk = require('which-key')
    
  wk.register({ 
    s = {
      name='+sessions',
      n= {':lua floatwin("SessionSave {{value}}", "New Session")<cr>',                                       'save session'},
      c= {':exec "silent! SessionSave"|let g:auto_session_enabled = v:false|bufdo bwipeout|Alpha<cr>', 'close session'},
      s= {':Telescope session-lens search_session<cr>',                                                'switch session'},
      f= {':SessionSave<cr>',                                                                          'quick save session'},
      r= {':SessionRestore<cr>',                                                                       'restore previous session'},
      -- p= {':Telescope projects projects<cr>',                                                          'switch project'},
      d= {
        function() 
          confirmPopup("Do you really want to delete the session?", function()
            vim.cmd('silent! SessionDelete')
            require('notify')("Deleted Session")
          end)
        end,
        'delete session',
      }
    },
  }, {
    prefix = "<leader>",
    nowait = true,
    mode='n',
  })
end

return {
  'folke/which-key.nvim',
  module = 'which-key',
  commit = '0539da005b98b02cf730c1d9da82b8e8edb1c2d2',
  keys = '<space>',
  dependencies = {
    'ten3roberts/qf.nvim',
    'rmagatti/auto-session',
    'nyngwang/NeoZoom.lua',
  },
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


    ]])

    vim.g.scratchfolder = vim.fn.stdpath("data") .. "/scratch/"
    local auto_session_save_count = 0

    wk.register({ c = {nil, 'comment'}, }, {prefix = "<leader>", nowait = true, mode='v' })

    wk.register({
      q = {
        function()
            local current_buf = vim.api.nvim_get_current_buf()
            local modified_buffers = 0
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if buf ~= current_buf and vim.api.nvim_buf_get_option(buf, 'modified') then
                modified_buffers = modified_buffers+1
              end
            end

            local utils = require('user_libs.utils')

            local terminals = require('toggleterm.terminal').get_all(true)

            if modified_buffers > 0 then
              utils.confirmPopup('There are unsaved buffers. Do you really want to exit?', 'wqa', nil)
            elseif #terminals > 0 then
              utils.confirmPopup('There are '..#terminals..' active terminals. Do you really want to exit?', function()
                for _,term in ipairs(terminals) do
                  term:shutdown()
                end
                vim.cmd('wqa')
              end, nil)
            else
              vim.cmd('wqa')
            end
        end,                                                  'quit save all'},
      i = { ':noh|exec "normal \\<Plug>(ExchangeClear)"<cr>', 'remove highlights'},
      n = { ':NvimTreeFindFileToggle<cr>',                    'file tree' },
      S = { ':Alpha<cr>',                                     'start screen' },
      w = { function()
        local status = require('user.git_status').status

        if status.is_git_dir == true then
          auto_session_save_count = auto_session_save_count+1
          if auto_session_save_count >= 3 then
            vim.cmd(':silent! SessionSave')
            auto_session_save_count = 0
          end
        end
        vim.cmd(':silent w')
        end,                      'write'},
      d = { ':Kwbd<cr>',                   'delete buffer'},
      a = { ':wa<cr>',                     'write all'},
      p = { ':Telescope<cr>',              'Telescope'},
      g = { ':Telescope live_grep<cr>',    'live grep'},
      f = { ':Telescope find_files<cr>',   'find file'},
      b = { ':Telescope buffers<cr>',      'buffers'},
      ['<Tab>'] = { ':Telescope telescope-tabs list_tabs<cr>',      'tabs'},


      r = {name = '+open recent',
        r = {":Telescope zoxide list<cr>",     'recent folders'},
        f = {":Telescope oldfiles<cr>",        'recent files'},
      },

      l = {
        name='+misc',
        k= {':PickColor<cr>',                            'Color Picker'},
        w= {':cd %:p:h|pwd<cr>',                         'use current buffer as working dir'},
        L= {':Lazy<cr>',                                 'Lazy'},

        U = {":UndotreeToggle<cr>",     'undo history'},
        u = {":Telescope undo<cr>",     'undo telescope'},
      },

      c = {nil, 'comment'},

      o = {
        name='+scratch',
        s= {':exec "Telescope find_files cwd="..g:scratchfolder<cr>', 'browse scratch buffers'},
        g= {':exec "Telescope live_grep cwd="..g:scratchfolder<cr>', 'live grep scratch buffers'},
        n= {function()
          local date = os.date()
          if type(date) ~= 'string' then
            return
          end
          date = string.gsub(date, "/", "-"):gsub("[ :]", "_")
          if vim.o.filetype == "" then
            vim.cmd("w " .. vim.g.scratchfolder .. date .. ".txt")
          else
            vim.cmd("e " .. vim.g.scratchfolder .. date .. ".txt")
          end
          end, 'new scratch buffer'},
        o= {':let myfile = system("ls -t " .. g:scratchfolder.."|head -n 1")|exec "e ".. g:scratchfolder .. myfile<cr>', 'open last scratch buffer'},
      },


      t = {
        name='+window toggle',

        e= {':tab split<cr>',                                                          'edit in new tab'},

        z= {':ZenMode<cr>',                                                            'zen mode'},
        m= {':wincmd ||wincmd _<cr>',                                                  'maximize window'},
        n= {':wincmd =<cr>',                                                           'normalize windows'},
        t= {':ToggleTerm direction=vertical<cr>',                                      'vertical terminal'},
        T= {':ToggleTerm direction=horizontal<cr>',                                    'horizontal terminal'},


        v= {':vsplit<cr>',                                                           'vertical split'},
        h= {':split<cr>',                                                            'horizontal split'},

        s= {':set scrollbind!<cr>',                                                  'scrollbind'},
      },

      j = {
        name='+toggle',

        b= {':ScrollbarToggle<cr>',                                           'scrollbar'},
        l= {':call CicleNumberMode()<cr>',                                    'line numbers'},
        L= {':set nonumber norelativenumber|let b:currentNumberMode = 0<cr>', 'hide line numbers'},
        i= {':IBLToggle<cr>',                                                 'toggle indent guides'},
        w= {':call ToggleWrap(-1)<cr>',                                       'toggle word wrap'},
        s= {function() 
          if vim.o.spell == true then
            vim.o.spell = false
          else
            if vim.o.filetype == '' then
              vim.o.filetype = 'text'
            end
            vim.o.spell = true
            vim.o.spelllang = 'pt_br,en_us'
          end
        end,                                                       'spell'},
        S= {':if &laststatus == 0|set laststatus=2|else|set laststatus=0|endif<cr>', 'statusline'},
        g= {':Git<cr>',                                                              'Git' },
        h= {':IlluminateToggle<cr>',                                                 'word highlight'},

      }
}, {prefix = "<leader>", nowait = true })


  sessions_wk()
  neozoom_wk()

  if vim.fn.has('win32') == 0 then
    wk.register({
        t = {
          p = {':suspend<cr>', 'suspend'}
        }
      }, {prefix = "<leader>", nowait=true, mode= 'n'})
  end


end }
