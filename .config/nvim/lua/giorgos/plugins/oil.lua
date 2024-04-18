return {
	"stevearc/oil.nvim",
	opts = {},
	config = function()
		local oil = require("oil")
		print("Hello")

		oil.setup({
			default_file_explorer = true,
			columns = {
				"icon",
				"size",
				"permissions",
				"mtime",
				"type",
			},
			contain_cursor = "editable",
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			win_options = {
				wrap = false,
				signcolumn = "yes",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},
			float = {
				win_options = {
					signcolumn = "yes",
				},
			},
		})

		vim.keymap.set("n", "<leader>e", function()
			oil.toggle_float()
		end)

		vim.keymap.set("n", "<leader>e", function()
			oil.toggle_float()
		end)
	end,
}
