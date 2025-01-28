" Plugins ------------------------------------------------------------ {{{

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown' 
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" }}}


" General ------------------------------------------------------------ {{{

"System setting
set nocompatible "Disable compatibility with vi
filetype on "Enable file type detection
filetype plugin on "Enable plugins and load plugins for detected files
filetype indent on "Load an indent file for the dected file type

colorscheme slate
syntax on "Enable syntax highlighting
set number
set cursorline
highlight CursorLine cterm=NONE ctermfg=NONE ctermbg=darkgray guifg=NONE guibg=darkgray
highlight CursorLineNR cterm=NONE ctermfg=yellow guifg=yellow
set shiftwidth=4 " Set shift width to 4 spaces.
set tabstop=4 " Set tab width to 4 columns.
set expandtab " Use space characters instead of tabs.
set nobackup " Do not save backup files.
set scrolloff=10 " Do not let cursor scroll below or above N number of lines when scrolling.
set nowrap " Do not wrap lines. Allow long lines to extend as far as the line goes.
set incsearch " While searching though a file incrementally highlight matching characters as you type.
set ignorecase " Ignore capital letters during search.
" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase
set showcmd " Show partial command you type in the last line of the screen.
set showmode " Show the mode you are on the last line.
set showmatch " Show matching words during a search.
set hlsearch " Use highlighting when doing a search.
set history=1000 " Set the commands to save in history default number is 20.

" Enable auto completion menu after pressing TAB.
set wildmenu
set wildmode=list:longest " Make wildmenu behave like similar to Bash completion.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx " Wildmenu will ignore files with these extensions.

" Disable bell
set visualbell
set t_vb=   

" }}}


" MAPPINGS --------------------------------------------------------------- {{{

    " Type jj to exit insert mode quickly.
    inoremap jj <Esc> 

    " Press the space bar to type the : character in command mode.
    nnoremap <space> :

    " Map the F5 key to run a Python script inside Vim.
    " I map F5 to a chain of commands here.
    " :w saves the file.
    " <CR> (carriage return) is like pressing the enter key.
    " !clear runs the external clear screen command.
    " !python3 % executes the current file with Python.
    autocmd FileType java nnoremap <F5> :w<CR>:!javac % && java %:r<CR>


    " You can split the window in Vim by typing :split or :vsplit.
    " Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-h> <c-w>h
    nnoremap <c-l> <c-w>l

    " Resize split windows using arrow keys by pressing:
    " CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
    nnoremap <C-UP>    :resize +2<CR>
    nnoremap <C-Down>  :resize -2<CR>
    nnoremap <C-i>  :vertical resize -2<CR>
    nnoremap <C-o> :vertical resize +2<CR>

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

    " This will enable code folding.
    " Use the marker method of folding.
    augroup filetype_vim
        autocmd!
        autocmd FileType vim setlocal foldmethod=marker
    augroup END

    " More Vimscripts code goes here.
    
    augroup json_formatting
        autocmd!
        autocmd BufRead,BufNewFile *.json silent! %!jq .
    augroup END


    "
    autocmd BufRead,BufNewFile *.ajs set filetype=javascript

" }}}


" STATUS LINE ------------------------------------------------------------ {{{
    " Clear status line when vimrc is reloaded.
    set statusline=
    
    " Status line left side.
    set statusline+=\ %F\ %M\ %Y\ %R
    
    " Use a divider to separate the left side from the right side.
    set statusline+=%=
    
    " Status line right side.
    set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%
    
    " Show the status on the second to last line.
    set laststatus=2

" }}}


" WORK IN PROGRESS ----------------------------------------------------- {{{
"


" configure expanding of tabs for various file types
"
"
"   --------------------------------------------------------------------------------
"    Configuration for python 
"   --------------------------------------------------------------------------------
"

  "au BufRead,BufNewFile *.py set expandtab
  "set expandtab           " enter spaces when tab is pressed
  "set textwidth=120       " break lines when line length increases
  "set tabstop=4           " use 4 spaces to represent tab
  "set softtabstop=4
  "set shiftwidth=4        " number of spaces to use for auto indent
  "set autoindent          " copy indent from current line when starting a new line
  
  "make backspaces more powerfull
  "set backspace=indent,eol,start


"function! PreventPythonSaveIfIndentIncorrect()
    "if &filetype == 'python'
        "Run flake8 to check for indentation errors
        "let l:flake8_output = system('flake8 --select=E101,E111 ' . expand('%:p'))
        "if !empty(l:flake8_output)
            "echoerr Indentation error detected:\n" . l:flake8_output
            " Prevent saving by returning a non-zero value
            "return 1
        "endif
    "endif
    " Allow saving for correctly indented files
    "return 0
"endfunction
            
 " Hook into the write command to check Python file indentation
 "autocmd BufWritePre *.py call PreventPythonSaveIfIndentIncorrect()j

" }}}
