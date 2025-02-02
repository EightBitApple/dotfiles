#!/usr/bin/env sh

final_str=""
delim=""
low_threshold=25
low_multiple=5
first_battery=true

for battery in /sys/class/power_supply/?*; do

    name=$(basename "${battery}")
    [ "$name" = "AC" ] && continue

    case $(cat "$battery/status" 2>&1) in
    "Full") status="" ;;
    "Discharging") status="" ;;
    "Charging") status="" ;;
    "Not charging") status="" ;;
    "Unknown") status="󰂑" ;;
    *) exit 1 ;;
    esac

    [ ! -f "$battery/capacity" ] && continue
    capacity="$(cat "$battery/capacity" 2>&1)"

    warn=""
    if [ "$status" = "" ] && [ "$capacity" -le "$low_threshold" ]; then
        warn="!"
        battery-warning "$name" "$capacity" "$low_threshold" "$low_multiple"
    fi

    # assemble battery_str and concatinate into final_str
    battery_str="$status$warn $capacity%"

    [ "$first_battery" = false ] && delim=" | "

    final_str="${final_str}$delim$battery_str"
    first_battery=false
done

# https://stackoverflow.com/a/3352015
# remove leading whitespace characters
final_str="${final_str#"${final_str%%[![:space:]]*}"}"
# remove trailing whitespace characters
final_str="${final_str%"${final_str##*[![:space:]]}"}"

printf "%b\n" "$final_str"
