return {
	"AckslD/nvim-neoclip.lua",
	dependencies = {
		{ "kkharji/sqlite.lua", module = "sqlite" },
		{ "nvim-telescope/telescope.nvim" },
	},
	config = function()
		require("neoclip").setup()

		vim.keymap.set("n", "<Leader>sv", function()
			vim.cmd([[Telescope neoclip]])
		end, { noremap = true })
	end,
}
