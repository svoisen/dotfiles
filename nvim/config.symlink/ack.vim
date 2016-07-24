" Use Silver Searcher if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'

  " Use ag if available instead of grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

nnoremap <C-f> :Ack!<SPACE>
