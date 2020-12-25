if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -sSfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

if has('nvim')
  " Neovim is already sane
  let g:polyglot_disabled = ['sensible']
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'rakr/vim-one'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-sleuth'
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-signify'
Plug 'sheerun/vim-polyglot'
Plug 'wakatime/vim-wakatime'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-eunuch'
Plug 'terryma/vim-multiple-cursors'
Plug 'nathangrigg/vim-beancount'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'dhruvasagar/vim-zoom'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'wellle/targets.vim'
Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'mbbill/undotree'
Plug 'janko/vim-test'
Plug 'tpope/vim-endwise', { 'for': ['lua', 'ruby', 'vim', 'sh', 'zsh', 'make'] }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:one_allow_italics = 1
set bg=dark
colorscheme one

set updatetime=300
set hidden
set cmdheight=2
set signcolumn=yes
set ignorecase
set smartcase
set colorcolumn=121
set scrolloff=5
set sidescrolloff=5
set spelllang=en_gb

set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

let &undodir=stdpath('data') . '/undo'
set undofile
set undolevels=5000

" Exit terminal with Esc
tnoremap <Esc> <C-\><C-n>
nnoremap ; :

let mapleader=','
nnoremap <silent> <leader>, :FZF<cr>
nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>h :History<cr>
nnoremap <silent> <leader>l :Lines<cr>
nnoremap <silent> <leader>r :Rg<cr>
nnoremap <silent> <leader>sd :SignifyDiff<cr>
nnoremap <silent> <leader>sp :SignifyHunkDiff<cr>
nnoremap <silent> <leader>ss :setlocal spell!<cr>
nnoremap <silent> <leader>su :SignifyHunkUndo<cr>
nnoremap <silent> <leader>tf :TestFile<cr>
nnoremap <silent> <leader>tn :tabnew<cr>
nnoremap <silent> <leader>tt :TestNearest<cr>
nnoremap <silent> <leader>u :UndotreeToggle<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:coc_global_extensions = [ 'coc-json', 'coc-python', 'coc-html', 'coc-css', 'coc-phpls', 'coc-yaml', 'coc-solargraph' ]

" let g:deoplete#enable_at_startup = 1

let g:lightline = {
  \  'colorscheme': 'one',
  \  'active': {
  \    'left': [
  \      [ 'mode', 'paste' ],
  \      [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \    ],
  \    'right': [
  \      [ 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \      [ 'percent', 'lineinfo' ],
  \      [ 'fileformat', 'fileencoding', 'filetype' ]
  \    ]
  \  },
  \  'component_function': {
  \    'gitbranch': 'fugitive#head',
  \  },
  \  'component_expand': {
  \    'linter_warnings': 'lightline#ale#warnings',
  \    'linter_errors': 'lightline#ale#errors',
  \    'linter_ok': 'lightline#ale#ok'
  \  },
  \  'component_type': {
  \    'linter_warnings': 'warning',
  \    'linter_errors': 'error',
  \    'linter_ok': 'left'
  \  }
  \}

" Hide status bar etc when calling FZF
autocmd! FileType fzf
autocmd FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1

let g:indentLine_faster = 1
let g:indentLine_setConceal = 0

let g:undotree_WindowLayout = 40

let test#strategy = "neovim"
