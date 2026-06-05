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

		vim.keymap.set({ "n", "t", "i" }, "<F2>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
	end,
}
