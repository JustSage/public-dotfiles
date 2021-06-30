" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set relativenumber
set hidden
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*
set noswapfile
set splitbelow
set splitright

" Incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=
set nosc noru nosm

" Don't redraw while executng macros (good performance config)
set lazyredraw

" Ignore case when searching
set ignorecase

" Indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent

" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Read/Save file when switching buffers
set autowrite
set autoread

" Undo file & dir
set undofile
set undodir=/tmp
" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Load back at the same line
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "normal! g'\"" |
\ endif

" Set spelling on for git commits and markdown files.
augroup SetSpelling
    autocmd!
    autocmd FileType gitcommit setlocal spell spelllang=en_us
    autocmd FileType markdown setlocal spell spelllang=en_us
augroup END
"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40
highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"

" File types "
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Python
au BufNewFile,BufRead *.py set filetype=python
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"

" Imports "
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
"

" Syntax theme "
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
  " Tomorrow night theme
  runtime ./colors/Tomorrow-Night.vim
  colorscheme Tomorrow-Night
endif

" Extras "{{{
" ---------------------------------------------------------------------
set exrc

  " Trailing whitespace removal on save
augroup TrailingWhitespace
    autocmd FileType python, json
    autocmd BufWritePre <buffer> :%s/\s\+$//e
    command! W :w
    command! Q :q
  augroup END

  " Toggle quickfix windown
function! ToggleQuickfix()
for buffer in tabpagebuflist()
if bufname(buffer) is# ''
  cclose
  return
endif
endfor

copen
endfunction

