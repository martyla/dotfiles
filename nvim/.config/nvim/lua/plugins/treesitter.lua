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

        local parsers = {
            'bash', 'c', 'cpp', 'css', 'html', 'java', 'javascript', 'json',
            'lua', 'proto', 'python', 'regex', 'rust', 'toml', 'tsx',
            'typescript', 'yaml', 'zig', 'zsh',
        }

        local function start(buf)
            pcall(vim.treesitter.start, buf)
        end

        vim.api.nvim_create_autocmd('FileType', {
            callback = function(args) start(args.buf) end,
        })

        -- Install is async; once done, enable highlighting in buffers opened meanwhile
        ts.install(parsers):await(vim.schedule_wrap(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) then
                    start(buf)
                end
            end
        end))
    end
}
