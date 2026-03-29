return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Disables LSP on big files
		bigfile = { enabled = true },

		input = { enabled = true, border = "rounded" },

		-- Better Toasts
		notifier = { enabled = true },
		notify = { enabled = true },

		-- Renaming Popup
		rename = { enabled = true },

		terminal = { enabled = true },
	},
}
