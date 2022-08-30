set nocompatible

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

" set clipboard=unnamedplus,unnamed

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
" nnoremap <BS> <Esc>
" vnoremap <BS> <Esc>gV
" onoremap <BS> <Esc>
" cnoremap <BS> <C-C><Esc>
inoremap jj <Esc>

" In normal mode, you can press prefix keys before a command (for example, 12 for a count). The nnoremap causes Tab to cancel any prefix keys.
" The vnoremap causes Tab to cancel any selection (gV is required to prevent automatic reselection).
" The onoremap causes Tab to cancel any operator-pending command (for example, y).
" The cnoremap causes Tab to cancel any command that was entered.
" The first inoremap causes Tab to exit insert mode, and the `^ restores the cursor position so exiting insert does not move the cursor left.

" Copy the current buffer's path to the clipboard
" nnoremap cp :let @+ = expand("%")<CR>

" Plugins
call plug#begin(stdpath('data') . '/plugged')
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
" Make sure you use single quotes

Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter' " Don't use vim-signify if you are using gitgutter
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'preservim/nerdtree'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Preferred for dark backgrounds: gruvbox, desert, PaperColor
" Preferred for light backgrounds: PaperColor
" Everything else that I tried was 'meh' in terms of readability and contrast
" Plug 'sonph/onehalf' "Colorscheme
Plug 'wuelnerdotexe/vim-enfocado' "Colorscheme
" For the 'vim-gruvbox8' plug-in there are several options: colorscheme gruvbox8_soft/gruvbox8_hard/gruvbox8
Plug 'lifepillar/vim-gruvbox8' "Colorscheme
Plug 'morhetz/gruvbox' "Colorscheme
Plug 'NLKNguyen/papercolor-theme' "Colorscheme
" Plug 'rakr/vim-one' "Colorscheme
" Plug 'arzg/vim-colors-xcode' "Colorscheme

Plug 'ap/vim-buftabline' " Show buffers in the tab line.
Plug 'farmergreg/vim-lastplace' " Reopen files at last edit position.
Plug 'junegunn/fzf.vim' " Fuzzy finder commands using fzf.
Plug 'liuchengxu/vim-which-key' " Show possible leader completions.
Plug 'majutsushi/tagbar' " Sidebar ctag browser.
Plug 'mbbill/undotree' " Sidebar undo branch browser.
Plug 'mhinz/vim-startify' " Extendable start screen.
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing white space.
Plug 'tpope/vim-fugitive' " Vim git porcelain.
Plug 'tpope/vim-surround' " Adds surrounding text object.
Plug 'tpope/vim-vinegar' " Improve netrw.
Plug 'vim-utils/vim-man' " Open man pages in Vim.
Plug 'w0rp/ale' " Lint engine and LSP client.

" Initialize plugin system
call plug#end()

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" It is important to define the colorscheme after the Plugins section
set background=light
colorscheme PaperColor

