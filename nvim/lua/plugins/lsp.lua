return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/nvim-cmp',
    },
    config = function()
        local cmp = require('cmp')

        -- This is where you enable features that only work
        -- if there is a language server active in the file
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }
                vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'gs', function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "gra", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set({"n", "i"}, "<C-s>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>l', function() vim.lsp.buf.format({ async = true }) end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            end,
        })

        -- Mason manages installation of language servers
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'eslint', 'lua_ls', 'jdtls', 'rust_analyzer', 'zls' },
            handlers = {
                -- default handler (applies when no custom handler)
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,

                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { 'vim' }
                                }
                            }
                        }
                    })
                end,
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        cmp.setup({
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
            },
            snippet = {
                expand = function(args)
                    -- You need Neovim v0.10 to use vim.snippet
                    vim.snippet.expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
        })
    end
}
