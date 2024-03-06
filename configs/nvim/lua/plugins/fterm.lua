return {
	"numToStr/FTerm.nvim",
	config = function()
		vim.keymap.set("n", "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>')
	end,
}
