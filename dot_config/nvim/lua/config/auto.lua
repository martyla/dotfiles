-- Autocmd for autoread to refresh file.
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold' }, {
    callback = function()
        vim.api.nvim_command('checktime')
    end,
})
