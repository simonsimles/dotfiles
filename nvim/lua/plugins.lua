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

    'kyazdani42/nvim-web-devicons',
    'kyazdani42/nvim-tree.lua',

    'feline-nvim/feline.nvim',

    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'lewis6991/gitsigns.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-telescope/telescope-media-files.nvim',
    'nvim-telescope/telescope-ui-select.nvim',

    'ellisonleao/glow.nvim',

    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'scalameta/nvim-metals',

    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/vim-vsnip',


    {
        'glacambre/firenvim',
        lazy = not vim.g.started_by_firenvim,
        build = function()
            vim.fn['firenvim#install'](0)
        end
    },

    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {}
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
        config = function()
            vim.cmd("Copilot disable")
        end,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = { "github/copilot.vim" },
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
    shell = 'nu',--'pwsh.exe',
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


