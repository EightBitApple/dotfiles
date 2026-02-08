{
  nixpkgs.overlays = [
    (import ./swaync.nix)
  ];
}
