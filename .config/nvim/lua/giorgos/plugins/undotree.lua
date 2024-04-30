return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>uu", function()
			vim.cmd([[UndotreeToggle]])
		end)
	end,
}
