{ lib, pkgs, ... }:

{
  networking.hostName = lib.mkForce "laptop";
  imports = [ ./hardware-configuration.nix ];
  rtl88xxau-aircrack.enable = false;
  gaming.enable = false;
  mount-drive.enable = false;
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
