{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "sysact";
      runtimeInputs = [ wofi ];
      text = ''
        if [ $# -eq 0 ]; then
            choice=$(pkill wofi ; printf "lock\nlogout\nreload\nreboot\nsleep\nshutdown" | wofi -p "system:" --dmenu)
        else
            choice=$1
        fi

        case "$choice" in
             'lock') gtklock ;;
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
}
