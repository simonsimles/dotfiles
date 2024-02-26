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

require("lazy").setup({
	
	'kyazdani42/nvim-web-devicons',
	'kyazdani42/nvim-tree.lua',

	'feline-nvim/feline.nvim',

	'nvim-lua/plenary.nvim',
	'lewis6991/gitsigns.nvim',
	'nvim-telescope/telescope.nvim',

	'ellisonleao/glow.nvim',

	{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

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


	{'glacambre/firenvim', build = function() vim.fn['firenvim#install'](0) end },
})
