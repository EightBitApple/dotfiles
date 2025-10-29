{ pkgs, ... }:

let
  icon = {
    path = "${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite/status/";

    timer = {
      enabled = "${icon.path}timer.svg";
      disabled = "${icon.path}timer-disabled.svg";
    };
  };
in

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "idle-toggle";
      text = ''
        notify() {
            notify-send -i "$1" -t 2000 -h string:x-canonical-private-synchronous:idle "$2" "$3"
        }

        notif_title="Idle Timer"

        systemctl --user reset-failed hypridle

        if systemctl --user is-active hypridle; then
            systemctl --user stop hypridle && \
            notify "${icon.timer.disabled}" "$notif_title" "Off"
        else
            systemctl --user start hypridle && \
            notify "${icon.timer.enabled}" "$notif_title" "On"
        fi

        pkill -SIGRTMIN+1 waybar
      '';
    })
  ];
}
