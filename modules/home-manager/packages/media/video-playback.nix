{ config, lib, pkgs, ... }:

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

          ytdl-format =
            "bestvideo[vcodec^=avc1][height<=1080]+bestaudio[acodec^=opus]/best[vcodec^=avc1][height<=1080]";
          ytdl-raw-options = "write-auto-subs=,sub-lang='en.*'";
        };
        scripts = with pkgs;
          with mpvScripts; [
            sponsorblock
            mpv-playlistmanager
            quality-menu
          ];
      };
    };
    home.packages = with pkgs; [ freetube yt-dlp ];
  };
}
