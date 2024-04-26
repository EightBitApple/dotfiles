{ config, lib, pkgs, ... }:

{
  options.bluetooth.enable = lib.mkEnableOption ''
    Enable and configure Bluetooth.
  '';

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };
}
