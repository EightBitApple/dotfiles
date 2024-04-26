{ config, lib, pkgs, ... }:

{
  options.htop.enable = lib.mkEnableOption ''
    Install and configure htop.
  '';

  config = lib.mkIf config.htop.enable { programs.htop.enable = true; };
}
