"=== vim-plug ===
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'mhinz/vim-signify'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'vim-airline/vim-airline'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'sheerun/vim-polyglot'

Plug 'honza/vim-snippets'

Plug 'ryanoasis/vim-devicons'

Plug 'zhimsel/vim-stay'

Plug 'Konfekt/FastFold'

call plug#end()

autocmd! User nerdtree echom 'NERDTree is now loaded!'
