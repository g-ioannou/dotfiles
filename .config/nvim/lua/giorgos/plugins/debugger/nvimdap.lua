local function applyDAPkeymaps(dap)
	vim.keymap.set(
		"n",
		"<leader>t",
		":DapToggleBreakpoint<CR>",
		{ noremap = true, desc = "Toggle debugger breakpoint" }
	)

	vim.keymap.set("n", "<leader>n", function()
		dap.continue()
	end, { desc = "Run till next breakpoint" })
end

local function removeDAPkeymaps()
	vim.keymap.del("n", "<leader>t")

	vim.keymap.del("n", "<leader>n")
end

return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "green", numhl = "" })
		end,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "nvim-neotest/nvim-nio", "mfussenegger/nvim-dap" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			vim.keymap.set("n", "<leader>dbo", function()
				applyDAPkeymaps(dap)
				dapui.open()
			end, { noremap = true, desc = " DAP UI open" })

			vim.keymap.set("n", "<leader>dbc", function()
				removeDAPkeymaps()
				dap.clear_breakpoints()
				dapui.close()
			end, { noremap = true, desc = " DAP UI close" })
		end,
	},
}
