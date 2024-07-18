local wezterm = require 'wezterm'
local config = {}



config.color_schemes = {
    ["Whiskers Panther"] = {
        foreground = "#FFEEE2",
        background = "#0E0600",
        cursor_bg = "#FFEEE2",
        cursor_fg = "#FFEEE2",
        cursor_border = '#FFEEE2',
        selection_fg = '#FFEEE2',
        selection_bg = '#502000',
        scrollbar_thumb = '#1B0B00',
        split = '#1B0B00',

        ansi = {
            'black',
            '#FF8C7C',
            '#B1E380',
            '#FFE072',
            '#A5CEFF',
            '#FFAAF5',
            '#A5CEFF',
            '#FFEEE2',
        },
        brights = {
            'grey',
            '#FF8C7C',
            '#B1E380',
            '#FFE072',
            '#A5CEFF',
            '#FFAAF5',
            '#A5CEFF',
            '#FFEEE2',
        },
        indexed = { [136] = '#FFE072' },
        compose_cursor = '#FFB26C',
        copy_mode_active_highlight_bg = { Color = '#502000' },
        copy_mode_active_highlight_fg = { Color = '#FFEEE2' },
        copy_mode_inactive_highlight_bg = { Color = '#502000' },
        copy_mode_inactive_highlight_fg = { Color = '#FFEEE2' },
        quick_select_label_bg = { Color = '#502000' },
        quick_select_label_fg = { Color = '#FFEEE2' },
        quick_select_match_bg = { Color = '#502000' },
        quick_select_match_fg = { Color = '#FFEEE2' },
    }
}



config.enable_wayland = false
config.color_scheme = "Whiskers Panther"
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.window_frame = {
    active_titlebar_bg = "#0E0600",
    inactive_titlebar_bg = '#1B0B00',
}
config.colors = {
    tab_bar = {
        background = '#0E0600',
        active_tab = {
            bg_color = '#FFE072',
            fg_color = '#000000'
        },

        inactive_tab = {
            bg_color = '#1B0B00',
            fg_color = '#FFEEE2',
        },
        inactive_tab_hover = {
            bg_color = '#FFE072',
            fg_color = '#000000'
        },
        new_tab = {
            bg_color = '#1B0B00',
            fg_color = '#FFEEE2',
        },
        new_tab_hover = {
            bg_color = '#502000',
            fg_color = '#FFEEE2',
        },
    },
}
config.font = wezterm.font 'Jetbrains Mono'
config.font_size = 14
config.audible_bell = 'Disabled'
config.default_cursor_style = 'BlinkingBar'
config.default_prog = {'bash'}


return config
