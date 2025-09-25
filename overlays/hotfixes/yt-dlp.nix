{
  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = prev.yt-dlp.overrideAttrs (old: rec {
        pname = "yt-dlp-hotfix";
        version = "2025.09.23";

        src = prev.fetchFromGitHub {
          owner = "yt-dlp";
          repo = "yt-dlp";
          tag = version;
          hash = "sha256-pqdR1JfiqvBs5vSKF7bBBKqq0DRAi3kXCN1zDvaW3nQ=";
        };
      });
    })
  ];
}
