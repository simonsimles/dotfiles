local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

vim.lsp.enable('ts_ls')

vim.lsp.config('powershell_es', {
    bundle_path = 'C:/Users/d91069/Documents/Powershell/Modules',
    filetypes = { "ps1", "psm1", "psd1" },
})
vim.lsp.enable('powershell_es')

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end
vim.lsp.config('eslint', {
    cmd = {"powershell", "vscode-html-language-server.ps1", "--stdio" },
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        }
    }
})
vim.lsp.enable('eslint')

vim.lsp.config('go', {
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
})
vim.lsp.enable('go')

vim.lsp.config('html', {
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
})
vim.lsp.enable('html')

vim.lsp.config('jsonls', {
    cmd = {"powershell", "vscode-html-language-server.ps1", "--stdio" },
    capabilities = capabilities,
    init_options = {
      provideFormatter = true
    },
    single_file_support = true
})
vim.lsp.enable('jsonls')

vim.lsp.enable('kotlin_language_server')

local lspconfig = vim.lsp.config
require("mason").setup()
require("mason-lspconfig").setup {
    handlers = {
        function(server_name)
            lspconfig[server_name].setup {}
        end,
        ["terraformls"] = function()
            lspconfig('terraformls', {
                cmd = { vim.fn.exepath("terraform-ls"), "serve" }
            })
        end,
        ["tflint"] = function()
            lspconfig('tflint', {
                cmd = { vim.fn.exepath("tflint"), "--langserver" }
            })
        end,
        ["lua_ls"] = function()
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            lspconfig('lua_ls', {
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
}

vim.lsp.config('nushell', {
    cmd = { "nu", "--lsp" },
    filetypes = { "nu" },
})
vim.lsp.enable('nushell')
