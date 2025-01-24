{
  lib,
  userSettings,
  pkgs,
  ...
}:

{
  networking.hostName = lib.mkForce "pi-home";
  imports = [ ./hardware-configuration.nix ];

  disabledModules = [
    ../../modules/nixos/kernel/drivers/rtl88xxau-aircrack.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/system/mount-drive.nix
    ../../modules/nixos/users/accounts.nix
  ];

  users.users."pi" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };

  system.autoUpgrade.allowReboot = true;
}
