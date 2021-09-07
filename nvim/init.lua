vim.cmd [[source ~/.vimrc]]

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
}


require'lspconfig'.powershell_es.setup{
  bundle_path = 'c:/tools/PowerShellEditorServices',
}

require'lspconfig'.kotlin_language_server.setup{}

require'nvim-tree'.setup {
    update_focused_fie = {
        update_cwd = false
    },
    filters = {
        custom = {
            '.git', 'node_modules', '.cache'
        }
    }
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
