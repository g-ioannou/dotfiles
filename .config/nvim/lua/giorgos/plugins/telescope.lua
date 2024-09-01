return {
	{
		"nvim-telescope/telescope.nvim",
		bdranch = "0.1.x",
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			local file_ignore_patterns = {
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
				"docker-data/",
			}

			telescope.setup({
				defaults = {
					theme = "center",
					sorting_strategy = "ascending",
					file_ignore_patterns = file_ignore_patterns,
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
					},
				},
			})

			local find_files_opts = {
				hidden = true,
				no_ignore = true,
			}
			vim.keymap.set("n", "<leader>p", function()
				builtin.find_files(find_files_opts)
			end, {})

			vim.keymap.set("n", "<leader>P", builtin.git_files, {})

			vim.keymap.set("n", "<leader>g", builtin.live_grep, {})

			vim.keymap.set("n", "<leader>s", function()
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_ivy({ previewer = false }))
			end, {})

			vim.keymap.set("n", "<C-d>", function()
				vim.cmd([[vnew]])
				require("telescope.builtin").find_files(find_files_opts)
			end, { noremap = true })

			vim.keymap.set("n", "<C-a>", function()
				vim.cmd([[new]])
				require("telescope.builtin").find_files(find_files_opts)
			end, { noremap = true })

			telescope.load_extension("fzf")
			telescope.load_extension("harpoon")
		end,
	},
}
