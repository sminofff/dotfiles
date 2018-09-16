au BufRead,BufNewFile *.yml set ft=cloudformation.yaml
" 文字コードをutf-8に設定
set encoding=utf-8
scriptencoding utf-8

" 特殊文字の文字化けを修正する
set ambiwidth=double

" 他OSで作成されたファイルに対応
set fileformats=unix,dos,mac

" 行番号を表示
set number

" バックスペースキーの有効化
set backspace=indent,eol,start

" 前の行のインデントを継続させる
set autoindent

" 自動的にインデントを行う
set smartindent

" インデントする際のスペースの数
set shiftwidth=2

" タブを空白にに変換
set expandtab

" ハイライトを有効にする
set hlsearch

" 検索中に自動的にハイライトする
set incsearch

" 小文字で検索する際に、検索結果に大文字を含める
set ignorecase

" 検索文字列に、大文字と小文字が混在している場合に、区別して検索する。
set smartcase

" 検索が末尾まで終わると先頭に戻る
set wrapscan

" 現在の行に、下線を表示する
set cursorline

" （）を強調させる
set showmatch

" 自動的にIMEをオフにする
set iminsert=0
set imsearch=-1

" コマンドの補完を有効化
set wildmenu

" コマンドの履歴を1000件保存
set history=1000

" 0で空行を挿入する
nnoremap ` :<C-u>call append(expand('.'), '')<Cr>j

" netrw
set nocompatible
filetype plugin on

" ペースト時のインデントを防止
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

" 自動的に閉じかっこを入れる
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

" プラグインの自動起動
autocmd VimEnter * execute 'NERDTree'

" dotfileを表示させる
let NERDTreeShowHidden=1

" vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=33
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=76
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" Gitを便利に使う
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}

"------------------------------------------------------------
" * vim-go
"------------------------------------------------------------

au FileType go nmap gi <Plug>(go-info)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap gt <Plug>(go-test)
let g:go_fmt_command = "goimports"

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

let s:dein_path = expand('~/.vim/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github からclone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_path)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)

  let g:config_dir  = expand('~/.vim/dein/userconfig')
  let s:toml        = g:config_dir . '/plugins.toml'
  let s:lazy_toml   = g:config_dir . '/plugins_lazy.toml'

  " TOML 読み込み
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif


" Required:
filetype plugin indent on
syntax enable

" インストールされていないプラグインがあればインストールする
" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

