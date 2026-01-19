return {
    'ibhagwan/fzf-lua',
    dependencies = {
        { "junegunn/fzf", build = "./install --bin" },
    },
    config = function()
        local fzf = require('fzf-lua');
        fzf.setup({
            'default',
            git = {
                files = {
                    silent = true,
                },
            },
        })

        local is_inside_work_tree = {}
        local function project_files()
            local cwd = vim.fn.getcwd()
            if is_inside_work_tree[cwd] == nil then
                vim.fn.system("git rev-parse --is-inside-work-tree")
                is_inside_work_tree[cwd] = vim.v.shell_error == 0
            end

            if is_inside_work_tree[cwd] then
                fzf.git_files()
            else
                fzf.files()
            end
        end

        vim.keymap.set('n', '<C-p>', project_files, { silent = true })
        vim.keymap.set('n', '<C-g>', fzf.grep, { silent = true })
    end
}
