vim.opt.fillchars = { eob = " " }

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.wrap = false

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s"
vim.opt.syntax = "on"

vim.opt.clipboard:append("unnamedplus")

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.swapfile = false

vim.opt.backspace = "indent,eol,start"

vim.opt.scrolloff = 10

vim.opt.lcs = { lead = "·", trail = "a" }
vim.opt.cursorline = true

vim.opt.inccommand = "split"

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
