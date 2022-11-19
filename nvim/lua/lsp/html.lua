require'lspconfig'.html.setup{
    cmd = {"powershell", "vscode-html-language-server.ps1", "--stdio" },
    filetypes = { "html", "xhtml" },
    capabilities = capabilities,
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      },
      provideFormatter = true
    }
}

