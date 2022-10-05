set nobackup
set nowb
set noswapfile
set updatecount=0

set history=1000
set textwidth=80

set backspace=eol,start,indent
set clipboard=unnamed,unnamedplus
set mouse=a

set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic

set noerrorbells
set novisualbell
set timeoutlen=500

set number
set wrap
set wrapmargin=8
set linebreak
set autoindent
set ttyfast

set laststatus=2
set scrolloff=7
set wildmenu
set showcmd

set cmdheight=1
set title
set showmatch
set mat=2
set updatetime=300

"set listchars=tab:>·,trail:·
set listchars=trail:·,tab:▸▸
set list

set wildignore=*.o,*~,*.pyc

if has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
    if !empty(glob("C:/Program\ Files/PowerShell/7/pwsh.exe"))
        set shell=\"C:/Program\ Files/PowerShell/7/pwsh.exe\"
        set shellcmdflag=-Command
    else
        set shell=powershell.exe
        set shellquote=\"
        set shellcmdflag=-NoProfile
    endif
    set shellxquote=

    noremap <C-z> :terminal<return>
    tnoremap <Esc> <C-\><C-n>
endif

set autoread
au FocusGained,BufEnter * checktime

set ruler
set hid
set whichwrap+=<,>,h,l

set foldcolumn=1
syntax enable
set encoding=utf8
set ffs=unix,dos,mac

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set ai "Auto indent
set si "Smart indent

set termguicolors

let mapleader = ","
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
map <Space> /

try
    colorscheme desert
catch
endtry
set background=dark
hi Pmenu guifg=white guibg=grey10
hi NonText gui=italic guibg=grey20 guifg=grey40

if has('nvim')
    "call functions#PlugLoad()
    call plug#begin("~/AppData/Local/nvim/plugged")
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'

    Plug 'feline-nvim/feline.nvim'

    Plug 'lewis6991/gitsigns.nvim'

    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'

    Plug 'ellisonleao/glow.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'

    "Plug 'scrooloose/nerdcommenter'
    "Plug 'sbdchd/neoformat'
    "Plug 'beeender/Comrade'

    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'

    Plug 'scalameta/nvim-metals'

    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    call plug#end()

    set completeopt=menu,menuone,noselect

    let g:nvim_tree_width = 40
    nnoremap <leader>k :NvimTreeToggle<CR>

    if !empty(glob("C:/Python39/python.exe"))
        let g:python3_host_prog=expand("C:\\Python39\\python.exe")
    elseif !empty(glob(expand("~/Python39/python.exe")))
        let g:python3_host_prog=expand("~/Python39/python.exe")
    else
        let g:python3_host_prog=expand("python3")
    endif

    nnoremap <leader>ff <cmd>Telescope find_files<cr>
    nnoremap <leader>fg <cmd>Telescope live_grep<cr>
    nnoremap <leader>fb <cmd>Telescope buffers<cr>
    nnoremap <leader>gf <cmd>Telescope git_files<cr>
    nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>
    nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
    nnoremap <leader>fp <cmd>Telescope lsp_document_diagnostics<cr>
    nnoremap <leader>fa <cmd>Telescope lsp_document_symbols<cr>
    nnoremap <leader>ft <cmd>Telescope treesitter<cr>

    nnoremap <leader>gD <cmd>lua vim.lsp.buf.definition()<cr>
    nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<cr>
    nnoremap <leader>gq <cmd>lua vim.lsp.buf.formatting()<cr>
    nnoremap <leader>H <cmd>lua vim.lsp.buf.hover()<cr>

    command Metal lua require('telescope').extensions.metals.commands()
    nnoremap <leader>m <cmd>Metal<cr>

else
    call plug#begin()
    Plug 'preservim/nerdtree'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'airblade/vim-gitgutter'
    call plug#end()

    nmap <leader>k :NERDTree<cr>

    let g:airline_theme = 'deus'
    let g:airline#extensions#hunks#enabled=1
    let g:airline#extensions#branch#enabled=1
endif

let g:gitgutter_override_sign_column_highlight = 0
highlight clear SignColumn
highlight GitGutterAdd guifg=green
highlight GitGutterChange guifg=yellow
highlight GitGutterDelete guifg=red
highlight GitGutterChangeDelete guifg=orange

filetype plugin on
filetype indent on

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }
