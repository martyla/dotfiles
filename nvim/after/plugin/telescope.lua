local builtin = require('telescope.builtin')

-- cache results of this.
local is_inside_work_tree = {}
function project_files()
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    builtin.git_files({ show_untracked = true })
  else
    builtin.find_files()
  end
end

vim.keymap.set('n', '<leader>pf', project_files, {})
vim.keymap.set('n', '<C-p>', project_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep: ") });
end)
