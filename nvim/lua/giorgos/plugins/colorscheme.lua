return {
	{
		"rose-pine/neovim",
		priority = 1000,
		config = function()
			local theme = require("rose-pine")

			theme.setup({
				disable_background = true,
				disable_float_background = true,
				highlight_groups = {
					GitSignsAdd = { bg = "NONE" },
					GitSignsChange = { bg = "NONE" },
					GitSignsDelete = { bg = "NONE" },
				},
			})

			vim.cmd([[colorscheme rose-pine]])
		end,
	},
	--	{
	--		"catppuccin/nvim",
	--		priority = 1000,
	--		config = function()
	--			local theme = require("catppuccin")
	--
	--			theme.setup({
	--				flavor = "mocha",
	--			})
	--
	--			vim.cmd([[colorscheme catppuccin]])
	--			vim.cmd([[highlight Normal guibg=none]])
	--			vim.cmd([[highlight NonText guibg=none]])
	--		end,
	--	},
}
