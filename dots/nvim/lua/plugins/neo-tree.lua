-- File Explorer

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		lazy = false,
		config = function()
			require("neo-tree").setup({
				filesystem = {
					follow_current_file = { enabled = true },
					hijack_netrw_behavior = "open_current",
				},
			})

			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Explorer (Neo-tree)" })
		end,
	},
}
