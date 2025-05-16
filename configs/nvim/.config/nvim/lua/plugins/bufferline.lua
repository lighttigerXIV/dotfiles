return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			highlights = {
				buffer_selected = {
					italic = false,
				},
			},
		})
	end,
}
