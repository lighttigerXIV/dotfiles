return {
	"IogaMaster/neocord",
	event = "VeryLazy",
	config = function()
		require("neocord").setup({
			global_time = true,
			logo_tooltip = nil,
		})
	end,
}
