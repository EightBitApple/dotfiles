{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "battery-status";
      text = ''
        text=""
        tooltip=""

        notif_icon=${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite/status/battery-caution.svg
        low_threshold=25
        low_multiple=5

        for battery in /sys/class/power_supply/?*; do
            name=$(basename "''${battery}")
            notif_lock=/tmp/$name.lock

            [ "$name" = "AC" ] && continue
            status_name=$(cat "$battery/status" 2>&1)

            case "$status_name" in
            "Full") status_icon="" ;;
            "Discharging") status_icon="" ;;
            "Charging") status_icon="" ;;
            "Not charging") status_icon="" ;;
            "Unknown") status_icon="󰂑" ;;
            *) exit 1 ;;
            esac

            [ ! -f "$battery/capacity" ] && continue
            capacity="$(cat "$battery/capacity" 2>&1)"

            warn=""
            if [ "$status_icon" = "" ] && [ "$capacity" -le "$low_threshold" ]; then
                warn="!"
                if [ $(("$capacity" % "$low_multiple")) -eq 0 ]; then
                    if [ ! -f "$notif_lock" ]; then
                        notify-send -i "$notif_icon" -t 10000 "Low battery!" "$name is at $capacity%."
                        touch "$notif_lock"
                    fi
                else
                    rm "$notif_lock" 2>/dev/null || true
                fi
            fi

            # assemble text and tooltip substrings
            text_sub="$status_icon$warn\n$capacity"
            text="''${text}$text_sub\n"

            tooltip_sub="$name | $capacity% $status_name"
            tooltip="''${tooltip}$tooltip_sub\n"
        done

        # Remove last newline char.
        # https://unix.stackexchange.com/a/478639
        text=$(printf "%s" "$text" | sed 's/\(.*\)\\n/\1/')
        tooltip=$(printf "%s" "$tooltip" | sed 's/\(.*\)\\n/\1/')

        printf "{\"text\":\"%s\", \"tooltip\":\"%s\"}\n" "$text" "$tooltip"
      '';
    })
  ];
}
