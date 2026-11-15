-- Disables neovim folding by default and does folding better

return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	config = function()
		require("ufo").setup()

		vim.opt.foldlevel = 99
		vim.opt.foldlevelstart = 99
		vim.opt.foldenable = true
		vim.opt.foldmethod = "manual"
	end,
}
