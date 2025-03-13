{ pkgs, ... }:

let
  mpvScripts = with pkgs.mpvScripts; [
    sponsorblock
    mpv-playlistmanager
    quality-menu
  ];
in
{
  nixpkgs.overlays = [
    (final: prev: {
      myPackages = {
        diinki-aero = pkgs.callPackage ./diinki-aero.nix { };
      };
    })

    (final: prev: { mpv = prev.mpv.override { scripts = mpvScripts; }; })
  ];
}
