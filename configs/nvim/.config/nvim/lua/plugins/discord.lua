return {
	"IogaMaster/neocord",
	event = "VeryLazy",
	config = function()
		require("neocord").setup({
			logo_tooltip = nil,
			show_time = false,
			global_timer = true,
		})
	end,
}
