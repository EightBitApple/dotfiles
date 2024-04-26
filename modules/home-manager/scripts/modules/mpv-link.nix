{ config, lib, pkgs, ... }:

{
  options.mpvLink.enable = lib.mkEnableOption ''
    Enable script to paste video links into MPV.
  '';

  config = lib.mkIf config.mpvLink.enable {
    home.packages = with pkgs;
      [
        (pkgs.writeShellApplication {
          name = "mpvl";
          runtimeInputs = with pkgs; [ mpv wl-clipboard dunst yt-dlp ];
          text = ''
            msg_title="MPV Link"
            msg_attempt="Attempting to play video..."
            msg_error="Error playing video. Aborting."

            notify-send "$msg_title" "$msg_attempt" &
            mpv "$(wl-paste)" "$@"
            [ $? -eq 2 ] && notify-send -t 5000 -u normal "$msg_title Error" "$msg_error" && exit 1;
          '';
        })
      ];
  };
}
