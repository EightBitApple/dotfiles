{ lib, ... }:

{
  networking.hostName = lib.mkForce "laptop";
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./overrides/accounts.nix
    ./overrides/boot.nix
  ];

  disabledModules = [
    ../../modules/nixos/kernel/drivers/rtl88xxau-aircrack.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/programs/searx.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/services/networking/access-point.nix
    ../../modules/nixos/services/networking/open-ssh.nix
    ../../modules/nixos/services/networking/wpa-supplicant.nix
    ../../modules/nixos/system/mount-drive.nix
    ../../modules/nixos/system/uboot.nix
  ];
}
