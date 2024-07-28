local sfmlpath = 'C:/SFML-2.4.2'
return {
    c = {
        {'gcc "{{p}}" -o "{{t:r}}" -Wall -ansi -pedantic -O2 -lm && "./{{t:r}}"', 'Compile and run'},
        {'gcc "{{p}}" -o "{{t:r}}" -Wall -ansi -pedantic -O2',                      'Compile'},
    },
    vhdl = {
        -- {'nvc -a *.vhd && nvc -e testbench_{{t:r}} && nvc -r testbench_{{t:r}}', 'Run Testbench'}
        {'just run', 'just run', before = 'w'}
    },
    cpp = {
        -- {'g++ "{{p}}" -o {{t:r}}.exe&&{{t:r}}.exe', 'Compile and run'},
        {'g++ "{{p}}" -o {{t:r}}&&./{{t:r}}', 'Compile and run'},
        -- {'g++ *.cpp -o {{t:r}}.exe&&{{t:r}}.exe', 'Compile all and run'},
        -- {"g++ -I"..sfmlpath.."/include -c {{t:p}} -o {{t:r}}.o && g++ {{t:r}}.o -o {{t:r}}.exe -L"..sfmlpath.."/lib -lsfml-graphics -lsfml-window -lsfml-system && {{t:r}}.exe", 'Compile and run SFML'},
    },
    javascript = {
        {'npm start', 'npm start'},
    },
    python = {
        {'python3 runner.py', 'run runner.py', float = true},
        {'python3 "{{p}}"', 'run file', float = true},
        -- {'python3 "/mnt/DiscoExterno/Users/Alan/Documents/_Codes/Python/Text Processing/movy/test.py"', 'run test', float = true},
        {'pytest', 'run pytest', float = true},
    },
    yuck = {
        {"silent !eww reload", 'reload config', before = 'w', after = '', prefix = ''},
    },
    vim = {
        {"source %", 'source current file', before = 'w', after = '', prefix = ''},
    },
    rust = {
        {"cargo run", 'Compile and run', before = 'w'},
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
