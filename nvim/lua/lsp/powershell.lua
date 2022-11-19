require'lspconfig'.powershell_es.setup{
    bundle_path = 'c:/tools/PowerShellEditorServices',
    filetypes = { "ps1", "psm1", "psd1" },
}
