-- Gives syntax highlighting (mostly)

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			local parsers = { "lua", "rust", "svelte", "typescript", "javascript", "html", "css", "python" }
			for _, parser in ipairs(parsers) do
				ts.install(parser)
			end

			-- Enable highlighting and indent manually per filetype
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
