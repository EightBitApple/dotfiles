{
  nixpkgs.overlays = [
    (final: prev: {
      clisp = prev.callPackage (prev.fetchurl {
        url = "https://raw.githubusercontent.com/NixOS/nixpkgs/c1bdb17d00d772ffe08b78e9912d13b5700ae170/pkgs/development/interpreters/clisp/default.nix";
        hash = "sha256-M3p8+/Px77vHRKGFHe6vdNEJWdMN+dVurEWrOevR1BU=";
      }) { };
    })
  ];
}
