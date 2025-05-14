return {
	{ -- Tailwind support
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {},
	},
	{ -- Auto close html tags
		"windwp/nvim-ts-autotag",
		opts = true,
	},
}
