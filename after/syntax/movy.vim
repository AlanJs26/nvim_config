" Vim syntax file
" Language: Movy
" Maintainer: Alan José

" if exists("b:current_syntax")
"   finish
" endif

syn match movycomment '^\s*#.*'
syn match blockname '^\s*\[\[.\+\]\]'
syn keyword movyboolean true false 

syn keyword rule_commands keywords basename extension path file pdf_template hasproperty filecontent nextgroup=rule_separator skipwhite
syn keyword action_commands prompt terminal echo trash set_defaults move nextgroup=action_separator skipwhite

syn keyword rule_modes pass and or not reset nextgroup=expression_operators,rule_commands skipwhite contained
syn keyword action_modes all reset nextgroup=action_commands skipwhite contained

:syntax include @PY syntax/python.vim
syn keyword expression_operators if nextgroup=separator_expressions skipwhite
syn match separator_expressions '->\|:' contained nextgroup=expression_line skipwhite extend
syn match expression_line '.*' contained contains=@PY

syn match beforecolon '^\s*[^#]\{-\}\(:\|->\)' contains=movygroups,rule_commands,expression_operators,action_modes,rule_modes,invalid keepend
syn match invalid '.\+' contained


syn match movynumber '\(\s\|:\)\@<=\([0-9\.]\)\+\(\s\|\n\)\@=' contained

syn match rule_separator ':' contained nextgroup=argumentsregion,movycontent extend skipwhite
syn match action_separator '->' contained nextgroup=argumentsregion,movycontent extend skipwhite

syn match movygroups '(.\{-\})' nextgroup=rule_commands,expression_operators contained skipwhite
syn match movycontent '.*[^{]' contained contains=expression,movyregexp nextgroup=argumentsregion

syn match movyregexp '\([^ ]\)\@<!/.\{-\}[^\\]/[a-z]*' contained

syn match expression '{.\{-\}}' contained contains=@PY



" ARGUMENT =========

syn match argumentfield '^\s*[^#]\{-\}:' contained nextgroup=argumentvalue
syn match argumentvalue '.*' contained contains=movyboolean,movynumber

syn region argumentsregion start="\s*{\s*\n" end="}\s*\n" skip='}\([^\n ]\)\@>' contains=movycomment,argumentfield


" YAML ==========

syn match yamlfield '^\s*[^#]\{-\}:' contained nextgroup=yamlvalue
syn match yamlvalue '.*' contained contains=movyboolean,movynumber

syn region yamlregion start="---" end="---" fold transparent contains=yamlfield,movycomment


" HIGHLIGHTING ==========

hi link rule_commands        @text
hi link action_commands        @text

hi link rule_modes        Operator
hi link action_modes        Operator

hi link movygroups        @include
hi link blockname        Number

hi link rule_separator @character.special
hi link action_separator @character.special

hi link separator_expressions @character.special
hi link expression_operators        @text

hi link movyregexp @regexp
hi link movynumber Number
hi link movyboolean @boolean

hi link movycomment        Comment
hi link movycontent        String

hi link yamlvalue String
hi link yamlfield @field

hi link argumentvalue String
hi link argumentfield @field

hi link invalid NvimInvalid


" hi link argumentsregion Number


let b:current_syntax = "movy"
