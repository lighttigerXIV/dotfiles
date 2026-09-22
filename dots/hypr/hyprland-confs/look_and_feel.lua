hl.config({
	misc = {
		focus_on_activate = true,
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		background_color = 0x00000000,
	},
})

hl.config({
	general = {
		border_size = 1,
		col = {
			active_border = "rgba(606060aa)",
			inactive_border = "rgba(1A1A1Aaa)",
		},
	},
	decoration = {
		rounding = 16,
		rounding_power = 3,
		shadow = { enabled = false },
		blur = {
			enabled = true,
			size = 8,
			passes = 3,
			vibrancy = 0.2,
		},
	},
})
