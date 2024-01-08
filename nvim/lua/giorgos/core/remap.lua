vim.g.mapleader = " "

vim.keymap.set("i", ";;", "<Esc>")

vim.keymap.set("n", "<Esc>", vim.cmd([[noh]]))

vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>h", "<C-w>h")

vim.keymap.set("n", "<leader>wq", vim.cmd.q, { noremap = true })
vim.keymap.set("n", "<leader>ww", vim.cmd.w, { noremap = true })
vim.keymap.set("n", "<leader>wQ", function()
	vim.cmd("q!")
end, { noremap = true })

vim.keymap.set("n", "<leader>wv", function()
	vim.cmd([[vnew]])
	vim.cmd([[Telescope find_files]])
end, { noremap = true })

vim.keymap.set("n", "<leader>wh", function()
	vim.cmd([[new]])
	vim.cmd([[Telescope find_files]])
end, { noremap = true })

vim.keymap.set("n", "<leader>ws", function()
	vim.ui.input({ prompt = "Filename: " }, function(input)
		vim.cmd(string.format(":save %s", input))
	end)
end, { noremap = true })

vim.keymap.set("n", "<leader>+", "<C-w>5+")
vim.keymap.set("n", "<leader>-", "<C-w>5-")
vim.keymap.set("n", "<leader>.", "<C-w>5>")
vim.keymap.set("n", "<leader>,", "<C-w>5<")

-- move highlighted selection using J,K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
