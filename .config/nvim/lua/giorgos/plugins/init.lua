return {
	"nvim-lua/plenary.nvim",
	{
		-- colorizes hexcolors #ffffff
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	-- ╭────────────────────────────╮
	-- │ This makes boxes like this │
	-- ╰────────────────────────────╯
	{ "LudoPinelli/comment-box.nvim" },
	-- better highlight for logging files
	{
		"fei6409/log-highlight.nvim",
		config = function()
			require("log-highlight").setup({})
		end,
	},
	{
		"echasnovski/mini.trailspace",
		version = "*",
		config = function()
			require("mini.trailspace").setup({ only_in_normal_buffers = true })
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.surround").setup({})
		end,
	},
}
