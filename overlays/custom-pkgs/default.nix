{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      myPackages = {
        windows-vista-theme = pkgs.callPackage ./windows-vista.nix { };
        oxylite-icon-theme = pkgs.callPackage ./oxylite.nix { };
      };
    })
  ];
}
