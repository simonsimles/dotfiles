require'lspconfig'.gopls.setup{
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = require'lspconfig/util'.root_pattern("go.work", "go.mod", ".git"),
    capabilities = capabilities,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
    on_attach = on_attach
}
