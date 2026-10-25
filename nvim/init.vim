"Neovim config, linked to ~/.config/nvim/init.vim by install.sh.
"Only settings that differ from Neovim's defaults (:help nvim-defaults).
set cursorline
"Line numbers and distances
set number relativenumber
"Number of lines offset when jumping
set scrolloff=5
"Highlight matching parentheses, braces, brackets, etc
set showmatch
"Case sensitive if it contains an uppercase
"When 'ignorecase' and 'smartcase' are both on, if a pattern contains an uppercase letter, it is case sensitive, otherwise, it is not.
"For example, '/The' would find only 'The', while '/the' would find 'the' or 'The', etc
set ignorecase smartcase
"Number of columns occupied by a tab
set tabstop=4 softtabstop=4
"Convert tab character to whitespaces
set expandtab
"Try to smartly indent
set smartindent
"Width for autoindents
set shiftwidth=4
"Working directory is always the same as the file you are editing
set autochdir
"Get bash-like tab completions
set wildmode=list:longest,full
set statusline=%F
"Show the file title
set title
"Set clipboard=unnamedplus,unnamed

"Keybindings and remappings
"Backspace and space are to be remapped to something useful
"If you frequently use split windows, you might want to use the Ctrl-W family of commands to switch between windows.
"nnoremap <C-Tab> <C-w>w
"nnoremap <C-S-Tab> <C-w>W

"If you prefer one tab for one buffer, you can map the :tabn and :tabp commands (tab next, and tab previous).
nnoremap <Space> :tabn<CR>

"Remap backspace to Esc (use <C-h> and <C-w> instead (standard))
"nnoremap <BS> <Esc>
"vnoremap <BS> <Esc>gV
"onoremap <BS> <Esc>
"cnoremap <BS> <C-C><Esc>
inoremap jj <Esc>

"Copy the current buffer's path to the clipboard
"nnoremap cp :let @+ = expand("%")<CR>

"Plugins
"Install vim-plug (pinned to a release) on first start, then the plugins below.
let s:plug = stdpath('data') . '/site/autoload/plug.vim'
if empty(glob(s:plug))
  silent execute '!curl -fsSLo ' . shellescape(s:plug) . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/0.14.0/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"coc.nvim is the LSP client; keep ALE to linting so both don't start language servers.
let g:ale_disable_lsp = 1

call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter' "Don't use 'vim-signify' if you are using 'vim-gitgutter'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ap/vim-buftabline' " Show buffers in the tab line.
Plug 'farmergreg/vim-lastplace' " Reopen files at last edit position.
Plug 'junegunn/fzf' " The fzf Vim plugin that fzf.vim builds on; uses the fzf binary from Homebrew.
Plug 'junegunn/fzf.vim' " Fuzzy finder commands using fzf.
Plug 'liuchengxu/vim-which-key' " Show possible leader completions.
Plug 'preservim/tagbar' " Sidebar ctag browser.
Plug 'mbbill/undotree' " Sidebar undo branch browser.
Plug 'mhinz/vim-startify' " Extendable start screen.
Plug 'ntpeters/vim-better-whitespace' " Highlight trailing white space.
Plug 'tpope/vim-fugitive' " Vim git porcelain.
Plug 'tpope/vim-surround' " Adds surrounding text object.
Plug 'tpope/vim-vinegar' " Improve netrw.
Plug 'dense-analysis/ale' " Lint engine.
Plug 'nvim-lua/plenary.nvim' " Required by telescope.
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' } " Highly extendable fuzzy finder over lists
Plug 'dstein64/vim-startuptime' "Different performance metrics for vim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

"No standalone colorscheme plugin: inherit the terminal's ANSI palette
"(the max-contrast "dotfiles" iTerm presets, pure #FFFFFF/#000000)
"so nvim always matches whatever profile the terminal is running.
set background=light
