return {
    'chriskempson/base16-vim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd('colorscheme base16-monokai')
    end
}
