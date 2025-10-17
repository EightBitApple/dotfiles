{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "battery-status";
      text = ''
        icon=${pkgs.myPackages.diinki-aero}/share/icons/crystal-remix-icon-theme-diinki-version/128x128/status/dialog-warning.png
        final_str=""
        low_threshold=25
        low_multiple=5

        for battery in /sys/class/power_supply/?*; do
            name=$(basename "''${battery}")
            notif_lock=/tmp/$name.lock

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
                if [ $(("$capacity" % "$low_multiple")) -eq 0 ]; then
                    if [ ! -f "$notif_lock" ]; then
                        notify-send -i "$icon" -t 10000 "Low battery!" "$name is at $capacity%."
                        touch "$notif_lock"
                    fi
                else
                    rm "$notif_lock" 2>/dev/null || true
                fi
            fi

            # assemble battery_str and concatinate into final_str
            battery_str="$status$warn\n$capacity"
            final_str="''${final_str}$battery_str\n"
        done

        # https://unix.stackexchange.com/a/478639
        final_str=$(printf "%s" "$final_str" | sed 's/\(.*\)\\n/\1/')

        printf "{\"text\":\"%s\"}\n" "$final_str"
      '';
    })
  ];
}
