" Enforce Vim mode, so we use vim instead of vi
set nocompatible
" Disable File Type detection, required for vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle itself
Plugin 'gmarik/Vundle.vim'
" airline
Plugin 'bling/vim-airline'
" You Complete Me
Plugin 'Valloric/YouCompleteMe'
" Install colorschemes
Plugin 'flazz/vim-colorschemes'
call vundle#end()
"reenable file type detection
filetype plugin indent on
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:racer_cmd = "~/external_projects/racer/target/release/racer"

" Show line number
set number
" Show tabs as 4 spaces
set tabstop=4
" Insert tab as 4 spaces
set shiftwidth=4
" Replace tabs with spaces
set expandtab

let &colorcolumn=join(range(81,299),",")
" enable syntax processing
syntax enable
" Set Color Scheme to molokai
colorscheme Monokai
colorscheme molokai
" Always show ruler
set ruler
" Highlight current line
set cursorline
" Prevent unnecessary redraws
set lazyredraw
" Highlight matching [{()}]
set showmatch
" Search as characters are entered
set incsearch
" Highlight matches
set hlsearch

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extension#tabline#fnamemod = ':t'
" Set netrw list view to show the entire tree
let g:netrw_liststyle = 3
