" Install Plugin
call plug#begin('~/.vim/plugged')

Plug 'vim-jp/vimdoc-ja'
Plug 'junegunn/fzf', {'dir': '~/.fzf_bin', 'do': './install --all'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/gina.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sainnhe/gruvbox-material'

call plug#end()


"-------------------------------------------------------------------------------
" Basic
"-------------------------------------------------------------------------------
let mapleader = "\<Space>"
set autoread
" https://maku77.github.io/vim/settings/auto-indent.html
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END
set backspace=indent,eol,start
" set browsedir=buffer " kiitenai youni mieru
set clipboard=unnamedplus
" set formatoptions=lmoq         " default: jcroql
" set modelines=0                " モードラインは無効
set noswapfile
set scrolloff=5
set whichwrap=b,s,h,l,<,>,~,[,]

" auto-reload *vimrc
autocmd! BufWritePost *vimrc source $MYVIMRC


"-------------------------------------------------------------------------------
" StatusLine
"-------------------------------------------------------------------------------
set statusline=%{expand('%:p:t')}\ %<[%{expand('%:p:h')}]%=\ %m%r%y%w[%{&fenc!=''?&fenc:&enc}][%{&ff}][CODE=0x%02B][POS:%l/%L(%02p\%%),%3c]


"-------------------------------------------------------------------------------
" Indent
"-------------------------------------------------------------------------------
set autoindent
set smartindent
set shiftwidth=4
set softtabstop=4
set expandtab

if has('autocmd')
  filetype plugin on
  filetype indent on
  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
  autocmd FileType coffee     setlocal sw=2 sts=2 ts=2 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scss       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sql        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType toml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=4 sts=4 ts=4 et
endif

"-------------------------------------------------------------------------------
" Apperance
"-------------------------------------------------------------------------------
set cursorline
set display+=uhex
set lazyredraw
set list
set number
set showmatch
set matchtime=1
set pumheight=10
set splitbelow
set splitright
set ttyfast
set showtabline=2  " always show tabline

" https://thinca.hatenablog.com/entry/20111204/1322932585
" https://ryota2357.com/blog/2023/nvim-custom-statusline-tabline/
set tabline=%!MakeTabLine()
function! s:tabpage_label(n)
  " t:title と言う変数があったらそれを使う
  let title = gettabvar(a:n, 'title')
  if title !=# ''
    return title
  endif

  " タブページ内のバッファのリスト
  let bufnrs = tabpagebuflist(a:n)

  " カレントタブページかどうかでハイライトを切り替える
  let hi = a:n is tabpagenr() ? '%#TabLineSel#' : '%#TabLine#'

  " バッファが複数あったらバッファ数を表示
  let no = len(bufnrs)
  if no is 1
    let no = ''
  endif
  " タブページ内に変更ありのバッファがあったら '+' を付ける
  let mod = len(filter(copy(bufnrs), 'getbufvar(v:val, "&modified")')) ? '+' : ''
  let sp = (no . mod) ==# '' ? '' : ' '  " 隙間空ける

  " カレントバッファ
  let curbufnr = bufnrs[tabpagewinnr(a:n) - 1]  " tabpagewinnr() は 1 origin
  let fname = pathshorten(bufname(curbufnr))

  let label = no . mod . sp . fname

  return '%' . a:n . 'T' . hi . label . '%T%#TabLineFill#'
endfunction

function! MakeTabLine()
  let titles = map(range(1, tabpagenr('$')), 's:tabpage_label(v:val)')
  let sep = ' | '  " タブ間の区切り
  let tabpages = join(titles, sep) . sep . '%#TabLineFill#%T'
  let info = ''  " 好きな情報を入れる
  return tabpages . '%=' . info  " タブリストを左に、情報を右に表示
endfunction

" Display of full-width spaces
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" Enable cursor highlighting only in the current window
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END

" Make it easy to see underbars even with cursor highlighting.
highlight clear CursorLine
highlight CursorLine gui=underline ctermbg=black guibg=black

" Highligh whitespace at the end of a line
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END


"-------------------------------------------------------------------------------
" Edit
"-------------------------------------------------------------------------------
nnoremap ; :
nnoremap : ;
" https://qiita.com/ringo/items/bb9cf61a3ccfe6183c7b
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

nnoremap x "_x
nnoremap s "_s
nnoremap c "_c
" vnoremap <C-Up> "zdd<Up>"zP
" vnoremap <C-Down> "zdd"zP
vnoremap <C-J> "zdd"zP


"-------------------------------------------------------------------------------
" Colors
"-------------------------------------------------------------------------------
hi Pmenu ctermbg=255 ctermfg=0 guifg=#000000 guibg=#999999
hi PmenuSel ctermbg=blue ctermfg=black
" hi PmenuSel cterm=reverse ctermfg=33 ctermbg=222 gui=reverse guifg=#3399ff guibg=#f0e68c
" hi PmenuSbar ctermbg=0 ctermfg=9
hi PmenuSbar ctermbg=255 ctermfg=0 guifg=#000000 guibg=#FFFFFF


"-------------------------------------------------------------------------------
" Encoding
"-------------------------------------------------------------------------------
" 文字コード認識はbanyan/recognize_charcode.vimへ
set ffs=unix,dos,mac
set encoding=utf-8
set fileencoding=utf-8

" Extension to lower priority when displaying with wildcards
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

command! Cp932 edit ++enc=cp932
command! Eucjp edit ++enc=euc-jp
command! Iso2022jp edit ++enc=iso-2022-jp
command! Utf8 edit ++enc=utf-8
command! Jis Iso2022jp
command! Sjis Cp932


"-------------------------------------------------------------------------------
" Move
"-------------------------------------------------------------------------------
" Moves to the last finished cursor line.
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" http://labs.timedia.co.jp/2011/04/git-diff-aware-gf-commands-for-vim.html
" open file in git diff like a/.tmux.conf b/.tmux.conf
nnoremap <expr> gf  <SID>do_git_diff_aware_gf('<C-w>gf')
nnoremap <expr> gF  <SID>do_git_diff_aware_gf('<C-w>gF')
nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('gf')
nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('gF')
function! s:do_git_diff_aware_gf(command)
  let target_path = expand('<cfile>')
  if target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if filereadable(target_path) || isdirectory(target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction


"-------------------------------------------------------------------------------
" Complete
"-------------------------------------------------------------------------------
set wildmode=list:full


"-------------------------------------------------------------------------------
" Search
"-------------------------------------------------------------------------------
set ignorecase
set smartcase
" Press Esc twice to clear highlights
nmap <ESC><ESC> ;nohlsearch<CR><ESC>


"-------------------------------------------------------------------------------
" Terminal
"-------------------------------------------------------------------------------
" open terminal
" https://zenn.dev/ryo_kawamata/articles/improve-neovmi-terminal
" command! -nargs=* T split | wincmd j | resize 10 | terminal <args>
command! -nargs=* T split | wincmd j | resize <args> | terminal
autocmd TermOpen * startinsert " always open Terminal in insert mode


"-------------------------------------------------------------------------------
" Misc
"-------------------------------------------------------------------------------
" https://zenn.dev/kawarimidoll/articles/04ffb0d2270328
function! s:terminal_autoclose(cmd) abort
  let bn = bufnr()
  let cmd = get(a:, 'cmd', '')
  if cmd == ''
    let cmd = &shell
  endif

  let opts = { 'on_exit': { -> { execute(bn .. 'bwipeout', 'silent!') } } }
  call termopen(cmd, opts)
  normal! G
endfunction
command! -nargs=* TerminalAutoclose call s:terminal_autoclose(<q-args>)

" https://zenn.dev/kawarimidoll/articles/0f3fdfcd881f5c
function! s:start_lazygit() abort
  let buf = nvim_create_buf(v:false, v:true)
  let winconf = {
    \   'style': 'minimal', 'relative': 'editor',
    \   'width': nvim_get_option('columns'),
    \   'height': nvim_get_option('lines'),
    \   'row': 1, 'col': 1,
    \   'focusable': v:true
    \ }
  call nvim_open_win(buf, v:true, winconf)
  call s:terminal_autoclose('lazygit')
  set bufhidden=wipe
  startinsert
endfunction
command! LazyGit call s:start_lazygit()
