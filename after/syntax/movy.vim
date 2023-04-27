" Vim syntax file
" Language: Movy
" Maintainer: Alan José

" if exists("b:current_syntax")
"   finish
" endif

syn match movycomment '^\s*#.*'
syn match blockname '^\s*\[\[.\+\]\]'
syn keyword movyboolean true false 

syn keyword operators echo trash set_defaults keywords move basename extension path file pdf_template hasproperty filecontent nextgroup=separator skipwhite
syn keyword modes pass and or not reset nextgroup=expression_operators,operators skipwhite contained

:syntax include @PY syntax/python.vim
syn keyword expression_operators if nextgroup=separator_expressions skipwhite
syn match separator_expressions '->\|:' contained nextgroup=expression_line skipwhite extend
syn match expression_line '.*' contained contains=@PY

syn match beforecolon '^\s*[^#]\{-\}\(:\|->\)' contains=movygroups,operators,expression_operators,modes,invalid keepend
syn match invalid '.\+' contained


syn match movynumber '\(\s\|:\)\@<=\([0-9\.]\)\+\(\s\|\n\)\@=' contained

syn match separator '->\|:' contained nextgroup=argumentsregion,movycontent extend skipwhite

syn match movygroups '(.\{-\})' nextgroup=operators,expression_operators contained skipwhite
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

hi link operators        @text
hi link modes        Operator
hi link movygroups        @include
hi link blockname        Number
hi link separator @character.special

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
