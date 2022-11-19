local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

require'lspconfig'.eslint.setup{
    cmd = {"powershell", "vscode-html-language-server.ps1", "--stdio" },
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
}
