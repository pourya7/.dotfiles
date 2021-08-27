"=== vim-plug ===
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'mhinz/vim-signify'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'vim-airline/vim-airline'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'sheerun/vim-polyglot'

Plug 'honza/vim-snippets'

Plug 'cespare/vim-toml', { 'for': 'toml' }

Plug 'ryanoasis/vim-devicons'

Plug 'joshdick/onedark.vim'

call plug#end()

autocmd! User nerdtree echom 'NERDTree is now loaded!'
