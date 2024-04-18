return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<C-p>", function()
			builtin.find_files({
				file_ignore_patterns = {
					".cache/",
					"node_modules/",
					"docker-data/",
					".git/",
					".venv/",
					".env/",
					"env/",
					"venv/",
					"build/",
					"dist/",
					".svelte-kit/",
				},
				hidden = true,
				no_ignore = true,
			})
		end, {})

		vim.keymap.set("n", "<C-g>", builtin.live_grep, {})

		vim.keymap.set("n", "<C-f>", builtin.git_files, {})

		telescope.load_extension("fzf")
	end,
}
