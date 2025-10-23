{
  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = prev.yt-dlp.overrideAttrs (old: rec {
        pname = "yt-dlp-hotfix";
        version = "2025.10.22";

        src = prev.fetchFromGitHub {
          owner = "yt-dlp";
          repo = "yt-dlp";
          tag = version;
          hash = "sha256-jQaENEflaF9HzY/EiMXIHgUehAJ3nnDT9IbaN6bDcac=";
        };
      });
    })
  ];
}
