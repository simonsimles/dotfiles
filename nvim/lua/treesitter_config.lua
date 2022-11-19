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
