{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.systemActions.enable = lib.mkEnableOption ''
    Enable script to perform actions on the system (shutdown, sleep, reboot, etc.)
  '';

  config = lib.mkIf config.systemActions.enable {
    home.packages = with pkgs; [
      (writeShellApplication {
        name = "sysact";
        runtimeInputs = [ tofi ];
        text = ''
          if [ $# -eq 0 ]
            then
              choice=$(printf "lock\nlogout\nreload\nreboot\nsleep\nshutdown" | tofi --prompt-text="System: ")
            else
            choice=$1
          fi

          case "$choice" in
            'lock') hyprlock -q ;;
            'logout') hyprctl dispatch exit ;;
            'reload') hyprctl reload ;;
            'reboot') systemctl reboot -i ;;
            'sleep') systemctl suspend -i ;;
            'shutdown') systemctl poweroff -i ;;
            *) echo "invalid command" && exit 1 ;;
          esac
        '';
      })
    ];
  };
}
