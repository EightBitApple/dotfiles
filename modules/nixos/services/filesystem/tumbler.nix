{ config, lib, ... }:

{
  options.tumbler.enable = lib.mkEnableOption ''
    Enable thumbnails for XFCE Thunar.
  '';

  config = lib.mkIf config.tumbler.enable { services.tumbler.enable = true; };
}
