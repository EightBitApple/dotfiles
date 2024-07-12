{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./boot/bootloader.nix

    ./kernel/hid/apple/apple-hid.nix
    ./kernel/zram/zram.nix
    ./kernel/zram/swappiness-tweaks.nix
    ./kernel/packages/rtl88xxau-aircrack.nix
    ./kernel/parameters.nix

    ./services/sound/pipewire.nix
    ./services/printing.nix
    ./services/physlock.nix
    ./services/fstrim.nix
    ./services/dnscrypt.nix
    ./services/gvfs.nix
    ./services/tumbler.nix
    ./services/udev.nix
    ./services/emacs-daemon.nix
    ./services/thinkfan.nix
    ./services/tlp.nix

    ./networking/network.nix

    ./nix/experimental-features.nix

    ./system/locale.nix
    ./system/mount-drive.nix
    ./system/virtualisation.nix

    ./hardware/bluetooth.nix
    ./hardware/microcode-updates.nix
    ./hardware/brillo.nix
    ./hardware/intel-hwdec.nix

    ./console/keymap.nix

    ./users/groups.nix
    ./users/accounts.nix

    ./packages/nixpkgs-config.nix
    ./packages/system-packages.nix

    ./programs/git.nix
    ./programs/zsh.nix
    ./programs/gaming.nix
    ./programs/wireshark.nix
    ./programs/thunar.nix
    ./programs/hyprland.nix
    ./programs/dconf.nix
  ];

  bootloader.enable = lib.mkDefault true;

  apple-hid.enable = lib.mkDefault true;
  zram.enable = lib.mkDefault true;
  swappiness-tweaks.enable = lib.mkDefault true;
  rtl88xxau-aircrack.enable = lib.mkDefault true;
  parameters.enable = lib.mkDefault true;

  pipewire.enable = lib.mkDefault true;
  printing.enable = lib.mkDefault true;
  physlock.enable = lib.mkDefault true;
  fstrim.enable = lib.mkDefault true;
  dnscrypt.enable = lib.mkDefault true;
  gvfs.enable = lib.mkDefault true;
  tumbler.enable = lib.mkDefault true;
  udev.enable = lib.mkDefault true;

  network.enable = lib.mkDefault true;

  experimental-features.enable = lib.mkDefault true;
  locale.enable = lib.mkDefault true;
  mount-drive.enable = lib.mkDefault true;
  virtualisation.enable = lib.mkDefault true;

  bluetooth.enable = lib.mkDefault true;
  microcode-updates.enable = lib.mkDefault true;
  brillo.enable = lib.mkDefault true;
  intelHwdec.enable = lib.mkDefault true;

  keymap.enable = lib.mkDefault true;

  groups.enable = lib.mkDefault true;
  accounts.enable = lib.mkDefault true;

  nixpkgs-config.enable = lib.mkDefault true;
  system-packages.enable = lib.mkDefault true;

  git.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  gaming.enable = lib.mkDefault true;
  wireshark.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  dconf.enable = lib.mkDefault true;
  emacsDaemon.enable = lib.mkDefault true;
  thinkfan.enable = lib.mkDefault true;
  tlp.enable = lib.mkDefault true;

  system.stateVersion = "23.11";
}
