require('user_libs.utils')

function Setup_tasks(auid)
    local unalowedft = {'', 'alpha', 'TelescopePrompt', 'NvimTree'}
    for _, value in ipairs(unalowedft) do
        if vim.o.filetype == value then
            return
        end
    end
    local wk = require('which-key')
    tm.setup()
    local sfmlpath = 'C:/SFML-2.4.2'
    local tasks_config = {
        c = {
            {'gcc "{{p}}" -o {{t:r}} -Wall -ansi -pedantic -O2 -lm && "{{t:r}}.exe"', 'Compile and run'},
            {'gcc "{{p}}" -o {{t:r}} -Wall -ansi -pedantic -O2',                      'Compile'},
        },
        cpp = {
            {'g++ "{{p}}" -o {{t:r}}.exe&&{{t:r}}.exe', 'Compile and run'},
            -- {'g++ *.cpp -o {{t:r}}.exe&&{{t:r}}.exe', 'Compile all and run'},
            -- {"g++ -I"..sfmlpath.."/include -c {{t:p}} -o {{t:r}}.o && g++ {{t:r}}.o -o {{t:r}}.exe -L"..sfmlpath.."/lib -lsfml-graphics -lsfml-window -lsfml-system && {{t:r}}.exe", 'Compile and run SFML'},
        },
        python = {
            {'python3 "{{p}}"', 'run'},
        },
        vim = {
            {"source %", 'source current file', before = 'w', after = '', prefix = ''},
        },
        rust = {
            {"cargo run", 'Compile and run'},
        },
        ps1 = {
            {'powershell.exe -Command "& \'{{p}}\'"', 'Run script'},
        },
        sh = {
            {"{{p}}", 'Run script'},
        },
        arduino = {
            {'!killall screen; /home/alan/miniconda3/bin/python /home/alan/Documentos/tools/single-kitty-keys.py arduino "clear -x;echo "compiling..."; arduino-cli compile . && arduino-cli upload -p {{g:arduino_serial_port}} &&screen {{g:arduino_serial_port}}  {{g:arduino_serial_baud}} \r"&', 'Compile and Upload', before = '', after = '', prefix = ''},
            {'!killall screen; /home/alan/miniconda3/bin/python /home/alan/Documentos/tools/single-kitty-keys.py arduino "screen {{g:arduino_serial_port}}  {{g:arduino_serial_baud}} \r"&', 'Serial Monitor', before = '', after = '', prefix = ''},
        },
    }
    tm.register(tasks_config)

    local function resolve(path)
      return path:gsub('\\', '/'):gsub('/$', '')
    end
    local tasks_path = resolve(vim.fn.stdpath("config").."/lua/tasks.lua")

    for k,_ in pairs(tasks_config) do
      RegisterWKByFiletype({
          [k] = {
            j = {
              name='+toggle',
              c = {
                name = 'config',
                t = {':lua openTasksMenu()<cr>', 'Enabled tasks'},
                e = {function() vim.api.nvim_command("e "..tasks_path) end, 'Edit tasks'},
                r = {function() vim.api.nvim_command("source "..tasks_path) end, 'Reload tasks'}
              }
            },
          }
        }, 'n')

    end

    -- wk.register({
    -- j = {
    --  name='+toggle',
    --  c = {
    --    name = 'config',
    --    t = {':lua openTasksMenu()<cr>', 'Enabled tasks'},
    --    e = {':EditTasks<cr>', 'Edit tasks'},
    --    r = {':ReloadTasks<cr>', 'Reload tasks'}
    --  }
    --  },
    -- }, {prefix = "<leader>", nowait = true })


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
    if auid then
        vim.api.nvim_del_autocmd(auid)
    end

end

if pcall(function() local _ = tm.tasks end) then
    Setup_tasks()
else
    tm = require('user_libs.taskmanager')
end

local auid = nil

if auid == nil then
    auid = vim.api.nvim_create_autocmd(
        'BufRead',
        {
            pattern = '*',
            callback = function()
                Setup_tasks(auid)
            end
        }
        )
end

