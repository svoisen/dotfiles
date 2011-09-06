" Sean Voisen's filetypes file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au!
  " ActionScript/MXML
  au BufNewFile,BufRead *.mxml set filetype=mxml
  au BufNewFile,BufRead *.as set filetype=actionscript

  " Plain text
  au BufNewFile,BufRead *.txt set filetype=text

  " Arduino files, which are essentially C
  au BufNewFile,BufRead *.pde set filetype=c

  " Treetop grammars
  au BufNewFile,BufRead *.tt set filetype=ruby
  au BufNewFile,BufRead *.treetop set filetype=ruby

  " Crayon
  au BufNewFile,BufRead *.crayon set filetype=crayon

  " Markdown
  au BufNewFile,BufRead *.markdown set filetype=markdown
augroup END
