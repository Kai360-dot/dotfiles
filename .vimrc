
" An example for a vimrc file.
"
" Maintainer:	The Vim Project <https://github.com/vim/vim>
" Last Change:	2023 Aug 10
" Former Maintainer:	Bram Moolenaar <Bram@vim.org>
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
set swapfile
set dir=/tmp
set backup
set backupdir=/tmp
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set tags=./tags;/
" vim plugin installer
"call plug#begin('~/.vim/plugged')
"Plug 'spacevim/gtags.vim'
"call plug#end()
"call plug#begin('~/.vim/plugged')
"
"Plug 'spacevim/gtags.vim'
"
"call plug#end()
"
"" Optional: add some convenient key mappings
"let g:gtags_auto_update = 1
"let g:gtags_default_flags = '-lN'
"
"nnoremap <leader>gd :GtagsCursor<CR>
"nnoremap <leader>gr :Gtags -r <C-R><C-W><CR>
"nnoremap <leader>gf :Gtags -P <C-R><C-F><CR>
source /home/ubuntu/.vim/pack/cscope/start/cscope_maps.vim
"function! LoadCscope()
"    let db = findfile("cscope.out", ".;")
"    if !empty(db)
"        execute "cs add " . db
"    endif
"endfunction

silent! cs add /home/ubuntu/OpenFOAM/ubuntu-12/run/cscope.out
