set nocompatible

set background=light

set cursorline

"use Unicode
set encoding=utf-8

"errors flash screen rather than emit beep
set visualbell

"make Backspace work like Delete
set backspace=indent,eol,start

"line numbers and distances
set relativenumber 
set number

"number of lines offset when jumping
set scrolloff=5

"Indent new line the same as the preceding line
set autoindent

"statusline indicates insert or normal mode
set showmode showcmd

"highlight matching parentheses, braces, brackets, etc
set showmatch

" case sensitive if it contains an uppercase 
set ignorecase
set smartcase

" number of columns occupied by a tab
set tabstop=4

" width for autoindents
set shiftwidth=4

" highlight search
set hlsearch

" working directory is always the same as the file you are editing
set autochdir

" get bash-like tab completions
set wildmenu wildmode=list:longest,full

" allow auto-indenting depending on file type
filetype plugin indent on

" syntax highlighting
syntax on

" enable mouse click
set mouse=a

filetype plugin on

" speed up scrolling in Vim
set ttyfast

set laststatus=2 statusline=%F
set history=500

"show the file title
set title

" Keybindings


" Plugins
call plug#begin('~/.vim/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes


Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}


"Initialize plugin system
call plug#end()
