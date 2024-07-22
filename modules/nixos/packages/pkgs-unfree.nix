{ config, lib, ... }:

{
  options.pkgs-unfree.enable = lib.mkEnableOption ''
    Configure Nixpkgs to allow unfree software.
  '';

  config = lib.mkIf config.pkgs-unfree.enable { nixpkgs.config.allowUnfree = true; };
}
