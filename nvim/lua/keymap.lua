if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.api.nvim_set_keymap('', '<C-z>', ':terminal<return>', {noremap = true})
    vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})
end

vim.cmd([[let mapleader = ","]])

local mapk = vim.api.nvim_set_keymap

mapk('', '<C-j>', '<C-W>j', {})
mapk('', '<C-k>', '<C-W>k', {})
mapk('', '<C-h>', '<C-W>h', {})
mapk('', '<C-l>', '<C-W>l', {})

--vim.cmd([[inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"]])
--vim.cmd([[inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

mapk('', '<Space>', '/', {})

mapk('n', '<leader>k', ':NvimTreeToggle<CR>', {})

mapk('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true})
mapk('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
mapk('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true})
mapk('n', '<leader>gf', '<cmd>Telescope git_files<cr>', {noremap = true})
mapk('n', '<leader>fd', '<cmd>Telescope lsp_definitions<cr>', {noremap = true})
mapk('n', '<leader>fr', '<cmd>Telescope lsp_references<cr>', {noremap = true})
mapk('n', '<leader>fp', '<cmd>Telescope lsp_document_diagnostics<cr>', {noremap = true})
mapk('n', '<leader>fa', '<cmd>Telescope lsp_document_symbols<cr>', {noremap = true})
mapk('n', '<leader>ft', '<cmd>Telescope treesitter<cr>', {noremap = true})

mapk('n', '<leader>gD', '<cmd>lua vim.lsp.buf.definition()<cr>', {noremap = true})
mapk('n', '<leader>gq', '<cmd>lua vim.lsp.buf.format()<cr>', {noremap = true})
mapk('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', {noremap = true})
mapk('n', '<leader>H', '<cmd>lua vim.lsp.buf.hover()<cr>', {noremap = true})

mapk('n', '<leader>m', '<cmd>lua require("telescope").extensions.metals.commands()<cr>', {noremap=true})

mapk('n', '<leader>nn', '<cmd>SNotesNew<cr>', {noremap = true})
mapk('n', '<leader>ns', '<cmd>SNotesSearch<cr>', {noremap = true})
mapk('n', '<leader>no', '<cmd>SNotesOpen<cr>', {noremap = true})

