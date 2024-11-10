local wezterm = require 'wezterm'
local config = {}
config.font = wezterm.font 'RobotoMono Nerd Font'
config.font_size = 14
config.tab_bar_at_bottom = true

-- TabBar
config.window_frame = {
    font_size = 13,
    active_titlebar_bg = '#0E0600',
    inactive_titlebar_bg = '#0E0600',
}
config.enable_wayland = false

-- Theming
config.colors = {
    foreground = '#FFEEE2',
    background = '#0E0600',
    cursor_bg = '#FFEEE2',
    cursor_fg = '#000',
    cursor_border = '#FFEEE2',
    selection_fg = '#000',
    selection_bg = '#FFEEE2',
    scrollbar_thumb = '#FFEEE2',
    split = '#FFEEE2',

    ansi = {
        'black',
        '#FF8C7C',
        '#B1E380',
        '#B1E380',
        '#A5CEFF',
        '#FFAAF5',
        '#A5CEFF',
        '#B5A8A0',
    },
    brights = {
        '#B5A8A0',
        '#FF8C7C',
        '#B1E380',
        '#FFE072',
        '#A5CEFF',
        '#FFAAF5',
        '#A5CEFF',
        '#FFEEE2',
    },

    indexed = { [136] = '#af8700' },
    compose_cursor = '#FFB26C',
    copy_mode_active_highlight_bg = { Color = '#FFEEE2' },
    copy_mode_active_highlight_fg = { Color = '#000' },
    copy_mode_inactive_highlight_bg = { Color = '#502000' },
    copy_mode_inactive_highlight_fg = { Color = '#FFEEE2' },
    quick_select_label_bg = { Color = 'peru' },
    quick_select_label_fg = { Color = '#ffffff' },
    quick_select_match_bg = { Color = '#A5CEFF' },
    quick_select_match_fg = { Color = '#ffffff' },

    tab_bar = {
        background = '#0E0600',
        active_tab = {
            bg_color = '#1B0B00',
            fg_color = '#FFEEE2',
            italic = false,
        },
        inactive_tab = {
            bg_color = '0E0600',
            fg_color = '#AE917C',
        },
        inactive_tab_hover = {
            bg_color = '#301300',
            fg_color = '#FFEEE2',
        },
        new_tab = {
            bg_color = '#0E0600',
            fg_color = '#FFEEE2',
        },
        new_tab_hover = {
            bg_color = '#301300',
            fg_color = '#FFEEE2',
        },
    },
}


return config
