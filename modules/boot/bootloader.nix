{ config, lib, pkgs, ... }:

{
  options.bootloader.enable = lib.mkEnableOption "Enables systemd-boot.";

  config = lib.mkIf config.bootloader.enable {
    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
