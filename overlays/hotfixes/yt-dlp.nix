{
  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = prev.yt-dlp.overrideAttrs (old: rec {
        pname = "yt-dlp-hotfix";
        version = "2025.10.14";

        src = prev.fetchFromGitHub {
          owner = "yt-dlp";
          repo = "yt-dlp";
          tag = version;
          hash = "sha256-x7vpuXUihlC4jONwjmWnPECFZ7xiVAOFSDUgBNvl+aA=";
        };
      });
    })
  ];
}
