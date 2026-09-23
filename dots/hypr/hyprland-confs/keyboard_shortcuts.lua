-- Apps
hl.bind("SUPER + S", hl.dsp.exec_cmd("gio launch $HOME/.local/share/applications/mordomo.desktop"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("alacritty"))
hl.bind("SUPER + E", hl.dsp.exec_cmd("dolphin"))

-- Window Management
hl.bind("SUPER + Q", hl.dsp.window.close())

hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- ScreenShots
-- Full Screen
hl.bind(
	"SUPER + PRINT",
	hl.dsp.exec_cmd(
		[[file="$HOME/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png"; mkdir -p "$HOME/Pictures/Screenshots"; grim -g "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.x),\(.y) \(.width)x\(.height)"')" - | tee "$file" | wl-copy --type image/png && notify-send "Screenshot saved" "$file"]]
	)
)

-- Region
hl.bind(
	"SUPER + SHIFT + PRINT",
	hl.dsp.exec_cmd(
		[[file="$HOME/Pictures/Screenshots/screenshot-$(date +%Y%m%d-%H%M%S).png"; mkdir -p "$HOME/Pictures/Screenshots"; grim -g "$(slurp)" - | tee "$file" | wl-copy --type image/png && notify-send "Screenshot saved" "$file"]]
	)
)

-- Active Window
hl.bind(
	"SUPER + CTRL + PRINT",
	hl.dsp.exec_cmd(
		[[file="$HOME/Pictures/Screenshots/window-$(date +%Y%m%d-%H%M%S).png"; mkdir -p "$HOME/Pictures/Screenshots"; grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | tee "$file" | wl-copy --type image/png && notify-send "Window screenshot saved" "$file"]]
	)
)

-- Media
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

for i = 1, 10 do
	local key = i % 10 -- workspace 10 maps to the 0 key
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
