vim.opt.guicursor = ""

-- Update title automatically to reflect file name
vim.opt.title = true

-- Line & relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autoread = true

vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.joinspaces = false
vim.opt.foldenable = false

vim.opt.ruler = true
vim.opt.scrolloff = 10

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes:1"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undo"
vim.opt.undofile = true
