" Vim syntax file
" Language: Movy
" Maintainer: Alan José

" if exists("b:current_syntax")
"   finish
" endif

syn match movycomment '^\s*#.\+'
syn match blockname '^\s*\[\[.\+\]\]'
syn keyword movyboolean true false 

syn keyword operators echo move basename extension path file pdf_template hasproperty filecontent nextgroup=separator skipwhite
syn keyword modes and or reset clear nextgroup=operators skipwhite contained

syn match beforecolon '^[^#].\{-\}\(:\|->\)' contains=movygroups,operators,modes,invalid keepend
syn match invalid '.\+' contained


syn match movynumber '\(\s\|:\)\@<=\([0-9\.]\)\+\(\s\|\n\)\@=' contained

syn match separator '->\|:' contained nextgroup=argumentsregion,movycontent extend skipwhite

syn match movygroups '(.\{-\})' nextgroup=operators contained skipwhite
syn match movycontent '.*[^{]' contained contains=expression,movyregexp nextgroup=argumentsregion

syn match movyregexp '\([^ ]\)\@<!/.\{-\}[^\\]/[a-z]*' contained

:syntax include @PY syntax/python.vim
syn match expression '{.\{-\}}' contained contains=@PY



" ARGUMENT =========

syn match argumentfield '^\s*[^#]\{-\}:' contained nextgroup=argumentvalue
syn match argumentvalue '.*' contained contains=movyboolean,movynumber

syn region argumentsregion start="\s*{\s*\n" end="}\s*\n" skip='}\([^\n ]\)\@>' contains=movycomment,argumentfield


" YAML ==========

syn match yamlvalue '.*' contained contains=movyboolean,movynumber
syn match yamlfield '.\+:' contained nextgroup=yamlvalue

syn region yamlregion start="---" end="---" fold transparent contains=yamlfield


" HIGHLIGHTING ==========

hi link operators        @text
hi link modes        Operator
hi link movygroups        @include
hi link blockname        Number
hi link separator @character.special

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
