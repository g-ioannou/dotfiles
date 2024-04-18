return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		autoclose = true,
		action_keys = {
			close = "q",
			cancel = "<esc>",
			refresh = "r",
			jump = { "<CR>" },
			jump_close = { "o" },
			toggle_preview = { "P" },
		},
	},
}
