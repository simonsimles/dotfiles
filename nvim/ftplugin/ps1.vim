lua<<EOF
require'lspconfig'.powershell_es.setup{
    bundle_path = 'C:/Users/d91069/Documents/Powershell/Modules',
}
EOF

set omnifunc=v:lua.vim.lsp.omnifunc
