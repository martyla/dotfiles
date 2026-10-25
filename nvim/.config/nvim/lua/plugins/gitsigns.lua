return {
    'lewis6991/gitsigns.nvim',
    opts = {
        on_attach = function(bufnr)
            local gs = require('gitsigns')
            local opts = { buffer = bufnr }

            -- native ]c / [c in diff mode
            vim.keymap.set('n', ']c', function()
                if vim.wo.diff then vim.cmd.normal({ ']c', bang = true }) else gs.nav_hunk('next') end
            end, opts)
            vim.keymap.set('n', '[c', function()
                if vim.wo.diff then vim.cmd.normal({ '[c', bang = true }) else gs.nav_hunk('prev') end
            end, opts)

            vim.keymap.set('n', '<leader>hs', gs.stage_hunk, opts)
            vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, opts)
            vim.keymap.set('n', '<leader>hu', gs.reset_hunk, opts)
            vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
        end,
    },
}
