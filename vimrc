" Sean Voisen's vimrc
" Copyright (C) 2010 Sean Voisen
" Web: http://voisen.org
" Email: sean {at} voisen {dot} org

" turn on syntax highlighting and highlight search if the terminal has
" colors
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" colorscheme desert FTW!
if $TERM =~ "-256color" 
  set t_Co=256
  colorscheme desert256
else
  colorscheme desert
endif

" turn on file type support
filetype on

" also turn on filetype specific indenting
filetype plugin indent on

" change completion menu to always appear even with one result
set completeopt=longest,menuone

" use <ctrl> space for completion
" if omnicompletion is not available, use regular completion
"inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ? "\<lt>C-n>" : "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" . "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" . "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ? "\<C-n>" : "\<C-x>\<C-o>"
imap <C-@> <C-Space>

" make completion menu more IDE-like
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
inoremap <expr> <Tab>      pumvisible() ? "\<C-n>" : "\<Tab>"

" turn on line numbers
set number

" turn off old vi compatability
set nocompatible

" turn off line wrapping
set nowrap

" indentation options
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2

" turn off the damn bell
set vb

" enable the mouse
set mouse=a

" ignore case when searching
set ignorecase
set infercase

" if using uppercase in search, assume case sensitive
set smartcase

" search as you type
set incsearch

" auto change to directories whenever a window or buffer
" is switched
if exists("&autochdir")
  :set autochdir
endif

" set the statusline and always display it
set statusline=%<%f\ [%{&ff}]\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2

" show the mode all the time
set showmode

" tabbed buffer settings
set showtabline=2 " tabs always visible
map tn :tabnew<CR>
map td :tabclose<CR> 
map th :tabnext<CR>
map tl :tabprev<CR> 

" split window below instead of above
set splitbelow

" toggle highlight search
function ToggleHLSearch()
  if &hls
    set nohls
  else
    set hls
  endif
endfunction

" filetype settings
" au FileType text setlocal textwidth=72 lbr formatoptions+=ta infercase dictionary+=/usr/share/dict/words 
au FileType ant,html,xml,xsl,rxml,rhtml,eruby,mxml,php source ~/.vim/scripts/closetag.vim
au FileType html,rhtml,eruby setlocal wrap
au FileType mxml,actionscript set makeprg=ant\ -find\ build.xml

" dictionary completion settings
au FileType actionscript setlocal complete+=k~/.vim/dict/actionscript3.dict
au FileType actionscript setlocal dictionary=~/.vim/dict/actionscript3.dict
au FileType mxml setlocal complete+=k~/.vim/dict/mxml.dict
au FileType mxml setlocal dictionary=~/.vim/dict/mxml.dict

" omnicompletion settings
au FileType ruby setlocal omnifunc=rubycomplete#Complete
au FileType c setlocal omnifunc=ccomplete#Complete
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
au FileType html setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType css setlocal omnifunc=csscomplete#CompleteCSS
au FileType php setlocal omnifunc=phpcomplete#CompletePHP
"au FileType actionscript setlocal omnifunc=actionscriptcomplete#Complete

" easily comment out code selected in visual mode
au FileType haskell,vhdl,ada            let b:comment_leader = '-- '
au FileType vim                         let b:comment_leader = '" '
au FileType c,cpp,java,actionscript     let b:comment_leader = '// '
au FileType sh,make                     let b:comment_leader = '# '
au FileType tex                         let b:comment_leader = '% '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR> 

" easier window movement
set winminheight=0
nmap <C-j> <C-w>j
nmap <C-k> <C-W>k
nmap <C-h> <c-w>h
nmap <C-l> <c-w>l

" fix common spelling mistakes
abbr teh the
abbr widht width
abbr rigth right
abbr heiht height

" function key bindings
noremap <silent> <F5> <Esc>:call ToggleHLSearch()<cr>
noremap <silent> <F6> :set spell!<cr>
noremap! <silent> <F6> <c-o>:set spell!<cr> 
noremap <silent> <F7> :set list!<cr>
noremap! <silent> <F7> <c-o>:set list!<cr>
noremap <silent> <F8> :TlistToggle<cr>

" TwitVim plugin settings
let twitvim_login = "svoisen:rangerxlt"

" NERDTree settings
noremap <silent> <F4> :NERDTreeToggle<cr>
cabbr ntb NERDTreeFromBookmark
cabbr nt NERDTree
cabbr ntt NERDTreeToggle

" Tag list settings
let Tlist_Inc_Winwidth = 0
let Tlist_Use_Right_Window = 1
let Tlist_Show_Menu = 1
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'

" ctags
set tags=./tags,tags,~/commontags

" lookup online documentation
function! OnlineDocs ()
  let s:wordUnderCursor = expand("<cword>")
  if &ft =~ "actionscript" || &ft =~ "mxml"
    let s:url = system("~/Scripts/flexdoc " . s:wordUnderCursor)
  endif
  let s:cmd = "silent !firefox -new-window " . s:url . " &"
  exec s:cmd
  redraw!
endfunction
map \d :call OnlineDocs ()<cr>

" show whitespaces
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
