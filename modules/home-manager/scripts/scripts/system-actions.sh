#!/usr/bin/env sh

if [ $# -eq 0 ]; then
    choice=$(printf "lock\nlogout\nreload\nreboot\nsleep\nshutdown" | tofi --prompt-text="System: ")
else
    choice=$1
fi

case "$choice" in
'lock') hyprlock -q ;;
'logout') hyprctl dispatch exit ;;
'reload') hyprctl reload ;;
'reboot') systemctl reboot -i ;;
'sleep') systemctl suspend -i ;;
'shutdown') systemctl poweroff -i ;;
*) echo "invalid command" && exit 1 ;;
esac