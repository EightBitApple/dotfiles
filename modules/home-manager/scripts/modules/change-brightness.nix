{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "changebrightness";
      runtimeInputs = [
        brillo
        libnotify
      ];
      text = ''
        icon=${pkgs.myPackages.diinki-aero}/share/icons/crystal-remix-icon-theme-diinki-version/128x128/apps/ktip.png
        notif_time=500

        send_notification() {
            notify-send -i "$1" -u low "brightness:" "$(brillo -G)%" -h string:x-canonical-private-synchronous:brightness -t $notif_time
        }

        case $1 in
        up)
            brillo -u 150000 -q -A "$2"
            send_notification "$icon"
            ;;
        down)
            brillo -u 150000 -q -U "$2"
            send_notification "$icon"
            ;;
        esac
      '';
    })
  ];
}
