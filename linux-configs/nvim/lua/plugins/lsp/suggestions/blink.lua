-- Show auto complete suggestions

return {
	"saghen/blink.cmp",
	-- Load after LSP loads
	event = "VimEnter",
	-- Use last stable version
	version = "1.*",
	dependencies = {
		"L3MON4D3/LuaSnip",
		"folke/lazydev.nvim",
	},
	opts = {
		keymap = {
			preset = "enter",
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		completion = {
			documentation = { auto_show = true, auto_show_delay_ms = 500 },
		},
		sources = {
			default = { "lsp", "path", "snippets", "lazydev" },
			providers = {
				lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
			},
		},
		snippets = { preset = "luasnip" },
		fuzzy = {
			implementation = "lua",
			sorts = {
				function(a, b)
					local snippet = require("blink.cmp.types").CompletionItemKind.Snippet
					if a.kind == snippet and b.kind ~= snippet then
						return false
					end
					if a.kind ~= snippet and b.kind == snippet then
						return true
					end
				end,
				"score",
				"sort_text",
			},
		},
		signature = { enabled = true },
	},
}
