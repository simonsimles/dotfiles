local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

require'lspconfig'.tsserver.setup{}

require('lsp.powershell')
require('lsp.kotlin')
require('lsp.gopls')
require('lsp.html')
require('lsp.jsonls')
require('lsp.eslint')

require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers {
    function (server_name)
      lspconfig[server_name].setup {}
    end,
    ["terraformls"] = function ()
        lspconfig.terraformls.setup {
            cmd = {vim.fn.exepath("terraform-ls")}
        }
    end,
    ["tflint"] = function()
        lspconfig.tflint.setup {
            cmd = {vim.fn.exepath("tflint")}
        }
    end,
}
