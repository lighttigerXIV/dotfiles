-- A collection of plugins from mini
return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			local statusline = require("mini.statusline")
			local animate = require("mini.animate")

			statusline.setup({ use_icons = true })
		end,
	},
}
