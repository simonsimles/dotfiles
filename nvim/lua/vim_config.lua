vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.updatecount = 0

vim.opt.history = 1000
vim.opt.textwidth = 120

vim.opt.backspace = 'eol,start,indent'
vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.mouse = 'a'

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.lazyredraw = true
vim.opt.magic = true

vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.timeoutlen = 500

vim.opt.number = true
vim.opt.wrap = true
vim.opt.wrapmargin = 5
vim.opt.linebreak = true
vim.opt.autoindent = true
vim.opt.ttyfast = true

vim.opt.laststatus = 2
vim.opt.scrolloff = 7
vim.opt.wildmenu = true
vim.opt.showcmd = true

vim.opt.cmdheight = 1
vim.opt.title = true
vim.opt.showmatch = true
vim.opt.mat = 2
vim.opt.updatetime = 300

vim.opt.cursorline = true

vim.opt.listchars= 'trail:·,tab:→→'
vim.opt.list = true

vim.opt.wildignore = ''

if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.opt.wildignore = '*.o,*~,*.pyc,.git\\*,.hg\\*,.svn\\*'
    vim.opt.shell = 'pwsh.exe'
    vim.opt.shellcmdflag = '-NoProfile -Command'
    vim.opt.shellxquote = ''
end

vim.opt.autoread = true
vim.api.nvim_create_autocmd({"FocusGained", "BufEnter"}, {pattern = '*', command='checktime'})

vim.opt.ruler = true
vim.opt.hid = true
vim.opt.whichwrap = 'b,s,<,>,h,l'

vim.opt.foldcolumn = '1'

vim.cmd("syntax enable")
vim.opt.encoding = 'utf8'
vim.opt.ffs = 'unix,dos,mac'

vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.ai = true
vim.opt.si = true

vim.opt.termguicolors = true

vim.cmd("colorscheme desert")
vim.opt.background = "dark"
vim.cmd("hi Pmenu guifg=white guibg=grey10")
vim.cmd([[hi NonText guibg=None guifg=black]])

vim.g.gitgutter_override_sign_column_highlight = 0
vim.cmd("highlight clear SignColumn")
vim.cmd("highlight GitGutterAdd guifg=green")
vim.cmd("highlight GitGutterChange guifg=yellow")
vim.cmd("highlight GitGutterDelete guifg=red")
vim.cmd("highlight GitGutterChangeDelete guifg=orange")

vim.opt.completeopt = 'menu,menuone,noselect'

vim.g.python3_host_prog = "C:\\Python39\\python.exe"

vim.cmd("filetype plugin on")
vim.cmd("filetype indent on")

vim.cmd([[
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
]])


