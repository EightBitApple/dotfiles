{ config, lib, pkgs, ... }:

{
  options.systemActions.enable = lib.mkEnableOption ''
    Enable script to perform actions on the system (shutdown, sleep, reboot, etc.)
  '';

  config = lib.mkIf config.systemActions.enable {
    home.packages = with pkgs;
      [
        (pkgs.writeShellApplication {
          name = "sysact";
          runtimeInputs = with pkgs; [ physlock tofi ];
          text = ''
            if [ $# -eq 0 ]
            	then
            		choice=$(printf "lock\nleave\nrenew\nhibernate\nreboot\nshutdown\nsleep" | tofi)
            	else
            		choice=$1
            fi

            case "$choice" in
            	'lock') physlock -m -s ;;
            	'sleep') systemctl suspend -i ;;
            	'reboot') systemctl reboot -i ;;
            	'shutdown') systemctl poweroff -i ;;
            	*) echo "invalid command" && exit 1 ;;
            esac
          '';
        })
      ];
  };
}
