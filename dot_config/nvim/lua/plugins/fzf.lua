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
                    cmd = "git ls-files --cached --others --exclude-standard",
                },
            },
        })

        local is_inside_work_tree = {}
        local function project_files()
            local buf_dir = vim.fn.expand('%:p:h')
            if buf_dir == '' then
                buf_dir = vim.fn.getcwd()
            end

            if is_inside_work_tree[buf_dir] == nil then
                vim.fn.system({ "git", "-C", buf_dir, "rev-parse", "--is-inside-work-tree" })
                is_inside_work_tree[buf_dir] = vim.v.shell_error == 0
            end

            if is_inside_work_tree[buf_dir] then
                fzf.git_files()
            else
                fzf.files({ cwd = buf_dir })
            end
        end

        vim.keymap.set('n', '<C-p>', project_files, { silent = true })
        vim.keymap.set('n', '<C-g>', fzf.grep, { silent = true })
    end
}
