return {
	"akinsho/toggleterm.nvim",
	config = function()
		local terminal = require("toggleterm")

		terminal.setup({
			open_mapping = [[<c-`>]],
			border = "curved",
		})
	end,
}
