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
set background=dark

" カラースキーマ設定
" 今のところはカラースキーマは別途ダンロードして.vim/colors以下に配置
set t_Co=256
colorscheme railscasts

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
set encoding=utf-8
set fileencoding=utf-8
set hlsearch
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

if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup end

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir . "," . &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:plugins_toml = s:dein_dir . '/plugins.toml'
let s:lazy_toml = s:dein_dir . '/lazy.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:plugins_toml, s:lazy_toml])
  call dein#load_toml(s:plugins_toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" 以下にプラグインのその他の設定を書く

" Required:
filetype plugin indent on
