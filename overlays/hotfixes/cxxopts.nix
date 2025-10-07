{
  nixpkgs.overlays = [
    (final: prev: {
      cxxopts = prev.callPackage (prev.fetchurl {
        url = "https://raw.githubusercontent.com/uninsane/nixpkgs/313196be92f7c941f21cde338c48b0dd106da1a1/pkgs/by-name/cx/cxxopts/package.nix";
        hash = "sha256-QIgBP3CrQcrYMlxPrkcEqbF8UVo9F4z94mdD4im5epQ=";
      }) { };
    })
  ];
}
