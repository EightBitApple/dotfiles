{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (import ./intel-vaapi-driver.nix)
  ];
}
