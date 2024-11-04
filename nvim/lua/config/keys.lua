vim.g.mapleader = ","

vim.keymap.set("n", "<leader>q", ":q<CR>")
vim.keymap.set("n", "<leader>Q", ":wq<CR>")

-- Switch to alternate file
vim.keymap.set("n", "<Tab>", "<C-^><CR>")

vim.keymap.set("n", "ts", ":split<CR>")
vim.keymap.set("n", "tv", ":vsplit<CR>")

vim.keymap.set("n", "th", ":wincmd h<CR>")
vim.keymap.set("n", "tj", ":wincmd j<CR>")
vim.keymap.set("n", "tk", ":wincmd k<CR>")
vim.keymap.set("n", "tl", ":wincmd l<CR>")

vim.keymap.set("i", "hh", "<esc>")
vim.keymap.set("", "<leader>m", ":noh<CR>")
