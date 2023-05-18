" bullet journal syntax file

if exists("b:current_syntax")
  finish
endif


"---- syntax ----"

"syn match bujoNote  '^\s*-\s.*$'
syn match bujoINote '^\s*!-\s.*$'
"syn match bujoUNote '^\s*?-\s.*$'

syn match bujoTodo  '^\s*\.\s.*$'
syn match bujoITodo '^\s*!\.\s.*$'
syn match bujoUTodo '^\s*?\.\s.*$'

syn match bujoDone  '^\s*x\s.*$'
syn match bujoIDone '^\s*!x\s.*$'
syn match bujoUDone '^\s*?x\s.*$'

syn match bujoApEv  '^\s*o\s.*$'
syn match bujoIApEv '^\s*!o\s.*$'
syn match bujoUApEv '^\s*?o\s.*$'

syn match bujoSched '^\s*\(M\|T\|W\|F\|S\)\s*[0-9]\+'

syn match bujoTitleOld '^#.*$'
syn match bujoTitleNew '^-.*$'

syn match bujoCalHead '^\s*Mo.*Su$'
syn match bujoCalBody '^\s*\d\+\(\s\+\d\+\)*$'

syn match bujoTag '#\S\+' containedin=bujoINote,bujoTodo,bujoITodo,bujoUTodo,bujoDone,bujoIDone,bujoUDone,bujoApEv,bujoIApEv,bujoUApEv


"---- highlight groups ----"

"
hi default bujo_inote term=bold cterm=bold gui=bold
"

hi default bujo_todo  ctermfg=14
hi default bujo_itodo ctermfg=14 term=bold cterm=bold gui=bold
hi default bujo_utodo ctermfg=14

hi default bujo_done  ctermfg=6
hi default bujo_idone ctermfg=6
hi default bujo_udone ctermfg=6

hi default bujo_apev  ctermfg=13
hi default bujo_iapev ctermfg=13 term=bold cterm=bold gui=bold
hi default bujo_uapev ctermfg=13

hi default bujo_title ctermfg=10

hi default bujo_tag ctermfg=11

"---- syntax/group linking ----"

"hi def link bujoNote Conditional
hi def link bujoINote bujo_inote
"hi def link bujoINote Conditional

hi def link bujoTodo  bujo_todo
hi def link bujoITodo bujo_itodo
hi def link bujoUTodo bujo_utodo

hi def link bujoDone  bujo_done
hi def link bujoIDone bujo_idone
hi def link bujoUDone bujo_udone

hi def link bujoApEv  bujo_apev
hi def link bujoIApEv bujo_iapev
hi def link bujoUApEv bujo_uapev


hi def link bujoTitleOld bujo_title
hi def link bujoTitleNew bujo_title

hi def link bujoCalHead bujo_iapev
hi def link bujoCalBody bujo_apev

hi def link bujoSched bujo_apev

hi def link bujoTag bujo_tag

