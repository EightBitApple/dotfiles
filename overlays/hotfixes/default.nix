{
  nixpkgs.overlays = [
    (import ./swaync.nix)
    (import ./nixpkgs.nix)
  ];
}
