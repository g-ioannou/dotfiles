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

		local HEIGHT_RATIO = 0.8 -- You can change this
		local WIDTH_RATIO = 0.5 -- You can change this too

		local function on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvimtree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)

			vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
			vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
			vim.keymap.set("n", "<leader>b", "<cmd>NvimTreeToggle<CR>")
		end

		--		vim.api.nvim_create_autocmd("QuitPre", {
		--			callback = function()
		--				local invalid_win = {}
		--				local wins = vim.api.nivm_list_wins()
		--				for _, w in ipairs(wins) do
		--					local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
		--					if bufname:match("NvimTree_") ~= nil then
		--						table.insert(invalid_win, w)
		--					end
		--				end
		--				if #invalid_win == #wins - 1 then
		--					for _, w in ipairs(invalid_win) do
		--						vim.api.nvim_win_close(w, true)
		--					end
		--				end
		--			end,
		--		})

		-- configure nvim-tree
		nvimtree.setup({
			on_attach = on_attach,
			reload_on_bufenter = true,
			view = {
				width = function()
					return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
				end,
				float = {
					enable = true,
					open_win_config = function()
						local screen_w = vim.opt.columns:get()
						local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
						local window_w = screen_w * WIDTH_RATIO
						local window_h = screen_h * HEIGHT_RATIO
						local window_w_int = math.floor(window_w)
						local window_h_int = math.floor(window_h)

						local x = (screen_w - window_w) / 2
						local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()

						return {
							border = "rounded",
							relative = "editor",
							row = center_y,
							col = x,
							width = window_w_int,
							height = window_h_int,
						}
					end,
				},
			},
			-- change folder arrow icons
			renderer = {
				root_folder_label = false,
				group_empty = true,
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
	end,
}
