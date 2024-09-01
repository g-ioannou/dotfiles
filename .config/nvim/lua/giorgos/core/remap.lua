vim.g.mapleader = " "

pcall(function()
	vim.keymap.del("n", "<C-w><C-d>")
	vim.keymap.del("n", "<C-w>d")
end)

vim.keymap.set("n", "<leader>q", vim.cmd.q, { noremap = true })

vim.keymap.set("n", "<leader>w", vim.cmd.w, { noremap = true })

vim.keymap.set("n", "<leader>=", "<C-w>10+")
vim.keymap.set("n", "<leader>-", "<C-w>10-")
vim.keymap.set("n", "<leader>.", "<C-w>10>")
vim.keymap.set("n", "<leader>,", "<C-w>10<")

-- move highlighted selection using J,K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- navigation in insert mode
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-h>", "<Left>")
