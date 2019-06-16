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
" ファイルによってインデントを変更する
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.go setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.gs setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
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
" 自動的に閉じかっこを入れる
"imap { {}<LEFT>
"imap [ []<LEFT>
"imap ( ()<LEFT>
"?
set iminsert=0
set imsearch=-1
" コマンドの補完を有効化
set wildmenu
" コマンドの履歴を1000件保存
set history=1000
"空行を挿入する
nnoremap ` :<C-u>call append(expand('.'), '')<Cr>j
" Cheatcheet
let g:cheatsheet#cheat_file = '~/.vim/cheatsheet.md'
" netrw
filetype plugin on
" ステータス行に現在のgitブランチを表示する
"set statusline+=%{fugitive#statusline()}
" TableMode
let g:table_mode_corner = '|'
" Templates
let g:sonictemplate_vim_template_dir = ['~/.vim/templates']
" vim-plugin
 let g:deoplete#enable_at_startup = 1
 let g:deoplete#auto_completion_start_length = 2

" プラグインの自動起動
autocmd VimEnter * execute 'NERDTree'

" NERDTree Settings
" dotfileを表示させる
let NERDTreeShowHidden=1
" treeの幅
let NERDTreeWinSize=15

" vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_auto_colors=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=33
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=76
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

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

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------

"BufRead
au BufRead,BufNewFile *.cfn.yaml set ft=cloudformation.yaml

"Programing language settings------------
let g:prettier#autoformat = 0
autocmd BufWritePre *.json,*.yaml Prettier


"Python
autocmd BufRead,BufNewFile *.py set filetype=python
let g:syntastic_python_checkers = ['pyflakes', 'pep8', 'flake8', 'pylint']
let g:PyFlakeOnWrite = 1
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
let g:PyFlakeDefaultComplexity=10
"Go
au FileType go nmap gi <Plug>(go-info)
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap gt <Plug>(go-test)
au FileType go nmap gds <Plug>(go-def-split)
au FileType go nmap gdv <Plug>(go-def-vertical)
let g:go_fmt_command = "goimports"
let g:syntastic_go_checkers = ['golint']
let g:go_fmt_autosave = 1
let g:go_gocode_propose_source = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1

let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'
" deoplete.vim
let g:deoplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

" <BS>: close popup and delete backword char.
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function() abort
  return deoplete#cancel_popup() . "\<CR>"
endfunction

" neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1
