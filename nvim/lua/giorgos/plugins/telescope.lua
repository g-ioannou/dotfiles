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
				file_ignore_patterns = { "env/", "venv/", ".cache/", "node_modules/", ".git/", ".venv/", ".env/" },
				hidden = true,
				no_ignore = true,
			})
		end, {})

		vim.keymap.set("n", "<C-g>", builtin.live_grep, {})

		vim.keymap.set("n", "<C-f>", function()
			builtin.current_buffer_fuzzy_find()
		end, {})

		vim.keymap.set("n", "<C-b>", builtin.buffers, {})
		vim.keymap.set("n", "<C-f>", builtin.git_files, {})

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			},
		})

		telescope.load_extension("fzf")
	end,
}
