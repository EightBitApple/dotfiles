{ pkgs, ... }:

let
  iconPathPrefix = "${pkgs.myPackages.diinki-aero}/share/icons/crystal-remix-icon-theme-diinki-version/128x128/preferences";
in

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "idle-toggle";
      text = ''
        icon_timer_on=${iconPathPrefix}/preferences-system-time.png
        icon_timer_off=${iconPathPrefix}/preferences-system-time-off.png

        notify() {
            notify-send -i "$1" -t 2000 -h string:x-canonical-private-synchronous:idle "$2" "$3"
        }

        notif_title="Idle Timer"

        systemctl --user reset-failed hypridle

        if systemctl --user is-active hypridle; then
            systemctl --user stop hypridle && \
            notify "$icon_timer_off" "$notif_title" "Off"
        else
            systemctl --user start hypridle && \
            notify "$icon_timer_on" "$notif_title" "On"
        fi

        pkill -SIGRTMIN+1 waybar
      '';
    })
  ];
}
