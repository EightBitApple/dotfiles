{
  nixpkgs.overlays = [
    (import ./nixpkgs.nix)
    (import ./swaync.nix)
  ];
}
