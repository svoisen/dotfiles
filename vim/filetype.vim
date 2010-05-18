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
augroup END
