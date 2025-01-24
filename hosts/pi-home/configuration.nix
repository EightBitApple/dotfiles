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
    ../../modules/nixos/hardware/brillo.nix
    ../../modules/nixos/hardware/intel-hwdec.nix
    ../../modules/nixos/hardware/microcode-updates.nix
    ../../modules/nixos/kernel/hid/apple-hid.nix
    ../../modules/nixos/programs/gaming.nix
    ../../modules/nixos/programs/hyprland.nix
    ../../modules/nixos/programs/theming.nix
    ../../modules/nixos/programs/thunar.nix
    ../../modules/nixos/programs/wireshark.nix
    ../../modules/nixos/programs/zsh.nix
    ../../modules/nixos/services/device/printing.nix
    ../../modules/nixos/services/device/tlp.nix
    ../../modules/nixos/services/device/udev.nix
    ../../modules/nixos/services/filesystem/gvfs.nix
    ../../modules/nixos/services/filesystem/tumbler.nix
    ../../modules/nixos/services/networking/dnscrypt.nix
    ../../modules/nixos/services/networking/network-manager.nix
    ../../modules/nixos/services/networking/ssh-agent.nix
    ../../modules/nixos/services/security/gnupg.nix
    ../../modules/nixos/services/security/physlock.nix
    ../../modules/nixos/services/sound/pipewire.nix
    ../../modules/nixos/system/bootloader.nix
    ../../modules/nixos/system/mount-drive.nix
  ];

  users.users."${userSettings.username}" = {
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };

  system.autoUpgrade.allowReboot = true;
}
