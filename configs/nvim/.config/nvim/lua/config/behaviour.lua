-- Enable global clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Case insensitive builtin search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Format on save
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Use normal tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
