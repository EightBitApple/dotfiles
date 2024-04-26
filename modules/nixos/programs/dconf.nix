{ config, lib, pkgs, ... }:

{
  options.dconf.enable = lib.mkEnableOption ''
    Enable dconf.
  '';

  config = lib.mkIf config.dconf.enable { programs.dconf.enable = true; };
}
