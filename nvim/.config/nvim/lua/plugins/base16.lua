return {
    'tinted-theming/base16-vim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd('colorscheme base16-monokai')
        -- theme paints members/properties dim grey (base04)
        vim.api.nvim_set_hl(0, '@variable.member', { link = '@variable' })
    end
}
