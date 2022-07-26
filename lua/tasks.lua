require('user_libs.utils')
local tm = require('user_libs.taskmanager')

local auid

auid = vim.api.nvim_create_autocmd(
    'BufRead',
    {
        pattern = '*',
        callback = function()
            local unalowedft = {'', 'alpha', 'TelescopePrompt', 'NvimTree'}
            for _, value in ipairs(unalowedft) do
                if vim.o.filetype == value then
                    return
                end
            end
            local wk = require('which-key')
            tm.setup()
            local sfmlpath = 'C:/SFML-2.4.2'
            tm.register({
                c = {
                    {'gcc "{{p}}" -o {{t:r}} -Wall -ansi -pedantic -O2 -lm && "{{t:r}}.exe"', 'Compile and run'},
                    {'gcc "{{p}}" -o {{t:r}} -Wall -ansi -pedantic -O2',                      'Compile'},
                },
                cpp = {
                    -- {"g++ '{{p}}' -o {{t:r}}&&./{{t:r}}", 'Compile and run'},
                    {"g++ -I"..sfmlpath.."/include -c {{t:p}} -o {{t:r}}.o && g++ {{t:r}}.o -o {{t:r}}.exe -L"..sfmlpath.."/lib -lsfml-graphics -lsfml-window -lsfml-system && {{t:r}}.exe", 'Compile and run SFML'},
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
            })

            wk.register({
            t = {
             name='+toggle',
             c = {
               name = 'config',
               t = {':lua openTasksMenu()<cr>', 'Enabled tasks'}
             }
             },
            }, {prefix = "<leader>", nowait = true })


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

            vim.api.nvim_del_autocmd(auid)
        end
    }
    )
