if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syn keyword arTodo contained TODO FIXME NOTE LANG
syn keyword arKeyword from load
syn keyword rustKeyword use nextgroup=rustModPath skipwhite skipempty
syn keyword arKeyword external return
syn keyword arKeyword if elif else
syn keyword arKeyword for while repeat in
syn keyword arKeyword break continue
syn keyword arKeyword to by
syn keyword arKeyword or and not
syn keyword arKeyword OR AND NOT
syn keyword arTypes fn num str bool opt list type
syn keyword arIdentifier Some None
syn keyword arStorage mut const static attach

" builtin functions
syn keyword arFunction unwrap unwrap_or
syn keyword arFunction recurse
syn keyword arFunction map reduce filter partial
syn keyword arFunction direct
syn keyword arFunction cast

" number literal types
syn match arDecNumber display "\<[0-9][0-9_]*"
syn match arHexNumber display "\<0x[a-fA-F0-9_]\+"
syn match arOctNumber display "\<0o[0-7_]\+"
syn match arBinNumber display "\<0b[01_]\+"

" preprocess items
syn match arPreprocess "@hint(.*)"

syn keyword arBoolean true false

syn match arComment "#.*$" contains=arTodo
syn region arFold start="{" end="}" transparent fold

syn region arString start='"' end='"'

hi def link arTodo Todo
hi def link arComment Comment
hi def link arString String
hi def link arBoolean Boolean

hi def link arDecNumber arNumber
hi def link arHexNumber arNumber
hi def link arOctNumber arNumber
hi def link arBinNumber arNumber
hi def link arNumber Number

hi def link arPreprocess PreProc

hi def link arIdentifier Identifier

hi def link arFunction Function

hi def link arStorage StorageClass

hi def link arKeyword Statement
hi def link arTypes Type

let b:current_syntax = "architect"
