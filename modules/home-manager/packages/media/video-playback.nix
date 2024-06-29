{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  options.videoPlayback.enable = lib.mkEnableOption ''
    Install software to view videos.
  '';

  config = lib.mkIf config.videoPlayback.enable {
    programs = {
      mpv = {
        enable = true;
        bindings = {
          # seeking
          l = "seek 5";
          h = "seek -5";
          j = "seek -60";
          k = "seek 60";
          S = "cycle sub";

          # sponsorblock
          "alt+h" = "script-binding sponsorblock/upvote_segment,";
          "alt+shift+h" = "script-binding sponsorblock/upvote_segment,";

          # video reload
          p = "write-watch-later-config ; loadfile '\${path}'";

          # quality menu
          F = "script-binding quality_menu/video_formats_toggle";
          "Alt+f" = "script-binding quality_menu/audio_formats_toggle";
        };

        config = {
          vo = "gpu-next";
          hwdec = "vaapi";
          keep-open = "yes";

          video-sync = "display-resample";
          profile = "fast";

          ytdl-format = "bestvideo[vcodec^=avc1][height<=1080]+bestaudio[acodec^=opus]/best[vcodec^=avc1][height<=1080]";
          ytdl-raw-options = "write-auto-subs=,sub-lang='en.*'";
        };
        scripts =
          with pkgs;
          with mpvScripts;
          [
            sponsorblock
            mpv-playlistmanager
            quality-menu
          ];
      };
    };
    home.packages = [
      pkgs-unstable.freetube
      pkgs.yt-dlp

      (pkgs.writeShellApplication {
        name = "mpvl";
        runtimeInputs = with pkgs; [
          wl-clipboard
          dunst
          yt-dlp
        ];
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
