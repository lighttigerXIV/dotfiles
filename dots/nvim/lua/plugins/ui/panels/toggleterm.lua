return {
	"akinsho/toggleterm.nvim",
	config = function()
		local terminal = require("toggleterm")

		terminal.setup({
			open_mapping = nil,
			direction = "float",
			float_opts = {
				border = "curved",
			},
		})

		vim.keymap.set({ "n", "t", "i" }, "<c-`>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal (US Layout)" })
		vim.keymap.set({ "n", "t", "i" }, "<c-\\>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal (PT Layout)" })
	end,
}
