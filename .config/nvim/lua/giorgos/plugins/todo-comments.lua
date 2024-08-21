return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		highlight = {
			pattern = [[.*<(KEYWORDS)\s*]],
		},
		search = {
			command = "rg",
			args = {
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--no-ignore-vcs",
			},
		},
	},
	config = function(_, opts)
		require("todo-comments").setup(opts)

		vim.keymap.set("n", "<leader>c", function()
			vim.cmd([[TodoTelescope keywords=TODO]])
		end)
	end,
}
