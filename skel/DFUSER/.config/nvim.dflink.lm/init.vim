"
" PLUGIN SETUP
"

" Install vim-plug if it isn't already installed.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'machakann/vim-highlightedyank'
Plug 'godlygeek/tabular'
Plug 'kshenoy/vim-signature'
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim' " this is required for ranger.vim
Plug 'sheerun/vim-polyglot'
Plug 'plasticboy/vim-markdown'
Plug 'junegunn/vim-easy-align'
Plug 'jremmen/vim-ripgrep'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'arcticicestudio/nord-vim'

call plug#end()

"
" PLUGIN CONFIGURATION
"

" Don't automatically fold markdown files.
let g:vim_markdown_folding_disabled = 1

" airline configuration
let g:airline#extensions#tabline#enabled = 1

" Use `fd` with ctrlp
let g:ctrlp_user_command = 'fdfind . -t f %s'

" Open ranger instead of netrw on directories.
let g:ranger_replace_netrw = 1

" CoC
source ~/.config/nvim/coc.vim

"
" VIM CONFIGURATION
"

set expandtab
set softtabstop=2
set shiftwidth=2
set tabstop=2
set incsearch
set smartcase
set cursorline
set number
set relativenumber
set updatetime=500
set signcolumn=yes
set wildignore=*/log/**,*/node_modules/**,*/target/**,*/tmp/**,*.rbc
" Show whitespace
set list
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:┐,precedes:«,extends:» " ¶

"
" VIM UI
"

colorscheme nord
" Make the Sign Column background transparent.
highlight clear SignColumn
" Font (for GUI apps)
set guifont=Ubuntu\ Mono:h22

"
" SWAPFILES
"

" Put all swapfiles in a common directory (makes using b2 easier as well)
silent !mkdir -p ~/.vim/backup ~/.vim/swap ~/.vim/undo
" The double trailing slash tells vim to avoid name collisions.
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

"Switch between different windows by their direction
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"
" SYNTAX CONFIGURATION
"

" markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell

