(final: prev: {
  freetube = prev.freetube.overrideAttrs (old: rec {
    version = "0.24.1";
    src = prev.fetchFromGitHub {
      owner = "FreeTubeApp";
      repo = "FreeTube";
      tag = "v${version}-beta";
      hash = "sha256-oo5ozdP3d82jY8OOYrt568MoSfPmwBoitdtgESiRMlE=";
    };

    yarnOfflineCache = prev.fetchYarnDeps {
      yarnLock = "${src}/yarn.lock";
      hash = "sha256-9rO/XYfOf1TEQOpb5clCfdTiuDeynpnk6L4WpcIIWGk=";
    };
  });
})
