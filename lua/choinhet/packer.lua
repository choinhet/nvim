vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use({
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    })

    use({ 'nvim-treesitter/nvim-treesitter' }, { run = ':TSUpdate' })
    use({ 'mg979/vim-visual-multi' }, { branch = 'master' })
    use({ 'theprimeagen/harpoon' })
    use({ 'tpope/vim-surround' })
    use({ 'williamboman/mason.nvim' })
    use({ 'williamboman/mason-lspconfig.nvim' })
    use({ 'neovim/nvim-lspconfig' })
    use({ 'hrsh7th/nvim-cmp' })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'L3MON4D3/LuaSnip' })
end)
