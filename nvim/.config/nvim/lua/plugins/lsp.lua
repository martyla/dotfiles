return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        -- This is where you enable features that only work
        -- if there is a language server active in the file
        -- (gr* mirror neovim defaults, see :h lsp-defaults)
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'x' }, 'gra', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', 'gO', vim.lsp.buf.document_symbol, opts)
                vim.keymap.set({ 'i', 's' }, '<C-s>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = vim.v.count1 }) end, opts)
                vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -vim.v.count1 }) end, opts)
            end,
        })

        -- Show diagnostic float after ]d / [d
        vim.diagnostic.config({
            jump = {
                on_jump = function(_, bufnr)
                    vim.diagnostic.open_float({ bufnr = bufnr, scope = 'cursor', focus = false })
                end,
            },
        })

        -- Server configuration, merged on top of nvim-lspconfig's defaults
        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            }
        })

        -- Mason manages installation of language servers; mason-lspconfig
        -- enables installed servers via vim.lsp.enable() (automatic_enable)
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'basedpyright', 'eslint', 'lua_ls', 'rust_analyzer', 'vtsls', 'zls' },
        })
    end
}
