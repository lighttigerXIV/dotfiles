vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Diagnostics
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics quick list" })

-- Move through windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>tr", function()
	for k, _ in pairs(package.loaded) do
		if k:find("monocode%-scheme") then
			package.loaded[k] = nil
		end
	end
	vim.cmd("colorscheme monocode-scheme")
end, { desc = "[T]heme [R]eload" })
