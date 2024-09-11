return {
	"nvim-neorg/neorg",
	lazy = false,
	version = "*",
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {},
				["core.dirman"] = { config = { workspaces = { notes = "~/Documents/neorg" } } },
				["core.concealer"] = {}, -- icons
				["core.keybinds"] = {},
			},
		})
	end,
	run = ":Neorg sync-parsers",
	requires = "nvim-lua/plenary.nvim",
}
