{ config, lib, pkgs, ... }:

{
  options.nixpkgs-config.enable = lib.mkEnableOption ''
    Configure Nixpkgs to allow unfree software.
  '';

  config = lib.mkIf config.nixpkgs-config.enable {
    nixpkgs.config.allowUnfree = true;
  };
}
