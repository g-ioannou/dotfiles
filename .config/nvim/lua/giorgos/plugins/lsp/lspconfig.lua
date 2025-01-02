local function configurePython()
	vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
end

local function configureCompletions()
	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	-- used to enable autocompletion (assign to every lsp server config)
	local capabilities = cmp_nvim_lsp.default_capabilities()
	capabilities = vim.lsp.protocol.make_client_capabilities()

	return capabilities
end

local function ensureInstalledLSPs()
	local mason_lspconfig = require("mason-lspconfig")
	mason_lspconfig.setup({
		ensure_installed = {
			"ts_ls",
			"html",
			"cssls",
			"svelte",
			"lua_ls",
			"emmet_ls",
			"prismals",
			"pyright",
		},
		-- auto-install configured servers (with lspconfig)
		automatic_installation = true,
	})
end

local function configureUI()
	local win = require("lspconfig.ui.windows")
	win.default_options.border = "rounded"

	vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", source = "always" })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

	-- INFO  this doesn't work with TMUX
	local hl_groups = { "DiagnosticUnderlineError", "DiagnosticUnderlineWarn" }
	for _, hl in ipairs(hl_groups) do
		vim.cmd.highlight(hl .. " gui=undercurl")
	end

	--  -- Diagnostic signs in status column
	--	local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
	--	for type, icon in pairs(signs) do
	--		local hl = "DiagnosticSign" .. type
	--		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	--	end

	-- virtual text LSP messages
	vim.diagnostic.config({
		signs = false,
		severity_sort = true,
		virtual_text = {
			prefix = function(diagnostic)
				local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

				if diagnostic.severity == vim.diagnostic.severity.ERROR then
					return signs.Error
				end

				if diagnostic.severity == vim.diagnostic.severity.WARN then
					return signs.Warn
				end

				if diagnostic.severity == vim.diagnostic.severity.INFO then
					return signs.INFO
				end

				return signs.Hint
			end,
		},
		underline = true,
		float = {
			border = "rounded",
			source = true,
			update_in_insert = true,
			severity_sort = true,
		},
	})
end

---@param capabilities lsp.ClientCapabilities
local function setupLSPHandlers(capabilities)
	local lspconfig = require("lspconfig")
	local mason_lspconfig = require("mason-lspconfig")

	local function on_attach(client, bufnr)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end
	end

	mason_lspconfig.setup_handlers({
		-- default handler for installed servers
		function(server_name)
			lspconfig[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,
		["ts_ls"] = function()
			lspconfig["ts_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = { implicitProjectConfiguration = { checkJs = true } },
			})
		end,
		["svelte"] = function()
			-- configure svelte server
			lspconfig["svelte"].setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						group = vim.api.nvim_create_augroup("svelte_ondidchangetsorjsfile", { clear = true }),
						callback = function(ctx)
							-- Here use ctx.match instead of ctx.file
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
					on_attach(client, bufnr)
				end,
			})
		end,
		["emmet_ls"] = function()
			-- configure emmet language server
			lspconfig["emmet_ls"].setup({
				capabilities = capabilities,
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
			})
		end,
		["pyright"] = function()
			lspconfig["pyright"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				pyright = {
					diagnostiMode = "workspace",
					autoSearchPaths = "true",
					useLibraryCodeForTypes = true,
				},
			})
		end,
		["lua_ls"] = function()
			-- configure lua server (with special settings)
			lspconfig["lua_ls"].setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			})
		end,
	})
end

local function configureKeybinds()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			-- Buffer local mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local opts = { buffer = ev.buf, silent = true }

			-- set keybinds
			opts.desc = "Show LSP references"
			vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Go to lsp definition in horizontal split"
			vim.keymap.set("n", "ga", "<cmd>sp<CR><cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions in new horizontal split

			opts.desc = "Go to lsp definition in horizontal split"
			vim.keymap.set("n", "gA", "<cmd>vsp<CR><cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions in new vertical split

			opts.desc = "Open diagnostic quickfix list"
			vim.keymap.set("n", "<leader>qf", vim.diagnostic.setloclist)

			opts.desc = "Show LSP implementations"
			vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ -- vim completions
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = { "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },
	},
	config = function()
		--		configurePython()

		configureUI()
		ensureInstalledLSPs()
		local capabilities = configureCompletions()
		setupLSPHandlers(capabilities)
		configureKeybinds()
	end,
}
