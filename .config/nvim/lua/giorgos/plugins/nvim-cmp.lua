local test = 1

return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-nvim-lsp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"lukas-reineke/cmp-under-comparator",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			formatting = {
				fields = { "abbr", "kind", "menu" },
				expandable_indicator = true,
				format = lspkind.cmp_format({
					mode = "symbol_text",
					max_width = 50,
					show_labelDetails = true,

					elipsis_char = "...",
					menu = {
						luasnip = "[snip]",
						buffer = "[buffer]",
						path = "[path]",
						nvim_lsp = "[LSP]",
					},
					before = function(entry, vim_item)
						return vim_item
					end,
				}),
			},
			experimental = {
				ghost_text = true,
			},
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-k>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<Esc>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
			}),
			sources = cmp.config.sources({
				{ name = "buffer", max_item_count = 4, priority = 99 },
				{ name = "nvim_lsp", max_item_count = 4, priority = 98 },
				{ name = "path", max_item_count = 4, priority = 50 },
				{ name = "luasnip", max_item_count = 4, priority = 1, keyword_length = 3 },
			}),
			sorting = {
				priority_weight = 100000,
				comparators = {
					cmp.config.compare.recently_used,
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.kind,
					cmp.config.compare.order,
				},
			},
			window = {
				completion = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
				},
				documentation = {
					border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
				},
			},
		})
	end,
}
