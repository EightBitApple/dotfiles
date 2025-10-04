{ pkgs, userSettings, ... }:

{
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

        ENTER = "cycle pause";

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
        hwdec = "auto";
        gpu-api = "opengl";
        keep-open = "yes";

        video-sync = "display-resample";
        interpolation = "yes";

        ytdl-raw-options = "force-ipv4=,extractor-args=\"youtube:player-client=default,-tv_simply\"";
        ytdl-format = "bestvideo[vcodec^=avc1][height<=1080]+bestaudio";

        sub-border-style = "opaque-box";
      };
    };
  };
  home.packages = with pkgs; [
    freetube
    yt-dlp

    (writeShellApplication {
      name = "mpvl";
      runtimeInputs = with pkgs; [ wl-clipboard ];
      text = ''
        ${userSettings.terminal.name} --hold -e mpv "$(wl-paste)"
      '';
    })
  ];
}
