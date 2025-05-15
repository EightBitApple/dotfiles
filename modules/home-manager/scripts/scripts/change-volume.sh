#!/usr/bin/env sh

notif_time=500

send_notification() {
    volume=$(pamixer --get-volume)
    notify-send -u low "volume:" "$volume%" -h int:value:"$volume" -h string:x-canonical-private-synchronous:volume -t "$notif_time"
}

case $1 in
up)
    # Set the volume on (if it was muted)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$2%+"
    send_notification "$1"
    ;;
down)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$2%-"
    send_notification "$1"
    ;;
mute)
    wpctl set-mute @DEFAULT_SINK@ toggle
    if "$(pamixer --get-mute)"; then
        notify-send -t $notif_time -u low "volume:" "muted" -h string:x-canonical-private-synchronous:volume -t "$notif_time"
    else
        send_notification "$1"
    fi
    ;;
esac
