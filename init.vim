if &compatible
    set nocompatible
endif

" plugin settings
" dein.vim
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:toml_dir = expand('~/.config/nvim')

" add the dein installation directory to runtimepath
execute 'set runtimepath+=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " manage plugins with toml
    let s:toml = s:toml_dir . '/dein.toml'
    let s:lazy = s:toml_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif

" general
set encoding=utf-8
set number
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set noerrorbells
set noswapfile
set splitright
set clipboard=unnamedplus
set fileformats=unix,dos,mac

filetype plugin indent on
syntax enable

" search
set ignorecase
set smartcase
set incsearch
set hlsearch

" colorscheme
set background=dark
colorscheme gruvbox
"set t_Co=256

" keybindings
nnoremap <CR> :nohlsearch<CR><CR>
nnoremap Q gq
nnoremap <F9> :!python %<CR>
nnoremap <silent> <C-e> :NERDTree<CR>
nnoremap <silent> <C-d> :DeniteBufferDir file/rec<CR>
nnoremap <silent> <C-o> :Denite file_mru<CR>
" use nmap to extract <Plug>... to the keymappings defined in plugins
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)

" denite.nvim keymappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <BS> denite#do_map('move_up_path')
    nnoremap <silent><buffer><expr> q denite#do_map('quit')
    nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_setting()
function! s:denite_filter_my_setting() abort
  inoremap <silent><buffer><expr> <BS> denite#do_map('move_up_path')
  nnoremap <silent><buffer><expr> <BS> denite#do_map('move_up_path')
  inoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
  nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
endfunction
