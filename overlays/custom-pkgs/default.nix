{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      myPackages = {
        diinki-aero = pkgs.callPackage ./diinki-aero.nix { };
        oxylite-icon-theme = pkgs.callPackage ./oxylite.nix { };
        modern-xp-cursor-theme = pkgs.callPackage ./modern-xp.nix { };
      };
    })
  ];
}
