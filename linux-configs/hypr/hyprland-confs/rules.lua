hl.window_rule({
	match = {
		class = "org-whiskersapps-mordomo-MainKt",
	},
	float = true,
	center = true,
})

-- Only one window
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_in = 0, gaps_out = { top = 0, right = 0, bottom = 8, left = 0 } })
--
-- hl.window_rule({
-- 	name = "single-window-no-border",
-- 	match = { float = false, workspace = "w[tv1]" },
-- 	border_size = 0,
-- 	rounding = 0,
-- })

-- Window in fullscreen
-- hl.workspace_rule({ workspace = "f[1]", gaps_in = 0, gaps_out = 0 })
--
-- hl.window_rule({
-- 	name = "single-fullscreen-no-border",
-- 	match = { float = false, workspace = "f[1]" },
-- 	border_size = 0,
-- 	rounding = 0,
-- })
