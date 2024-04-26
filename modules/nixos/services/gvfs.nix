{ config, lib, pkgs, ... }:

{
  options.gvfs.enable = lib.mkEnableOption ''
    Enable GVFS for automatic drive partition mounting and trashcan
    functionality.
  '';

  config = lib.mkIf config.gvfs.enable { services.gvfs.enable = true; };
}
