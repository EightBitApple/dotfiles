{ config, lib, pkgs, ... }:

{
  options.brillo.enable = lib.mkEnableOption ''
    Enable the brillo backlight controller in userspace.
  '';

  config = lib.mkIf config.brillo.enable { hardware.brillo.enable = true; };
}
