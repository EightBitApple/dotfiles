{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "battery-status";
      text = ''
        icon=${pkgs.myPackages.diinki-aero}/share/icons/crystal-remix-icon-theme-diinki-version/128x128/status/dialog-warning.png
        final_str=""
        delim=""
        low_threshold=25
        low_multiple=5
        first_battery=true

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
            battery_str="$status$warn $capacity%"

            [ "$first_battery" = false ] && delim=" | "

            final_str="''${final_str}$delim$battery_str"
            first_battery=false
        done

        # https://stackoverflow.com/a/3352015
        # remove leading whitespace characters
        final_str="''${final_str#"''${final_str%%[![:space:]]*}"}"
        # remove trailing whitespace characters
        final_str="''${final_str%"''${final_str##*[![:space:]]}"}"

        printf "%b\n" "$final_str"
      '';
    })
  ];
}
