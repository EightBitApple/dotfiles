{
  nixpkgs.overlays = [
    (import ./iconpack-obsidian.nix)
  ];
}
