{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "sysact";
      runtimeInputs = [ wofi ];
      text = ''
        lock="  lock"
        logout="󰗽  logout"
        reload="  reload"
        reboot="  reboot"
        sleep="󰒲  sleep"
        shutdown="⏻  shutdown"

        choice=$(pkill wofi ; printf "%s\n%s\n%s\n%s\n%s\n%s" "$lock" "$logout" "$reload" "$reboot" "$sleep" "$shutdown" | wofi --lines 6 -p "  system action" --dmenu)

        case "$choice" in
        "$lock") gtklock ;;
        "$logout") hyprctl dispatch exit ;;
        "$reload") hyprctl reload ;;
        "$reboot") systemctl reboot -i ;;
        "$sleep") systemctl suspend -i ;;
        "$shutdown") systemctl poweroff -i ;;
        esac
      '';
    })
  ];
}
