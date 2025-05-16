return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("snacks").setup({
			{
				bigfile = { enabled = true },
				image = { enabled = true },
				animate = { enabled = true },
				input = { enabled = true },
				notifier = { enabled = true },
				notify = { enabled = true },
				rename = { enabled = true },
				terminal = { enabled = true },
			},
		})

		local terminal = require("snacks.terminal")

		vim.keymap.set("n", "<leader>t", terminal.toggle, { desc = "Open Terminal" })
		vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Open Terminal" })
	end,
}
