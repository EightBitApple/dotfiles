{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot/bootloader.nix

    ./kernel/hid/apple/apple-hid.nix
    ./kernel/zram/zram.nix
    ./kernel/zram/swappiness-tweaks.nix
    ./kernel/packages/rtl88xxau-aircrack.nix

    ./services/sound/pipewire.nix
    ./services/printing.nix
    ./services/physlock.nix
    ./services/fstrim.nix
    ./services/dnscrypt.nix
    ./services/gvfs.nix
    ./services/tumbler.nix

    ./networking/network.nix

    ./nix/experimental-features.nix
    ./system/locale.nix
    ./system/mount-drive.nix

    ./hardware/bluetooth.nix
    ./hardware/microcode-updates.nix

    ./console/keymap.nix

    ./users/groups.nix
    ./users/accounts.nix

    ./packages/nixpkgs-config.nix
    ./packages/system-packages.nix

    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/steam.nix
    ./programs/wireshark.nix
    ./programs/thunar.nix
    ./programs/hyprland.nix
  ];

  bootloader.enable = lib.mkDefault true;

  apple-hid.enable = lib.mkDefault true;
  zram.enable = lib.mkDefault true;
  swappiness-tweaks.enable = lib.mkDefault true;
  rtl88xxau-aircrack.enable = lib.mkDefault false;

  pipewire.enable = lib.mkDefault true;
  printing.enable = lib.mkDefault true;
  physlock.enable = lib.mkDefault true;
  fstrim.enable = lib.mkDefault true;
  dnscrypt.enable = lib.mkDefault true;
  gvfs.enable = lib.mkDefault true;
  tumbler.enable = lib.mkDefault true;

  network.enable = lib.mkDefault true;

  experimental-features.enable = lib.mkDefault true;
  locale.enable = lib.mkDefault true;
  mount-drive.enable = lib.mkDefault false;

  bluetooth.enable = lib.mkDefault true;
  microcode-updates.enable = lib.mkDefault true;

  keymap.enable = lib.mkDefault true;

  groups.enable = lib.mkDefault true;
  accounts.enable = lib.mkDefault true;

  nixpkgs-config.enable = lib.mkDefault true;
  system-packages.enable = lib.mkDefault true;

  git.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  steam.enable = lib.mkDefault false;
  wireshark.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;

  system.stateVersion = "23.11";
}
