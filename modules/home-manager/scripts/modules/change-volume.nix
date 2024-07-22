{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.changeVolume.enable = lib.mkEnableOption ''
    Enable script to change volume.
  '';

  config = lib.mkIf config.changeVolume.enable {
    home.packages = with pkgs; [
      (pkgs.writeShellApplication {
        name = "changevolume";
        runtimeInputs = with pkgs; [
          dunst
          pamixer
        ];
        text = ''
          notif_time=750

          send_notification() {
            volume=$(pamixer --get-volume)
            notify-send -a "changevolume" -u low -r "9993" -h int:value:"$volume" "Volume: $volume%" -t $notif_time
          }

          case $1 in
          up)
            # Set the volume on (if it was muted)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$2%+"
            send_notification "$1"
          ;;
          down)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
            wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$2%-"
            send_notification "$1"
          ;;
          mute)
            wpctl set-mute @DEFAULT_SINK@ toggle
            if "$(pamixer --get-mute)"; then
            notify-send -a "changevolume" -t $notif_time -r 9993 -u low "Muted"
          else
            send_notification "$1"
          fi
          ;;
          esac
        '';
      })
    ];
  };
}
