return {
	"tpope/vim-fugitive",
	config = function()
		vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
		vim.keymap.set("n", "<leader>gd", function()
			vim.cmd([[ Gdiffsplit ]])
		end)
	end,
}
