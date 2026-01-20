require('plugins')

require('vim_config')

require('keymap')

-- Lazy-load heavy modules to improve startup time
-- Treesitter: load before reading buffer (syntax/highlight)
vim.api.nvim_create_autocmd({'BufReadPre','BufNewFile'}, {
  callback = function()
    pcall(require, 'treesitter_config')
  end,
  once = true,
})

-- LSP: load after a file is opened or FileType is detected
vim.api.nvim_create_autocmd({'BufReadPost','FileType'}, {
  callback = function()
    pcall(require, 'lsp')
    pcall(require, 'metals_config')
  end,
  once = true,
})

-- Completion (nvim-cmp): load on first InsertEnter
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    pcall(require, 'cmp_config')
  end,
  once = true,
})

require('nvimtree')

require'nvim-web-devicons'.setup({default = true,})

require('gitsigns').setup({numhl = true})

require'statusline'

require('file_types')

-- Provide Mason command without eager-loading: load mason when :Mason is executed
vim.api.nvim_create_user_command('Mason', function()
  local ok, mason = pcall(require, 'mason')
  if ok and mason then
    if type(mason.setup) == 'function' then pcall(mason.setup) end
    -- call the original command if installed as plugin
    vim.cmd('Mason')
  else
    print('mason.nvim is not installed or failed to load')
  end
end, { nargs = 0 })

