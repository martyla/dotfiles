vim.g.mapleader = ","

-- Buffer nav
vim.keymap.set("n", "[b", ":bprev<CR>")
vim.keymap.set("n", "]b", ":bnext<CR>")

-- Window splits
vim.keymap.set("n", "ts", ":split<CR>")
vim.keymap.set("n", "tv", ":vsplit<CR>")
vim.keymap.set("n", "th", ":wincmd h<CR>")
vim.keymap.set("n", "tj", ":wincmd j<CR>")
vim.keymap.set("n", "tk", ":wincmd k<CR>")
vim.keymap.set("n", "tl", ":wincmd l<CR>")

-- Quickly leave insert mode
vim.keymap.set("i", "hh", "<esc>")

-- Remove highlighting
vim.keymap.set("", "<leader>m", ":noh<CR>")
