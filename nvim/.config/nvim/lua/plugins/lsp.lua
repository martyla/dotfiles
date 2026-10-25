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

        -- Jump to the next/previous diagnostic and show it in a float
        local function diagnostic_jump(count)
            vim.diagnostic.jump({
                count = count,
                on_jump = function(_, bufnr)
                    vim.diagnostic.open_float({ bufnr = bufnr, scope = 'cursor', focus = false })
                end,
            })
        end

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
                vim.keymap.set("n", "]d", function() diagnostic_jump(1) end, opts)
                vim.keymap.set("n", "[d", function() diagnostic_jump(-1) end, opts)
            end,
        })

        -- Server configuration, merged on top of nvim-lspconfig's defaults
        vim.lsp.config('*', {
            capabilities = capabilities,
        })
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
