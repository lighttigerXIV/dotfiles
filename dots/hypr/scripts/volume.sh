#!/bin/sh

case "$1" in
    up)
        pamixer --unmute --increase 5
        ;;
    down)
        pamixer --unmute --decrease 5
        ;;
    mute)
        pamixer --toggle-mute
        ;;
esac

current_volume=$(pamixer --get-volume)
is_muted=$(pamixer --get-mute)

message="$current_volume%"

if [ "$is_muted" = "true" ]; then
	message="Muted"
fi

dunstify -r 9910 -u low -i "$icon" "Volume" "$message"
