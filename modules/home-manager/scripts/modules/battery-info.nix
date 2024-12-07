{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.batteryInfo.enable = lib.mkEnableOption ''
    This script returns a string showing battery information.
  '';

  config = lib.mkIf config.batteryInfo.enable {
    home.packages = with pkgs; [
      (writeShellApplication {
        name = "battery-info";
        text = ''
          final_str=""
          for battery in /sys/class/power_supply/?*; do
              battery_name=$(basename "''${battery}")
              [ "$battery_name" = "AC" ] && continue

              [ ! -f "$battery/capacity" ] && continue
              capacity="$(cat "$battery/capacity" 2>&1)"
              status=$(cat "$battery/status" 2>&1)

              # assemble battery_str and concatinate into final_str
              battery_str="$battery_name $capacity% $status\n"
              final_str="''${final_str} $battery_str"
          done

          printf "%b\n" "$final_str"
        '';
      })
    ];
  };
}
