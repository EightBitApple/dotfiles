{ config, lib, pkgs, ... }:

{
  options.parameters.enable = lib.mkEnableOption ''
    Enable kernel parameters.
  '';

  config = lib.mkIf config.parameters.enable {
    boot.kernelParams = [ "video=DP-1:1920x1080@75" ];
  };
}
