-- Enable line numbers
vim.o.number = true

-- Enable Nerd Font
vim.g.have_nerd_font = true

-- Enable Mouse
vim.o.mouse = "a"

vim.o.showmode = false

-- Show cursor line
vim.o.cursorline = true

-- Clear search highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Close Buffer
vim.keymap.set("n", "<leader>cb", ":bd<CR>")
