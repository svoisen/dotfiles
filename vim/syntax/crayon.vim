" Vim syntax file
" Language: Crayon
" Maintainer: Sean Voisen <sean@voisen.org>
" Last Change: Dec 14 2010

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
  let main_syntax = 'crayon'
endif

syn case ignore

syn match   crayonComment               "#.*$"
syn keyword crayonConditional           if else unless end
syn keyword crayonFunction              function uses
syn keyword crayonEvent                 do stop doing on
syn keyword crayonValue                 true false nothing
syn keyword crayonMath                  sin cos

if version >= 508 || !exists("did_crayon_syn_inits")
  if version < 508
    let did_actionscript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink crayonComment                  Comment
  HiLink crayonConditional              Conditional
  HiLink crayonFunction                 Function
  HiLink crayonEvent                    Function
  HiLink crayonValue                    Boolean

  delcommand HiLink
endif
 
let b:current_syntax = "crayon"
if main_syntax == 'crayon'
  unlet main_syntax
endif
