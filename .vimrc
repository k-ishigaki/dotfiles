" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set wildmenu
set autoindent
set smartindent
set number
set backspace=start,eol,indent
set iminsert=0		" 挿入モードのデフォルト値 0:IME=OFF
set imsearch=-1		" 検索時のデフォルト値 -1:equal to iminsert
set formatoptions+=r	" 挿入モード時，Enter押下でコメントを自動挿入する
set formatoptions-=o	" 'o','O'でのコメントを自動挿入しない
set formatoptions-=t	" 自動折り返しをしないようにする
set fileformats=unix,dos
set fileformat=unix	" unix line endings
set noundofile		" undoファイルを作成しない
set guioptions-=T	" ツールバーを削除
set nonumber
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
" tab sizes
set tabstop=4
set shiftwidth=4
set noexpandtab
" let locate backup files ("*.~) to TEMP directory
if has('unix') || has('mac')
	set backupdir=/tmp
else
	set shellpipe=2>\&1\|nkf\ -uw\|wtee	" wteeを利用してリダイレクトと標準出力を同時に行う
	set backupdir=$TEMP
endif

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
" for asynchronous tasks
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
" command line at vim
NeoBundle 'Shougo/vimshell.vim'
" complete words visualizer
NeoBundle 'Shougo/neocomplete.vim'
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'
" quickrun programs at vim
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config = {
\   "cpp/g++-preprocessor" : {
\       "exec"    : "%c %o %s:p",
\       "command" : "g++.exe",
\       "cmdopt"  : " -P -E -C -w -std=gnu++0x",
\   },
\}
" visual effects for vim status bar
NeoBundle 'itchyny/lightline.vim'
" filetype definition for haskell
NeoBundle 'kana/vim-filetype-haskell'
" plugin for haskell ghcmod
NeoBundle 'eagletmt/ghcmod-vim'
" neocomplete helper for haskell
NeoBundle 'ujihisa/neco-ghc'
" Arduino syntax highlighting
NeoBundle 'sudar/vim-arduino-syntax'
" file tree
NeoBundle 'scrooloose/nerdtree'
" vim clang complete plugin
NeoBundle 'justmao945/vim-clang'
let g:clang_check_syntax_auto = 1
let g:clang_format_auto = 1
let g:clang_format_style = "{BasedOnStyle: LLVM, IndentWidth: 8, UseTab: ForIndentation, AccessModifierOffset: -8, PointerBindsToType: true}"
" for markdown preview
NeoBundle 'kannokanno/previm'
NeoBundle 'open-browser'

highlight Pmenu ctermbg=248 guibg=#606060
highlight PmenuSel ctermbg=159 guifg=#dddd00 guibg=#1f82cd
highlight PmenuSbar ctermbg=0 guibg=#d6d6d6

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
