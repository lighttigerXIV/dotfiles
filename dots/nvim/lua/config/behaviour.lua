-- Enable global clipboard
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Case insensitive builtin search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Use normal tab width
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
