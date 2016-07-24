" Use Silver Searcher if available
if executable('ag')
  " Use ag in CtrlP
  let g:ctrlp_user_command = 'ag %s -l --nocolor --nogroup --hidden -g ""'

  " no caching when using ag with CtrlP
  let g:ctrlp_use_caching = 0
endif

nnoremap ' :CtrlP<CR>
nnoremap ; :CtrlPBuffer<CR>
nnoremap <C-b> :CtrlPBuffer<CR>
let g:ctrlp_map = '<C-t>'
let g:ctrlp_by_filename = 1
let g:ctrlp_reuse_window = 'netrw'
let g:ctrlp_arg_map = 1
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn|idea|jpg|png|gif))$'
let g:ctrlp_max_files = 1000
let g:ctrlp_working_path_mode = 'r'
let g:netrw_liststyle = 3
