return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local ok, ts = pcall(require, 'nvim-treesitter')
        if not ok or not ts.install then
            vim.notify('nvim-treesitter main not ready, run :Lazy update then restart', vim.log.levels.WARN)
            return
        end

        local parsers = { 'java', 'javascript', 'typescript', 'c', 'lua', 'rust', 'zig', 'vim', 'vimdoc' }

        ts.install(parsers)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = vim.iter(parsers)
                :map(function(p) return vim.treesitter.language.get_filetypes(p) end)
                :flatten()
                :totable(),
            callback = function(args)
                -- Parser installation can still be running on first launch.
                pcall(vim.treesitter.start, args.buf)
            end,
        })
    end,
}
