return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	depedencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
			},
		})

		local conf = require("telescope.config").values
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")

		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers")
				.new({}, {
					prompt_title = "Search pinned buffers",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(_, map)
						map({ "n", "i" }, "d", function(prompt_buffer)
							local current_picker = action_state.get_current_picker(prompt_buffer)

							current_picker:delete_selection(function(selection)
								harpoon:list():remove_at(selection.index)
							end)
						end)
						return true
					end,
				})
				:find()
		end

		vim.keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list(), {
				title = "Pinned buffers",
				title_pos = "center",
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			})
		end)

		--	vim.keymap.set("n", "<leader>h", function()
		--		toggle_telescope(harpoon:list())
		--	end)

		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():append()
			print("Buffer added to Harpoon")
		end)

		vim.keymap.set("n", "<leader>hh", function()
			toggle_telescope(harpoon:list())
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>o", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<leader>i", function()
			harpoon:list():next()
		end)
	end,
}
