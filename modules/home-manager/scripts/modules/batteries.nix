{ pkgs, lib, config, ... }:

{
  options.battery.enable = lib.mkEnableOption ''
    Enable the battery status script.
  '';

  config = lib.mkIf config.battery.enable {
    home.packages = with pkgs;
      [
        (pkgs.writeShellApplication {
          name = "batteries";
          runtimeInputs = with pkgs;
            [ (nerdfonts.override { fonts = [ "FiraCode" ]; }) ];
          text = ''
            # Prints the currently charging or discharging battery along with its number.
            # Also notify the user when the current battery is discharging below 25%.

            notif_lock=/tmp/bat-low
            low_bat_thrsh=15
            count=-1

            ICON_CHARGING="󱟦"
            ICON_DISCHARGING="󱟤"
            ICON_FULL="󰂅"
            ICON_UNKNOWN="󰂑"

            for battery in /sys/class/power_supply/?*; do
            	count=$((count+1))
            	# If non-first battery, print a space separator.

            	status=$(cat "$battery/status" 2>&1)
            	case "$status" in
            		"Full" | "Not charging") status=$ICON_FULL ;;
            		"Discharging") status=$ICON_DISCHARGING ;;
            		"Charging") status=$ICON_CHARGING && rm "$notif_lock" 2> /dev/null ;;
            		"Unknown") status=$ICON_UNKNOWN ;;
            		*) exit 1 ;;
            	esac

            	capacity="$(cat "$battery/capacity" 2>&1)"
            	if [ "$capacity" -le "$low_bat_thrsh" ] && [ "$status" = "$ICON_DISCHARGING" ]
            	then
            		status="!"
            		if [ $((capacity % 5)) -eq 0 ]
            		then
            			if [ ! -f $notif_lock ]
            			then
            				touch $notif_lock
            				notify-send -t 15000 "Warning: Low Battery!" "Battery $count is at $capacity%"
            			fi
            		else
            			rm $notif_lock
            		fi
            	fi

            	printf '%s %d%%\n' "$status" "$capacity"
            done
          '';
        })
      ];
  };
}
