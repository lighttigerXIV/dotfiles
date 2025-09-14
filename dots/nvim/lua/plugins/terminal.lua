return {
	"akinsho/toggleterm.nvim",
	config = function()
		local terminal = require("toggleterm")

		terminal.setup({
			open_mapping = [[<c-`>]],
			direction = "float",
			float_opts = {
				border = "curved",
			},
		})
	end,
}
