-- Auto close html tags

return {
	"windwp/nvim-ts-autotag",
	opts = true,
	per_filetype = {
		["rust"] = {
			enable_close = false,
			enable_rename = false,
		},
	},
}
