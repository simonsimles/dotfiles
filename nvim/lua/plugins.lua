vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

use 'wbthomason/packer.nvim'

use 'kyazdani42/nvim-web-devicons'
use 'kyazdani42/nvim-tree.lua'

use 'feline-nvim/feline.nvim'

use 'nvim-lua/plenary.nvim'
use 'lewis6991/gitsigns.nvim'
use 'nvim-telescope/telescope.nvim'

use 'ellisonleao/glow.nvim'

use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

use 'neovim/nvim-lspconfig'
use 'williamboman/mason.nvim'
use 'williamboman/mason-lspconfig.nvim'
use 'scalameta/nvim-metals'

use 'hrsh7th/cmp-nvim-lsp'
use 'hrsh7th/cmp-buffer'
use 'hrsh7th/cmp-path'
use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-vsnip'
use 'hrsh7th/vim-vsnip'


use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end 
}

end)
