return {
	{
		"nvim-telescope/telescope.nvim",
		bdranch = "0.1.x",
		dependencies = {
			{
				"nvim-telescope/telescope-file-browser.nvim",
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
			local actions = require("telescope.actions")
			local builtin = require("telescope.builtin")
			local fb_actions = require("telescope._extensions.file_browser.actions")

			telescope.setup({
				defaults = {
					theme = "center",
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
					},
				},
				extensions = {
					file_browser = {
						path = vim.loop.cwd(),
						cwd = vim.loop.cwd(),
						cwd_to_path = false,
						grouped = true,
						files = true,
						add_dirs = true,
						depth = 1,
						select_buffer = false,
						hidden = { file_browser = true, folder_browser = true },
						respect_gitignore = vim.fn.executable("fd") == 1,
						no_ignore = true,
						follow_symlinks = true,
						browse_files = require("telescope._extensions.file_browser.finders").browse_files,
						browse_folders = require("telescope._extensions.file_browser.finders").browse_folders,
						hide_parent_dir = true,
						collapse_dirs = true,
						prompt_path = false,
						quiet = false,
						dir_icon = "",
						dir_icon_hl = "Default",
						display_stat = { date = true, size = true, mode = true },
						hijack_netrw = true,
						use_fd = true,
						git_status = true,
						mappings = {
							["i"] = {
								["<A-c>"] = fb_actions.create,
								["<S-CR>"] = fb_actions.create_from_prompt,
								["<A-r>"] = fb_actions.rename,
								["<A-m>"] = fb_actions.move,
								["<A-y>"] = fb_actions.copy,
								["<A-d>"] = fb_actions.remove,
								["<C-o>"] = fb_actions.open,
								["<C-g>"] = fb_actions.goto_parent_dir,
								["<C-e>"] = fb_actions.goto_home_dir,
								["<C-w>"] = fb_actions.goto_cwd,
								["<C-t>"] = fb_actions.change_cwd,
								["<C-f>"] = fb_actions.toggle_browser,
								["<C-h>"] = fb_actions.toggle_hidden,
								["<C-s>"] = fb_actions.toggle_all,
								["<bs>"] = fb_actions.backspace,
							},
							["n"] = {
								["a"] = fb_actions.create,
								["r"] = fb_actions.rename,
								["x"] = fb_actions.move,
								["y"] = fb_actions.copy,
								["d"] = fb_actions.remove,
								["o"] = fb_actions.open,
								["-"] = fb_actions.goto_parent_dir,
								["~"] = fb_actions.goto_home_dir,
								["w"] = fb_actions.goto_cwd,
								["t"] = fb_actions.change_cwd,
								["f"] = fb_actions.toggle_browser,
								["h"] = fb_actions.toggle_hidden,
								["s"] = fb_actions.toggle_all,
							},
						},
					},
				},
			})

			local utils = require("telescope.utils")

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
						"docker-data/",
					},
					cwd = vim.fn.getcwd(),
					hidden = true,
					no_ignore = true,
				})
			end, {})

			vim.keymap.set("n", "<C-g>", builtin.live_grep, {})

			vim.keymap.set("n", "<C-f>", builtin.git_files, {})

			vim.keymap.set("n", "<C-b>", function()
				telescope.extensions.file_browser.file_browser()
			end)

			telescope.load_extension("fzf")
			telescope.load_extension("harpoon")
			telescope.load_extension("file_browser")
		end,
	},
}
