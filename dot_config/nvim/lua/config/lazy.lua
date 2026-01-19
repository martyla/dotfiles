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
        -- Update itself
        { "folke/lazy.nvim" },

        -- Simple plugins without configuration
        { 'rhysd/committia.vim' }, -- git commit view
        { 'tpope/vim-vinegar' }, -- improved netrw
        { 'tpope/vim-surround' }, -- manipulate surrounding symbols
        { 'tpope/vim-fugitive' }, -- git commands
        { 'tpope/vim-repeat' }, -- allow repeating plugin commands
        { 'itchyny/lightline.vim' }, -- status bar
        { 'airblade/vim-gitgutter' }, -- git diff in status bar

        -- Plugins with more complicated configurations
        { import = "plugins" },
    },
    -- automatically check for plugin updates, but don't notify
    checker = { notify = false },
    change_detection = { notify = false },
})
