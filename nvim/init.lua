vim.cmd [[source ~/.vimrc]]

require'nvim-web-devicons'.setup({
    default = true,
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.markdown = {
  install_info = {
    url = "~/Documents/github/tree-sitter-markdown",
    files = {"src/parser.c"}
  },
  filetype = "md", -- if filetype does not agrees with parser name
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  git = {
    ignore = true,
  }
}


require'lspconfig'.powershell_es.setup{
    bundle_path = 'c:/tools/PowerShellEditorServices',
    filetypes = { "ps1", "psm1", "psd1" },
}

require'lspconfig'.kotlin_language_server.setup{}

require'nvim-tree'.setup {
    update_focused_file = {
        update_cwd = false
    },
    filters = {
        custom = {
            '.git', 'node_modules', '.cache'
        }
    },
    renderer = {
        highlight_opened_files = "none",
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            }
        }
    },
}


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end
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


require'lspconfig'.jsonls.setup{
    cmd = {"powershell", "vscode-html-language-server.ps1", "--stdio" },
    capabilities = capabilities,
    init_options = {
      provideFormatter = true
    },
    single_file_support = true
}

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

require'lspconfig'.tsserver.setup{}

local cmp = require'cmp'
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
         ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
         ['<CR>'] = cmp.mapping.confirm({ select = true }),
         ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback() -- If you are using vim-endwise, this fallback function will be behaive as the vim-endwise.
            end
          end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      }, {
      { name = 'buffer' },
    })
})

require('gitsigns').setup({
    numhl = true
})

require'statusline'

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

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
      require("metals").initialize_or_attach({})
    end,
    group = nvim_metals_group,
  })
local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
