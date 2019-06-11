" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2001 Jul 18
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" read/write a .viminfo file, don't store more than 50 lines of registers
set viminfo='20,\"50

"set autoindent		" always set autoindenting on
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
"set incsearch		" do incremental searching

set dict=/opt/osxws/share/dict/words

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" some extra commands for HTML editing
nmap ,mh wbgueyei<<ESC>ea></<ESC>pa><ESC>bba
nmap ,h1 _i<h1><ESC>A</h1><ESC>
nmap ,h2 _i<h2><ESC>A</h2><ESC>
nmap ,h3 _i<h3><ESC>A</h3><ESC>
nmap ,h4 _i<h4><ESC>A</h4><ESC>
nmap ,h5 _i<h5><ESC>A</h5><ESC>
nmap ,h6 _i<h6><ESC>A</h6><ESC>
nmap ,hb wbi<b><ESC>ea</b><ESC>bb
nmap ,he wbi<em><ESC>ea</em><ESC>bb
nmap ,hi wbi<i><ESC>ea</i><ESC>bb
nmap ,hu wbi<u><ESC>ea</i><ESC>bb
nmap ,hs wbi<strong><ESC>ea</strong><ESC>bb
nmap ,ht wbi<tt><ESC>ea</tt><ESC>bb
nmap ,hx wbF<df>f<df>

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  if has("syntax")
    syntax on
  endif
  set hlsearch
  if &term == "kon" || &term == "linux" || &term == "jfbterm"
    set bg=dark
  endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

endif " has("autocmd")

if has("autocmd")
  augroup cprog
    " Remove all cprog autocommands
    au!

    " When starting to edit a file:
    "   For C and C++ files set formatting of comments and set C-indenting on.
    "   For other files switch it off.
    "   Don't change the order, it's important that the line with * comes first.
    autocmd FileType *      set formatoptions=tcql nocindent comments&
    autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
  augroup END
endif

if &term == "xterm"
  "set t_Co=8
  set t_Sb=^[4%dm
  set t_Sf=^[3%dm
endif

if $LANG =~ "ja_JP.*"
  if has("multi_byte")
    set enc=utf-8
    set termencoding=utf-8
    set fenc=utf-8
    set fencs=utf-8,euc-jp,sjis,iso-2022-jp,utf-8,utf-16,ucs-2-internal,ucs-2,japan
  endif
endif


" Ray Matsuda
" 2018.9.4

" 一文が複数行にまたがっても上下移動できる
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

inoremap jf <ESC>

" コピペしてもインデント崩れない
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

"カーソルライン表示
set cursorline
"インサートでカーソル非表示
autocmd InsertEnter,InsertLeave * set cursorline!

"カーソルラインのオプション
highlight CursorLine cterm=underline ctermbg=none ctermfg=none

"スワップファイルとアンドゥファイル生成しない
set noswapfile
set noundofile

"バックアップファイルは一箇所に生成
set backupdir=~/.vim/backupFiles

" 日本語崩れるの回避
set ambiwidth=double

" 「％」で対応するカッコに飛ぶ
source $VIMRUNTIME/macros/matchit.vim

" コマンドモードの補完 tabで移動
set wildmenu

"カラースキーム
colorscheme atom-dark-256
set t_Co=256

"Vundleの設定ファイル読み込み
if filereadable( $HOME . "/.vimPlugin" )
  source ~/.vimPlugin
endif

"前の行末と次の行頭を左右移動できる                                                                                                   
set whichwrap=b,s,h,l,<,>,[,],~

"タブを半角スペース2つ分にする
set expandtab
set tabstop=2
set shiftwidth=2

set number
set relativenumber

"emmetをtabで展開
autocmd FileType html,css,scss imap <buffer><expr><tab>
    \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
    \ "\<tab>"
