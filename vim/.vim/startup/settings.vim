" Basic
autocmd!

set hidden
set encoding=UTF-8
set backspace=2                             " Backspace behaviour
set nocompatible                            " I don't give a damn about vi compatibility
set mouse=a                                 " Enable Mouse Support
set number                                  " Show Line Numbers
set relativenumber                          " Show Relative Numbers
set wildmenu wildmode=longest:full,full     " WildMode Settings
set wildcharm=<Tab>                         " WildMenu Character
set showcmd                                 " Show Command Keys
set cmdheight=2                             " Command line height
set splitright                              " Open vertical splits on right
set splitbelow                              " Open horizontal splits below

" UI
set list listchars=eol:¬,tab:>-,trail:·     " List characters
set scrolloff=30                            " Set Cursor Position Vertically
set showmatch                               " Show Matching Brackets
set visualbell                              " Use Visual Bell instead of beeping
set t_Co=256                                " Note: Neovim ignores t_Co and other terminal codes.

" Searching
set ignorecase incsearch smartcase hlsearch " Search Options

" Ruler
set ruler                                   " Show Cursor Position Number [row and column number]
set laststatus=2                            " Always Show Statusline
set signcolumn=yes

" Performance
set lazyredraw                              " Enable LazyRedraw
set redrawtime=10000
set cursorline                              " Highlight the line where cursor is
set ttyfast                                 " Enable Fast Terminal Connection
set updatetime=300
set shortmess+=c                            " Don't pass messages to ins-completion-menu

" Undo and Backup
set nobackup noswapfile nowritebackup       " Disable Backup
set undofile undodir=~/vimundo/             " Undo Options

" Tabs & Indentation
set autoindent expandtab smarttab           " Auto-Indentation and Expand Tabs
set shiftwidth=2 tabstop=2                  " Each tab -> 2 spaces

" Autocomplete
set completeopt=menuone,preview,noinsert    " Do not insert text from menu until user selects

" Diff
set diffopt+=iwhiteall
