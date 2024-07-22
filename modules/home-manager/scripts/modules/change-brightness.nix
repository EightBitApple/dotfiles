{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.changeBrightness.enable = lib.mkEnableOption ''
    Enable script to change brightness.
  '';

  config = lib.mkIf config.changeBrightness.enable {
    home.packages = with pkgs; [
      (writeShellApplication {
        name = "changebrightness";
        runtimeInputs = [ brillo ];
        text = ''
          notif_time=750

          send_notification() {
            notify-send -a "changebrightness" -u low -r "9993" "Brightness: $(brillo -G)%" -t $notif_time
          }

          case $1 in
          up)
            brillo -u 150000 -q -A "$2"
            send_notification "$1"
            ;;
          down)
            brillo -u 150000 -q -U "$2"
            send_notification "$1"
            ;;
          esac
        '';
      })
    ];
  };
}
