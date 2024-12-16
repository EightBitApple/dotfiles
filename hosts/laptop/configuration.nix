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

  disabledModules = [
    ../../modules/nixos/kernel/drivers/rtl88xxau-aircrack.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/system/mount-drive.nix
    ../../modules/nixos/services/device/printing.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "options"
      "thinkpad_acpi"
      "fan_control=1"
    ];
  };
}
