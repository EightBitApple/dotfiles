#!/usr/bin/env sh

case $1 in
--normal)
    pw-play --volume 100 ~/.local/share/system-sounds/windows-notify.wav
    ;;
--critical)
    pw-play --volume 100 ~/.local/share/system-sounds/windows-critical-stop.wav
    ;;
esac
