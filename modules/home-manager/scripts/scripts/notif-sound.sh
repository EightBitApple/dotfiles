#!/usr/bin/env sh

case $1 in
--normal)
    pw-play ~/.local/share/system-sounds/windows-notify.wav
    ;;
--critical)
    pw-play ~/.local/share/system-sounds/windows-critical-stop.wav
    ;;
esac
