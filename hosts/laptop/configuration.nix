{
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  networking.hostName = lib.mkForce "laptop";
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  rtl88xxau-aircrack.enable = false;
  gaming.enable = false;
  mount-drive.enable = false;
  plasma6.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
