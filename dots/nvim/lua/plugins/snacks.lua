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
	end,
}
