set runtimepath+=$HOME/.vim,$VIMRUNTIME,~/.vim/after,$VIM,C:/vim

" Set font
set guifont=Consolas:h8
" Change mapleader to space
let mapleader =" "
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
Plugin 'FelikZ/ctrlp-py-matcher' " Faster matcher
Plugin 'kien/ctrlp.vim'
" Install Ag.vi
Plugin 'rking/ag.vim'
" Install easytags
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-shell'
Plugin 'xolox/vim-easytags'
" Install vim-reload (Enables automatic reload of changed scripts
Plugin 'xolox/vim-reload'
" Install tagbar
Plugin 'majutsushi/tagbar'
" Install improved syntax highlighting
Plugin 'octol/vim-cpp-enhanced-highlight'
" Install dispatch.vim (asynchronous builds)
Plugin 'tpope/vim-dispatch'
" Install vim-localvimrc (load project specific .vimrc)
Plugin 'embear/vim-localvimrc'
" Install vim-easyclip (No longer copy upon delete)
Plugin 'tpope/vim-repeat'
Plugin 'svermeulen/vim-easyclip'
" Install qfdo (plugin to allow execution of search replace on every file in
" quickfix)
Plugin 'karlbright/qfdo.vim'
" Install uncrustify-vim (Code reformating)
Plugin 'ompugao/uncrustify-vim'
" Install vim-rename3 Allows renaming the current file
Plugin 'aehlke/vim-rename3'
" Install hardtime (Adds timeout to hjkl keys, making it easier to learn
" easymotion)
Plugin 'takac/vim-hardtime'
" Install easymotion (Easier navigation)
Plugin 'easymotion/vim-easymotion'
" Install QFGrep (Filter Quickfix window)
Plugin 'sk1418/QFGrep' " Used to remove unnecessary messages in quickfix
" Install BClose (Deleting a buffer without closing the window)
Plugin 'rbgrouleff/bclose.vim'
" Install rename.vim (Renaming current file)
Plugin 'danro/rename.vim'
" Install a.vim (Switch between header and source)
Plugin 'vim-scripts/a.vim'
" Install vim-autoclose (automatically add closing brackets, braces etc.)
Plugin 'Townk/vim-autoclose'
" Install Conque-Shell, integration a Shell into vim as a possible replacement
" for the current windbg
Plugin 'oplatek/Conque-Shell'

" Default enabled hardtime
" let g:hardtime_default_on = 1

call vundle#end()


" Enable Substitute command in vim-easyclip
let g:EasyClipUseSubstituteDefaults = 1

" Configure ctrlp.vim
let g:ctrlp_extensions = ['line']
let g:ctrlp_user_command = 'ag -l --nocolor --nogroup
                          \ --ignore "*.dds"
                          \ --ignore "*.png"
                          \ --ignore "*.wav"
                          \ --ignore "*.dtd"
                          \ --ignore "*.fx"
                          \ --ignore "*.flex"
                          \ --ignore "*.def"
                          \ --ignore "*.Dlg"
                          \ --ignore "*.docx"
                          \ --ignore "*.idl"
                          \ --ignore "*.jpg"
                          \ --ignore "*.jpeg"
                          \ --ignore "*.py"
                          \ --ignore "*.sln"
                          \ --ignore "*.vcproj"
                          \ --ignore "*.vcxproj"
                          \ -g "" %s'
let g:ctrlp_match_func = { 'match' : 'pymatcher#PyMatch' }

" Configure tags file
set tags=./tags;
let g:easytags_dynamic_files = 1
let g:easytags_async = 1
let g:easytags_auto_highlight = 0
set regexpengine=0

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
" Prevent ycm from opening the preview window
set completeopt-=preview
" ycm should now populate the location list, making it easier to jump to
" errors
let g:ycm_always_populate_location_list = 1

" Simplify tag navigation
nnoremap <c-,> :YcmCompleter GoToDefinition
nnoremap <c-.> :YCmCompleter GotoDeclaration
nnoremap <a-,> :lprevious<cr>
nnoremap <a-.> :lnext<cr>
nnoremap t <C-]>

" To be able to switch unsaved buffers
set hidden
" Make search non case sensitive
set ignorecase

nmap <silent> <Leader>e :Explore<CR>


" Enable folding by syntax
set foldmethod=syntax
" Ensure that no folds are closed upon bufferopening
set foldlevelstart=99


" Configure uncrustify-vim
let g:uncrustify_cfg_file_path = "~/.vim/.uncrustify.cfg"

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :Uncrustify<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :Uncrustify<CR>

" Ensure that *.ui files are identified as xml files (Syntax highlighting)
au BufNewFile,BufRead *.ui set filetype=xml

" Enabled linebreak in quickfix
au FileType qf setlocal wrap linebreak 
" Erase unnecessary messages in quickfix
au FileType qf call QFGrep#grep_QuickFix_with_pattern('^||\ \+.*.cpp', 1)

" Let r and R Update the quickfix windows if you are inside of it
:autocmd BufReadPost quickfix nnoremap <buffer> r :Copen<CR>
:autocmd BufReadPost quickfix nnoremap <buffer> R :Copen<CR>G

" Define CPP-Package (Compiler etc. for CPP)
function! LoadCPPPackage(projectPath, projectType, projectPlatform)
    let g:cpp_package_project_path = a:projectPath
    let g:cpp_package_project_type = a:projectType
    let g:cpp_package_project_platform = a:projectPlatform
    echo "Loading CPP Package"
    nnoremap <leader>j :call DoCompile()<cr>
    nnoremap <leader>k :call DoExecute()<cr>

    command! -nargs=* CompleteCompile call DoCompleteCompile(<f-args>)
    command! -nargs=* Compile call DoCompile(<f-args>)
    command! -nargs=* Execute call DoExecute(<f-args>)
    command! -nargs=0 Retag call DoRetag()

    function! DoCompleteCompile(...)
        let type = a:0 >= 1 ? a:1 : g:cpp_package_project_type
        let platform = a:0 >= 2 ? a:2 : g:cpp_package_project_platform

        execute "!start taskkill /T /F /IM windbg.exe"
        call setqflist([]) 
        comp msbuild 
        execute "Make ".g:cpp_package_project_path." /p:Configuration=".type." /p:Platform=".platform." /m /t:Clean,Build"
    endfunction

    function! DoCompile(...)
        let type = a:0 >= 1 ? a:1 : g:cpp_package_project_type
        let platform = a:0 >= 2 ? a:2 : g:cpp_package_project_platform

        execute "!start taskkill /T /F /IM windbg.exe"
        call setqflist([]) 
        comp msbuild 
        execute "Make ".g:cpp_package_project_path." /p:Configuration=".type." /p:Platform=".platform." /m"
    endfunction

    function! DoExecute(...)
        let type = a:0 >= 1 ? a:1 : g:cpp_package_project_type

        execute "!start taskkill /T /F /IM windbg.exe"
        execute "Spawn windbg -c \"g\" ..\\_output\\".type."\\Engine.exe"
    endfunction

    function! DoRetag()
        execute "Spawn ctags -R -f ../SourceCode/tags ../SourceCode/*"
    endfunction
endfunction

" Define AG (Project wide search)
command! -nargs=1 AG Ag --ignore "tags" <f-args> .

set regexpengine=1
