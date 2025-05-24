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
    (final: prev: { mpv = prev.mpv.override { scripts = mpvScripts; }; })
  ];
}
