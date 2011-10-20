" Sean Voisen's vimrc
" Web: http://voisen.org
"
" turn on syntax highlighting and highlight search if the terminal has
" colors
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("gui_running")
  set background=dark
else
  set background=light
endif

" check for 256 colors and set colorscheme
if $TERM =~ "-256color"
  set t_Co=256
  colorscheme solarized
else
  colorscheme solarized
endif

" GUI-specific settings
if has("gui_running")
  " Hide the toolbar
  set guioptions-=T

  " Set font
  set guifont=liberation_mono:h12

  " show column at 80 characters
  set colorcolumn=80
end

" file encoding options
if has("multi_byte")
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set termencoding=iso-8859-1
endif

" turn on file type support
filetype on

" turn on filetype specific indenting
filetype plugin indent on

" change completion menu to always appear even with one result
set completeopt=longest,menuone

" use <ctrl> space for completion
" if omnicompletion is not available, use regular completion
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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" indentation options
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround
set smarttab

" show matching parens
set showmatch

" turn off the damn bell
set vb

" enable the mouse
set mouse=a

" backup/swap options
set nobackup
set noswapfile

" do not change terminal title
set notitle

" search options
set ignorecase
set infercase
set smartcase
set incsearch

" always do global replace
set gdefault

" always save when editor loses focus
au FocusLost * :wa

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
au FileType text setlocal wrap lbr infercase dictionary+=/usr/share/dict/words
au FileType ant,html,xml,xsl,rxml,rhtml,eruby,mxml,php source ~/.vim/scripts/closetag.vim
au FileType html,rhtml,eruby,markdown,textile setlocal wrap
au FileType mxml,actionscript set makeprg=ant\ -find\ build.xml
au FileType crayon set makeprg=crayonc

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

" easily comment out code selected in visual mode
au FileType haskell,vhdl,ada            let b:comment_leader = '-- '
au FileType vim                         let b:comment_leader = '" '
au FileType c,cpp,java,actionscript     let b:comment_leader = '// '
au FileType sh,make,ruby,crayon         let b:comment_leader = '# '
au FileType tex                         let b:comment_leader = '% '
noremap <silent> ,c :<C-B>sil <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:noh<CR>
noremap <silent> ,u :<C-B>sil <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:noh<CR>

" easier window movement
set winminheight=0
nmap <C-j> <C-w>j
nmap <C-k> <C-W>k
nmap <C-h> <c-w>h
nmap <C-l> <c-w>l
nmap <C-=> <c-w>=

" jump up/down only one line no matter what
nnoremap j gj
nnoremap k gk

" fix common spelling mistakes
abbr teh the
abbr widht width
abbr rigth right
abbr heiht height

" function key bindings
set pastetoggle=<F2>
noremap <silent> <F4> :NERDTreeToggle<cr>
noremap <silent> <F5> <Esc>:call ToggleHLSearch()<cr>
noremap <silent> <F6> :set spell!<cr>
noremap! <silent> <F6> <c-o>:set spell!<cr>
noremap <silent> <F7> :set list!<cr>
noremap! <silent> <F7> <c-o>:set list!<cr>
noremap <silent> <F8> :TlistToggle<cr>

" NERDTree abbrev settings
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

" show whitespaces
set listchars=eol:$,trail:~,extends:>,precedes:<

" leader commands
" edit vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" open horizontal split and switch to it
nnoremap <leader>s <C-w>s<C-w>j

" open vertical split and switch to it
nnoremap <leader>w <C-w>v<C-w>l

