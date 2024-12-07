{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.batteryStatus.enable = lib.mkEnableOption ''
    This script returns a string containing the status and charge of each
    battery connected to the system. This script is adapted from Luke Smith's
    battery module.
    https://github.com/LukeSmithxyz/voidrice/blob/master/.local/bin/statusbar/sb-battery

    Sending all battery info as a single string makes it more compatable with
    Waybar. The script is also capable of parsing the info of power supplies
    that don't have a 'BAT*' prefix (sans those titled 'AC').
  '';

  config = lib.mkIf config.batteryStatus.enable {
    home.packages = with pkgs; [
      (writeShellApplication {
        name = "battery-status";
        text = ''
          final_str=""
          for battery in /sys/class/power_supply/?*; do
              battery_name=$(basename "''${battery}")
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

              final_str="''${final_str}$delim$battery_str"
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
  };
}
