#!/usr/bin/env sh

notif_time=750

send_notification() {
    notify-send -a "changebrightness" -u low -r "9993" "Brightness: $(brillo -G)%" -t $notif_time
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
