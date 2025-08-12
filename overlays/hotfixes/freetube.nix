{
  nixpkgs.overlays = [
    (final: prev: {
      freetube = prev.freetube.overrideAttrs (old: rec {
        pname = "freetube";
        version = "0.23.6";

        src = prev.fetchFromGitHub {
          owner = "FreeTubeApp";
          repo = "FreeTube";
          tag = "v${version}-beta";
          hash = "sha256-Z1L45RHlmylfqKBY37PC5TQ3ubOgH0AHFGM7VkmtkZ0=";
        };

        yarnOfflineCache = prev.fetchYarnDeps {
          yarnLock = "${src}/yarn.lock";
          hash = "sha256-ia5wLRt3Hmo4/dsB1/rhGWGJ7LMnVR9ju9lSlQZDTTg=";
        };
      });
    })
  ];
}
