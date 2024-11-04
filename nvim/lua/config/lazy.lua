-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.8',
            dependencies = { 'nvim-lua/plenary.nvim' }
        },
        { 'nvim-treesitter/nvim-treesitter',  build = ':TSUpdate' },
        { 'mbbill/undotree' },
        { 'rhysd/committia.vim' },
        { 'tpope/vim-vinegar' },
        { 'tpope/vim-surround' },
        { 'tpope/vim-fugitive' },
        { 'matze/vim-move' },
        { 'airblade/vim-gitgutter' },

        { 'VonHeikemen/lsp-zero.nvim',        branch = 'v4.x' },
        { 'neovim/nvim-lspconfig' },
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },
        { 'hrsh7th/nvim-cmp' },

        { 'itchyny/lightline.vim' },
        { 'chriskempson/base16-vim' },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "base16-monokai" } },
    -- automatically check for plugin updates
    checker = { enabled = true, notify = false },
})
