{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (pkgs.writeShellApplication {
      name = "changevolume";
      runtimeInputs = with pkgs; [
        pamixer
        libnotify
        wireplumber
      ];
      text = ''
        icon_path=${pkgs.myPackages.oxylite-icon-theme}/share/icons/Oxylite
        icon=''${icon_path}/devices/audio-speakers.svg
        icon_mute=''${icon_path}/status/audio-volume-muted.svg
        notif_time=500

        send_notification() {
            volume=$(pamixer --get-volume)
            notify-send -i "$1" -u low "volume:" "$volume%" -h int:value:"$volume" -h string:x-canonical-private-synchronous:volume -t "$notif_time"
        }

        case $1 in
        up)
            # Set the volume on (if it was muted)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$2%+"
            send_notification "$icon"
            ;;
        down)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$2%-"
            send_notification "$icon"
            ;;
        mute)
            wpctl set-mute @DEFAULT_SINK@ toggle
            if "$(pamixer --get-mute)"; then
                notify-send -i "$icon_mute" -t $notif_time -u low "volume:" "muted" -h string:x-canonical-private-synchronous:volume -t "$notif_time"
            else
                send_notification "$icon"
            fi
            ;;
        esac
      '';
    })
  ];
}
