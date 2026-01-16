{
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./nixos/boot.nix
    ./nixos/services/networking/hostname.nix
    ./nixos/users/accounts.nix
  ];

  disabledModules = [
    ../../modules/nixos/kernel/drivers/realtek-88xxau.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/services/networking/access-point.nix
    ../../modules/nixos/services/networking/open-ssh.nix
    ../../modules/nixos/system/mount-drive.nix
    ../../modules/nixos/system/uboot.nix
  ];
}
