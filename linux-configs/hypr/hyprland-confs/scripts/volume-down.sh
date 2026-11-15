#!/bin/sh

wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-

VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

notify-send -t 500 -h string:x-canonical-private-synchronous:volume "Volume" "${VOLUME}%"
