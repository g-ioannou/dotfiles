return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeOpenedFolderName guifg=#A07ED8 ]])
		vim.cmd([[ highlight NvimTreeFolderName guifg=#A07ED8 ]])

		vim.cmd([[ highlight NvimTreeGitIgnored guifg=#7a7a7a ]])
		vim.cmd([[ highlight NvimTreeGitUnstagged guifg=#E6E6E6 ]])
		vim.cmd([[ highlight NvimTreeGitStaged guifg=#00FF00 ]])
		vim.cmd([[ highlight NvimTreeGitDirty guifg=#90C6EE ]])

		-- configure nvim-tree
		nvimtree.setup({
			reload_on_bufenter = true,
			view = {
				width = 35,
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = false,
						git = true,
					},
					glyphs = {
						git = {
							unstaged = "M",
							staged = "S",
							unmerged = "",
							renamed = "R",
							untracked = "U",
							deleted = "D",
							ignored = "I",
						},
					},
					git_placement = "after",
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>")
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>")
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>")
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>")
		keymap.set("n", "<leader>eq", "<cmd>NvimTreeClose<CR>")
	end,
}
