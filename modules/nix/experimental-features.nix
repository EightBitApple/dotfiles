{ config, lib, pkgs, ... }:

{
  options.experimental-features.enable = lib.mkEnableOption ''
    Enable Nix's experimental features, such as new nix* commands and flakes.
  '';

  config = lib.mkIf config.experimental-features.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
