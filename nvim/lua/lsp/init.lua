local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

require'lspconfig'.ts_ls.setup{}

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
            cmd = {vim.fn.exepath("terraform-ls"), "serve"}
        }
    end,
    ["tflint"] = function()
        lspconfig.tflint.setup {
            cmd = {vim.fn.exepath("tflint"), "--langserver"}
        }
    end,
    ["lua_ls"] = function()
        local runtime_path = vim.split(package.path, ";")
        table.insert(runtime_path, "lua/?.lua")
        table.insert(runtime_path, "lua/?/init.lua")

        lspconfig.lua_ls.setup({
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = runtime_path,
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end
}
