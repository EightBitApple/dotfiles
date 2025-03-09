{
  config,
  lib,
  pkgs,
  userSettings,
  ...
}:

{
  networking.hostName = lib.mkForce "pi-home";
  imports = [
    ./hardware-configuration.nix
    ./overrides/access-point.nix
    ./overrides/accounts.nix
    ./overrides/wpa-supplicant.nix
  ];

  disabledModules = [
    ../../modules/nixos/hardware/brillo.nix
    ../../modules/nixos/hardware/intel-hwdec.nix
    ../../modules/nixos/hardware/microcode-updates.nix
    ../../modules/nixos/kernel/hid/apple-hid.nix
    ../../modules/nixos/programs/emacs.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/programs/hyprland.nix
    ../../modules/nixos/programs/searx.nix
    ../../modules/nixos/programs/theming.nix
    ../../modules/nixos/programs/wireshark.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/services/device/tlp.nix
    ../../modules/nixos/services/device/udev.nix
    ../../modules/nixos/services/filesystem/gvfs.nix
    ../../modules/nixos/services/networking/dnscrypt.nix
    ../../modules/nixos/services/networking/network-manager.nix
    ../../modules/nixos/services/networking/ssh-agent.nix
    ../../modules/nixos/services/security/gnupg.nix
    ../../modules/nixos/services/security/physlock.nix
    ../../modules/nixos/services/sound/pipewire.nix
    ../../modules/nixos/system/bootloader.nix
    ../../modules/nixos/system/mount-drive.nix
    ../../modules/nixos/system/virtualisation.nix
  ];


  system.autoUpgrade.allowReboot = true;
}
