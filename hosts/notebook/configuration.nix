{
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  networking.hostName = lib.mkForce "notebook";
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
  ];

  disabledModules = [
    ../../modules/nixos/kernel/drivers/rtl88xxau-aircrack.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/system/mount-drive.nix
    ../../modules/nixos/system/virtualisation.nix
  ];
}
