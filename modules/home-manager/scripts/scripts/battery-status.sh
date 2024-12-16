#!/usr/bin/env sh

final_str=""
first_battery=true
delim=""
for battery in /sys/class/power_supply/?*; do

    battery_name=$(basename "${battery}")
    [ "$battery_name" = "AC" ] && continue

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
    [ "$status" = "" ] && [ "$capacity" -le 25 ] && warn=""

    # assemble battery_str and concatinate into final_str
    battery_str="$status$warn $capacity%"

    if [ "$first_battery" = false ]; then
        delim=" | "
    fi

    final_str="${final_str}$delim$battery_str"
    first_battery=false
done

# https://stackoverflow.com/a/3352015
# remove leading whitespace characters
final_str="${final_str#"${final_str%%[![:space:]]*}"}"
# remove trailing whitespace characters
final_str="${final_str%"${final_str##*[![:space:]]}"}"

printf "%b\n" "$final_str"
