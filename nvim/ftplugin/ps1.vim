lua<<EOF
require'lspconfig'.powershell_es.setup{
  bundle_path = 'c:/tools/PowerShellEditorServices',
}
EOF

set omnifunc=v:lua.vim.lsp.omnifunc
