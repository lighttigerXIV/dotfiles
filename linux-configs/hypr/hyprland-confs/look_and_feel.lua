hl.config({
	misc = {
		focus_on_activate = true,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		background_color = 0x00000000,
	},
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

hl.config({
	general = {
		border_size = 4,
		gaps_in = 0,
		gaps_out = 0,
		-- gaps_out = {
		-- 	bottom = 8,
		-- 	left = 8,
		-- 	right = 8,
		-- 	top = 8,
		-- },
		col = {
			active_border = "rgba(9A7100ff)",
			inactive_border = "rgba(F6F6F6ff)",
		},
	},
	decoration = {
		rounding = 0,
		rounding_power = 2,
		shadow = { enabled = false },
		blur = {
			enabled = true,
			size = 1,
			passes = 4,
			vibrancy = 1,
		},
	},
})
