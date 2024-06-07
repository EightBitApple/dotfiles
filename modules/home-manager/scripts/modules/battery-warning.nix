{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.batteryWarning.enable = lib.mkEnableOption ''
    Enable script to warn user of a low battery via notification. When a
    battery's capacity is at or below 15%, at a multiple of 5 and no lock file
    exists, show a notification.

    A lock file will be created in /tmp/ when a notification gets shown,
    preventing battery warning notifications getting spammed during the time the
    afformentioned conditions are met. The lock file will be deleted once the
    capacity is no longer a multiple of 5.
  '';

  config = lib.mkIf config.batteryWarning.enable {
    home.packages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "bat-warning";
        text = ''
          low_bat_thrsh=15
          low_bat_multiple=5

          for battery in /sys/class/power_supply/?*; do

              battery_name=$(basename "''${battery}")

              [ "$battery_name" = "AC" ] && continue

              notif_lock=/tmp/$battery_name.lock

              status=$(cat "$battery/status" 2>&1)
              capacity="$(cat "$battery/capacity" 2>&1)"

              if [ "$status" = "Discharging" ] &&
                 [ "$capacity" -le "$low_bat_thrsh" ]
              then

                if [ $((capacity % low_bat_multiple)) -eq 0 ]
                then
                  if [ ! -f "$notif_lock" ]
                  then
                    notify-send -t 15000 "Warning: Low Battery!" "$battery_name is at $capacity%."
                    touch "$notif_lock"
                  fi
                else
                  rm "$notif_lock"
                fi

              fi
          done
        '';
      })
    ];
  };
}
