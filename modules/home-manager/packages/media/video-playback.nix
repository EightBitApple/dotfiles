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
        keep-open = "yes";

        geometry = "50%";

        video-sync = "display-resample";
        profile = "fast";

        ytdl-format = "bestvideo[vcodec^=avc1][height<=1080]+bestaudio";
        sub-auto = "fuzzy";
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
        mpv "$(wl-paste)"
      '';
    })
  ];
}
