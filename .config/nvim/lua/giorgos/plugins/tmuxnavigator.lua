return {
	--	"christoomey/vim-tmux-navigator",
	--	cmd = {
	--		"TmuxNavigateLeft",
	--		"TmuxNavigateDown",
	--		"TmuxNavigateUp",
	--		"TmuxNavigateRight",
	--		"TmuxNavigatePrevious",
	--	},
	--	keys = {
	--		{ "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
	--		{ "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
	--		{ "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
	--		{ "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
	--		{ "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	--	},
	{
		"elijahdanko/ttymux.nvim",
		config = function()
			require("ttymux").setup({
				default_keymap = true,
			})

			vim.keymap.set("n", "<M-h>", function()
				require("ttymux.window").navigate("h")
			end)
			vim.keymap.set("n", "<M-l>", function()
				require("ttymux.window").navigate("l")
			end)
			vim.keymap.set("n", "<M-j>", function()
				require("ttymux.window").navigate("j")
			end)
			vim.keymap.set("n", "<M-k>", function()
				require("ttymux.window").navigate("k")
			end)
		end,
	},
}
