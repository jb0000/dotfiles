vim.cmd([[packadd packer.nvim]])

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    use 'scrooloose/nerdtree'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim'   },
            { 'nvim-lua/plenary.nvim' },
        }
    }


    use 'tpope/vim-commentary'
    use 'tpope/vim-abolish'

    use 'airblade/vim-gitgutter'
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'

    use { 'fatih/vim-go', run = ':GoInstallBinaries' }
    use 'sebdah/vim-delve'

    use 'cakebaker/scss-syntax.vim'
    use 'chr4/nginx.vim'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'

    -- snippets
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'
    use 'onsails/lspkind-nvim'
    use 'rafamadriz/friendly-snippets'

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use 'romainl/vim-cool'
    
    use  'github/copilot.vim'
end)
