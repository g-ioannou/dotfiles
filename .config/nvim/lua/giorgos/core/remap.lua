vim.g.mapleader = " "

vim.keymap.set("i", ";;", "<Esc>")

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

vim.keymap.set("n", "<leader>+", "<C-w>10+")
vim.keymap.set("n", "<leader>-", "<C-w>10-")
vim.keymap.set("n", "<leader>.", "<C-w>10>")
vim.keymap.set("n", "<leader>,", "<C-w>10<")

-- move highlighted selection using J,K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>sq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
