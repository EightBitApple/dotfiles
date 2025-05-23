#!/usr/bin/env sh

notif_time=500

send_notification() {
    notify-send -u low "brightness:" "$(brillo -G)%" -h string:x-canonical-private-synchronous:brightness -t $notif_time
}

case $1 in
up)
    brillo -u 150000 -q -A "$2"
    send_notification "$1"
    ;;
down)
    brillo -u 150000 -q -U "$2"
    send_notification "$1"
    ;;
esac
