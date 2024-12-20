{ pkgs, userSettings, ... }:

{
  programs = {
    mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            sponsorblock
            mpv-playlistmanager
            quality-menu
          ];
          mpv = pkgs.mpv-unwrapped.override { ffmpeg = pkgs.ffmpeg-full; };
        }
      );
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
        ytdl-raw-options = "ignore-config=,sub-format='^en.*',write-sub=,downloader=aria2c,downloader-args='-c -j 3 -x 3 -s 3 -k 1M'";
      };
    };
  };
  home.packages = with pkgs; [
    freetube
    yt-dlp
    aria2

    (writeShellApplication {
      name = "mpvl";
      runtimeInputs = with pkgs; [ wl-clipboard ];
      text = ''
        ${userSettings.terminal} --hold -e mpv "$(wl-paste)"
      '';
    })
  ];
}
