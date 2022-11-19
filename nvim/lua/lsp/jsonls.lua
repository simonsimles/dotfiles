require'lspconfig'.jsonls.setup{
    cmd = {"powershell", "vscode-html-language-server.ps1", "--stdio" },
    capabilities = capabilities,
    init_options = {
      provideFormatter = true
    },
    single_file_support = true
}
