local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local is_d_user = string.sub(vim.loop.os_getenv("USERNAME"), 1, 1) == "d"

require("lazy").setup({

    { 'kyazdani42/nvim-web-devicons', lazy = true, module = 'nvim-web-devicons' },
    {
        'kyazdani42/nvim-tree.lua',
        cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
        module = 'nvim-tree',
        config = function()
            require('nvim-tree').setup {}
        end,
    },

    { 'nvim-lualine/lualine.nvim', event = 'VimEnter' },

    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'nvim-lua/popup.nvim', lazy = true },
    { 'lewis6991/gitsigns.nvim', event = 'BufReadPre' },
    { 'nvim-telescope/telescope.nvim', cmd = 'Telescope', module = 'telescope',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function()
          require('telescope').setup {
              extensions = {
                  ["ui-select"] = { require("telescope.themes").get_dropdown() },
                  media_files = { filetypes = { "png", "webp", "jpg", "jpeg", "svg" }, },
              },
          }
          pcall(require('telescope').load_extension, 'media_files')
          pcall(require('telescope').load_extension, 'ui-select')
      end,
    },

    { 'nvim-telescope/telescope-media-files.nvim', after = 'telescope.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim', after = 'telescope.nvim' },

    'ellisonleao/glow.nvim',

    { 'nvim-treesitter/nvim-treesitter', event = 'BufReadPre' },

    { 'neovim/nvim-lspconfig', event = 'BufReadPre' },
    { 'williamboman/mason.nvim', cmd = 'Mason' },
    { 'williamboman/mason-lspconfig.nvim', cmd = 'Mason' },
    { 'scalameta/nvim-metals', ft = { 'scala', 'sbt' }, cmd = 'Metals' },

    { 'hrsh7th/cmp-nvim-lsp', event = 'InsertEnter' },
    { 'hrsh7th/cmp-buffer', event = 'InsertEnter' },
    { 'hrsh7th/cmp-path', event = 'InsertEnter' },
    { 'hrsh7th/nvim-cmp', event = 'InsertEnter' },
    { 'hrsh7th/cmp-vsnip', event = 'InsertEnter' },
    { 'hrsh7th/vim-vsnip', event = 'InsertEnter' },


    {
        'akinsho/toggleterm.nvim',
        version = "*",
        cmd = { 'ToggleTerm', 'ToggleTermToggleAll' },
        opts = { open_mapping = [[<c-t>]], direction = 'float', shell = 'pwsh.exe' },
        config = function(_, opts) require('toggleterm').setup(opts) end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },

    {
        "github/copilot.vim",
        enabled = is_d_user,
        event = 'InsertEnter',
        config = function()
            vim.cmd("Copilot disable")
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = { "github/copilot.vim" },
        cmd = { 'CopilotChat', 'Copilot' },
        opts = {},
    },

    {
        "gennaro-tedesco/nvim-jqx",
        event = { "BufReadPost" },
        ft = { "json", "yaml" },
    },
})

require("toggleterm").setup {
    open_mapping = [[<c-t>]],
    direction = 'float',
    shell = 'pwsh.exe',
}

vim.api.nvim_create_user_command("Copilo",
    function()
        if is_d_user then
            vim.cmd("Copilot enable")
            vim.keymap.set('i', '<C-Left>', '<Plug>(copilot-accept-word)', { noremap = true })
            vim.keymap.set('i', '<C-Right>', 'copilot#Accept("\\<CR>")', {
                noremap = true,
                expr = true,
                replace_keycodes = false,
            })
            vim.keymap.set('i', '<C-Down>', '<Plug>(copilot-next)', { noremap = true })
            vim.keymap.set('i', '<C-Up>', '<Plug>(copilot-previous)', { noremap = true })
            vim.g.copilot_no_tab_map = true
        end
    end,
    { nargs = 0 })

require 'telescope'.setup {
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
                -- even more opts
            }
        },
        media_files = {
            filetypes = { "png", "webp", "jpg", "jpeg", "svg" },
        }
    },
}
require("telescope").load_extension("media_files")
require("telescope").load_extension("ui-select")

