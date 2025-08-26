{
  nixpkgs.overlays = [
    (final: prev: {
      freetube = prev.freetube.overrideAttrs (old: rec {
        pname = "freetube-hotfix";
        version = "0.23.8";

        src = prev.fetchFromGitHub {
          owner = "FreeTubeApp";
          repo = "FreeTube";
          tag = "v${version}-beta";
          hash = "sha256-CHp/6/E/v6UdSe3xoB66Ot24WuZDPdmNyUG1w2w3bX0=";
        };

        yarnOfflineCache = prev.fetchYarnDeps {
          yarnLock = "${src}/yarn.lock";
          hash = "sha256-ia5wLRt3Hmo4/dsB1/rhGWGJ7LMnVR9ju9lSlQZDTTg=";
        };
      });
    })
  ];
}
