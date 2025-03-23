{ lib, ... }:

{
  networking.hostName = lib.mkForce "laptop";
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./overrides/accounts.nix
    ./overrides/boot.nix
    ./overrides/tlp.nix
  ];

  disabledModules = [
    ../../modules/nixos/kernel/drivers/realtek-88xxau.nix
    ../../modules/nixos/nix/auto-upgrade.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/services/networking/access-point.nix
    ../../modules/nixos/services/networking/open-ssh.nix
    ../../modules/nixos/services/networking/wpa-supplicant.nix
    ../../modules/nixos/system/mount-drive.nix
    ../../modules/nixos/system/uboot.nix
  ];
}
