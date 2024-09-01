return {
	{
		"refractalize/oil-git-status.nvim",

		dependencies = {
			"stevearc/oil.nvim",
		},

		config = function()
			require("oil-git-status").setup({ show_ignored = true })
		end,
	},
	--	{
	--		"SirZenith/oil-vcs-status",
	--		config = function()
	--			local status_const = require("oil-vcs-status.constant.status")
	--
	--			local StatusType = status_const.StatusType
	--
	--			require("oil-vcs-status").setup({
	--				status_symbol = {
	--					[StatusType.Added] = "A",
	--					[StatusType.Copied] = "󰆏",
	--					[StatusType.Deleted] = "D",
	--					[StatusType.Ignored] = "I",
	--					[StatusType.Modified] = "M",
	--					[StatusType.Renamed] = "M",
	--					[StatusType.TypeChanged] = "󰉺",
	--					[StatusType.Unmodified] = " ",
	--					[StatusType.Unmerged] = "",
	--					[StatusType.Untracked] = "U",
	--					[StatusType.External] = "",
	--
	--					[StatusType.UpstreamAdded] = "󰈞",
	--					[StatusType.UpstreamCopied] = "󰈢",
	--					[StatusType.UpstreamDeleted] = "",
	--					[StatusType.UpstreamIgnored] = " ",
	--					[StatusType.UpstreamModified] = "󰏫",
	--					[StatusType.UpstreamRenamed] = "",
	--					[StatusType.UpstreamTypeChanged] = "󱧶",
	--					[StatusType.UpstreamUnmodified] = " ",
	--					[StatusType.UpstreamUnmerged] = "",
	--					[StatusType.UpstreamUntracked] = " ",
	--					[StatusType.UpstreamExternal] = "",
	--				},
	--
	--				-- Highlight group name used by each status type.
	--				---@type table<oil-vcs-status.StatusType, string | false>
	--				status_hl_group = {
	--					[StatusType.Added] = "OilVcsStatusAdded",
	--					[StatusType.Copied] = "OilVcsStatusCopied",
	--					[StatusType.Deleted] = "OilVcsStatusDeleted",
	--					[StatusType.Ignored] = "OilVcsStatusIgnored",
	--					[StatusType.Modified] = "OilVcsStatusModified",
	--					[StatusType.Renamed] = "OilVcsStatusRenamed",
	--					[StatusType.TypeChanged] = "OilVcsStatusTypeChanged",
	--					[StatusType.Unmodified] = "OilVcsStatusUnmodified",
	--					[StatusType.Unmerged] = "OilVcsStatusUnmerged",
	--					[StatusType.Untracked] = "OilVcsStatusUntracked",
	--					[StatusType.External] = "OilVcsStatusExternal",
	--
	--					[StatusType.UpstreamAdded] = "OilVcsStatusUpstreamAdded",
	--					[StatusType.UpstreamCopied] = "OilVcsStatusUpstreamCopied",
	--					[StatusType.UpstreamDeleted] = "OilVcsStatusUpstreamDeleted",
	--					[StatusType.UpstreamIgnored] = "OilVcsStatusUpstreamIgnored",
	--					[StatusType.UpstreamModified] = "OilVcsStatusUpstreamModified",
	--					[StatusType.UpstreamRenamed] = "OilVcsStatusUpstreamRenamed",
	--					[StatusType.UpstreamTypeChanged] = "OilVcsStatusUpstreamTypeChanged",
	--					[StatusType.UpstreamUnmodified] = "OilVcsStatusUpstreamUnmodified",
	--					[StatusType.UpstreamUnmerged] = "OilVcsStatusUpstreamUnmerged",
	--					[StatusType.UpstreamUntracked] = "OilVcsStatusUpstreamUntracked",
	--					[StatusType.UpstreamExternal] = "OilVcsStatusUpstreamExternal",
	--				},
	--			})
	--		end,
	--	},
	{
		"stevearc/oil.nvim",

		config = function()
			local oil = require("oil")

			local detail = false

			oil.setup({
				default_file_explorer = true,
				keymaps = {
					["<C-w>"] = "actions.close",
					["<C-d>"] = "actions.select_vsplit",
					["<C-a>"] = "actions.select_split",
					["<C-t>"] = "actions.toggle_trash",
					["<C-r>"] = "actions.refresh",
					["<C-p>"] = nil,
					["<C-h>"] = "<cmd>TmuxNavigateLeft<cr>",
					["<C-j>"] = "<cmd>TmuxNavigateDown<cr>",
					["<C-k>"] = "<cmd>TmuxNavigateUp<cr>",
					["<C-l>"] = "<cmd>TmuxNavigateRight<cr>",
					["<leader>k"] = {
						desc = "Toggle files detail view",
						callback = function()
							detail = not detail
							if detail then
								require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
							else
								require("oil").set_columns({ "icon" })
							end
						end,
					},
					--["?"] = "actions.toggle_help",
				},
				contain_cursor = "editable",
				delete_to_trash = true,
				skip_confirm_for_simple_edits = true,
				watch_for_changes = true,
				float = {
					win_options = {
						signcolumn = "number",
					},
					preview_split = "right",
					max_width = 150,
				},
				win_options = {
					wrap = false,
					signcolumn = "yes:2",
					--				cursorcolumn = true,
					foldcolumn = "1",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
				view_options = {
					show_hidden = true,
					case_insensitive = true,
					is_always_hidden = function(name, bufnr)
						return (name == "..")
					end,
				},
			})

			vim.keymap.set("n", "<leader>b", function()
				oil.toggle_float()
				-- oil.open_preview()
			end)
		end,
	},
}
