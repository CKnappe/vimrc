set runtimepath+=$HOME/.vim,$VIMRUNTIME,~/.vim/after,$VIM,C:/vim

" Enforce Vim mode, so we use vim instead of vi
set nocompatible
" Disable File Type detection, required for vundle
filetype off

set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
" Vundle itself
Plugin 'gmarik/Vundle.vim'
" airline
Plugin 'bling/vim-airline'
" You Complete Me
Plugin 'Valloric/YouCompleteMe'
" Install colorschemes
Plugin 'flazz/vim-colorschemes'
" Install Ctrlp
Plugin 'kien/ctrlp.vim'
" Install Ag.vi
Plugin 'rking/ag.vim'
" Install easytags
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
" Install vim-reload (Enables automatic reload of changed scripts
Plugin 'xolox/vim-reload'
" Install TagHighlight
" Plugin 'vim-scripts/TagHighlight'
" Install tagbar
Plugin 'majutsushi/tagbar'
" Install improved syntax highlighting
Plugin 'octol/vim-cpp-enhanced-highlight'
" Install dispatch.vim (asynchronous builds)
Plugin 'tpope/vim-dispatch'
" Install dbg.vim (debugger)
Plugin 'Shougo/vimproc.vim'
Plugin 'yuratomo/dbg.vim'
" Install vim-localvimrc (load project specific .vimrc)
Plugin 'embear/vim-localvimrc'
" Install vim-easyclip (No longer copy upon delete)
Plugin 'tpope/vim-repeat'
Plugin 'svermeulen/vim-easyclip'
call vundle#end()

" Enable Substitute command in vim-easyclip
let g:EasyClipUseSubstituteDefaults = 1

" Configure ctrlp.vim
let g:ctrlp_extensions = ['line']
" Configure tags file
set tags=./tags;
let g:easytags_dynamic_files = 1
let g:easytags_async = 1
let g:easytags_auto_highlight = 0

" Configure Tagbar 
nmap <a-p> :TagbarToggle<cr>

" reenable file type detection
filetype plugin indent on
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


" Key mappings for easier buffer (faketab) navigation
nnoremap <a-h> :bprevious<cr>
nnoremap <a-l> :bnext<cr>

" Show line number
set number
" Show tabs as 4 spaces
set tabstop=4
" Insert tab as 4 spaces
set shiftwidth=4
" Replace tabs with spaces
set expandtab
" Disable wordwrap
set nowrap

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

" Configure dbg.vim
let g:dbg#command_shell = 'cmd.exe'
let g:dbg#shell_prompt = '> '
let g:dbg#command_cdb = 'C:\Program Files (x86)\Windows Kits\8.1\Debuggers\x86\cdb.exe'

" Show just the filename
let g:airline#extension#tabline#fnamemod = ':t'
" Set netrw list view to show the entire tree
let g:netrw_liststyle = 3

" gvim settings
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

"  Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Remove question dialog from localvimrc
let g:localvimrc_whitelist = 'F:/psmtec0031-0033_PTB_GIT/.lvimrc'

" Enable Project specific .vimrc
set exrc
" Allow only secure commands in the project specific .vimrc
"set secure

" Prevent ycm from constantly asking whether or not to load ycm_extra_conf
let g:ycm_confirm_extra_conf = 0

" Simplify tag navigation
map <c-,> :YcmCompleter GoToDefinition
map <c-.> :YCmCompleter GotoDeclaration
nnoremap t <C-]>

" To be able to switch unsaved buffers
set hidden
" Make search non case sensitive
set ignorecase

