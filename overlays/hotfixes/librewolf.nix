{
  nixpkgs.overlays = [
    (final: prev: {
      librewolf-bin-unwrapped = prev.callPackage (prev.fetchurl {
        url = "https://raw.githubusercontent.com/arehtyH/nixpkgs/d61dc66dd70b3c0e23187f5340ab6ef74e5eb270/pkgs/by-name/li/librewolf-bin-unwrapped/package.nix";
        hash = "sha256-ubBzCLFdfcLUh4n6KrAYWVRARRZ2NDY5HF9w8r0eR3A=";
      }) { };
    })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "librewolf-bin-unwrapped-150.0-1"
  ];
}
