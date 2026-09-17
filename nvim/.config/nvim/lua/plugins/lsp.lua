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
        local capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- This is where you enable features that only work
        -- if there is a language server active in the file
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                local opts = { buffer = event.buf }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
                vim.keymap.set({"n", "i"}, "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            end,
        })

        -- Mason manages installation of language servers
        require('mason').setup({})
        require('mason-lspconfig').setup({
            ensure_installed = { 'eslint', 'lua_ls', 'rust_analyzer', 'zls' },
            handlers = {
                -- default handler (applies when no custom handler)
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities,
                    })
                end,

                lua_ls = function()
                    require('lspconfig').lua_ls.setup({
                        capabilities = capabilities,
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
