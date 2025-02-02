#!/usr/bin/env sh

name=$1
capacity=$2
multiple=$4
notif_lock=/tmp/$name.lock

if [ $(("$capacity" % "$multiple")) -eq 0 ]; then
    if [ ! -f "$notif_lock" ]; then
        notify-send -u critical "Low battery!" "$name is at $capacity%."
        touch "$notif_lock"
    fi
else
    rm "$notif_lock" 2> /dev/null
fi
