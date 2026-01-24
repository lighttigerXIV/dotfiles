-- return {
-- 	{
-- 		dir = "~/.config/nvim/lua/monocode-scheme/", -- Path to your local folder
-- 		lazy = false,
-- 		priority = 1000,
-- 		config = function()
-- 			vim.cmd.colorscheme("monocode-scheme")
-- 		end,
-- 	},
-- }

return {
	"mono-code-scheme/neovim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("monocode-scheme")
	end,
}
