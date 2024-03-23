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
              fallback()
            end
          end,
         ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
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
