return {
    'tinted-theming/tinted-vim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd('colorscheme base24-0x96f')
        -- theme paints members/properties dim grey (base04)
        vim.api.nvim_set_hl(0, '@variable.member', { link = '@variable' })
    end
}
