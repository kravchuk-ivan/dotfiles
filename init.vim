set nocompatible

set background=light

set cursorline

"use Unicode
set encoding=utf-8

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
" when 'ignorecase' and 'smartcase' are both on, if a pattern contains an
" uppercase letter, it is case sensitive, otherwise, it is not. For example,
" '/The' would find only 'The', while '/the' would find 'the' or 'The', etc
set ignorecase
set smartcase

" number of columns occupied by a tab
set tabstop=4 softtabstop=4

" convert tab character to whitespaces
set expandtab

" try to smartly indent
set smartindent

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

" Keybindings and remappings
" Backspace and space are to be remapped to something useful

" If you frequently use split windows, you might want to use the Ctrl-W family of commands to switch between windows.
" nnoremap <C-Tab> <C-w>w
" nnoremap <C-S-Tab> <C-w>W

" If you prefer one tab for one buffer, you can map the :tabn and :tabp commands (tab next, and tab previous).
nnoremap <Space> :tabn<CR>

" Important to make backspace work typically
set backspace=indent,eol,start

" Remap backspace to Esc (use <C-h> and <C-w> instead (standard))
nnoremap <BS> <Esc>
vnoremap <BS> <Esc>gV
onoremap <BS> <Esc>
cnoremap <BS> <C-C><Esc>
inoremap jj <Esc>

" In normal mode, you can press prefix keys before a command (for example, 12 for a count). The nnoremap causes Tab to cancel any prefix keys.
" The vnoremap causes Tab to cancel any selection (gV is required to prevent automatic reselection).
" The onoremap causes Tab to cancel any operator-pending command (for example, y).
" The cnoremap causes Tab to cancel any command that was entered.
" The first inoremap causes Tab to exit insert mode, and the `^ restores the cursor position so exiting insert does not move the cursor left.

" Plugins
call plug#begin('~/.vim/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
"   - ivankravchuk (path): '~/.vim/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'preservim/nerdtree'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Initialize plugin system
call plug#end()
