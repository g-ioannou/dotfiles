vim.g.mapleader = " "

vim.keymap.set("i", ";;", "<Esc>")

vim.keymap.set("n", "<Esc>", vim.cmd([[noh]]))

vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>h", "<C-w>h")

vim.keymap.set("n", "<C-w>", vim.cmd.q, { noremap = true })
vim.keymap.set("n", "<C-s>", vim.cmd.w, { noremap = true })

vim.keymap.set("n", "<C-d>", function()
	vim.cmd([[vnew]])

	require("telescope.builtin").find_files({
		file_ignore_patterns = { "node_modules/", ".git/", ".venv/", ".env/" },
		hidden = true,
		no_ignore = true,
	})
end, { noremap = true })

vim.keymap.set("n", "<C-a>", function()
	vim.cmd([[new]])

	require("telescope.builtin").find_files({
		file_ignore_patterns = { "node_modules/", ".git/", ".venv/", ".env/" },
		hidden = true,
		no_ignore = true,
	})
end, { noremap = true })

vim.keymap.set("n", "<leader>+", "<C-w>5+")
vim.keymap.set("n", "<leader>-", "<C-w>5-")
vim.keymap.set("n", "<leader>.", "<C-w>5>")
vim.keymap.set("n", "<leader>,", "<C-w>5<")

-- move highlighted selection using J,K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
