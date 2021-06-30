" Description: Keymaps

" Leader key
let mapleader = ","

" Increment/decrement
nnoremap + <C-a>
nnoremap - <C-x>

" Switch between lines with shift + 'u' switch (up) | shift + 'd' (down)
nnoremap <S-u> :m-2<CR>
nnoremap <S-d> :m+<CR>
vnoremap <S-u> :m-2<CR>
vnoremap <S-d> :m+<CR>

" Disable command history
nnoremap q: <nop>
nnoremap Q <nop>

nnoremap <leader><leader> :call ToggleQuickfix()<cr>
