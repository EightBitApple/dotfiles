{ config, lib, pkgs, ... }:

{
  options.nix-flakes.enable = lib.mkEnableOption ''
    Enable Nix's experimental features, such as new nix* commands and flakes.
  '';

  config = lib.mkIf config.nix-flakes.enable {
    nix.nix-flakes.experimental-features = [ "nix-command" "flakes" ];
  };
}
