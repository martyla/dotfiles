return {
    'ibhagwan/fzf-lua',
    dependencies = {
        { "junegunn/fzf", build = "./install --bin" },
    },
    config = function()
        local fzf = require('fzf-lua');
        local setup_opts = { 'default' }
        if vim.fn.executable('fd') == 1 then
            setup_opts.files = { cmd = "fd --type f --hidden --exclude .git" }
        elseif vim.fn.executable('rg') == 1 then
            setup_opts.files = { cmd = "rg --files --hidden --glob '!.git'" }
        end
        fzf.setup(setup_opts)

        vim.keymap.set('n', '<C-p>', fzf.files, { silent = true })
        vim.keymap.set('n', '<C-g>', fzf.grep, { silent = true })
    end
}
