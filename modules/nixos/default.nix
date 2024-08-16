{ lib, ... }:

{
  imports = [
    ./boot/bootloader.nix

    ./kernel/hid/apple-hid.nix
    ./kernel/memory/zram.nix
    ./kernel/packages/rtl88xxau-aircrack.nix

    ./services/sound/pipewire.nix
    ./services/device/printing.nix
    ./services/security/pam.nix
    ./services/device/fstrim.nix
    ./services/networking/dnscrypt.nix
    ./services/filesystem/gvfs.nix
    ./services/filesystem/tumbler.nix
    ./services/device/udev.nix
    ./services/daemon/emacs-daemon.nix
    ./services/device/tlp.nix
    ./services/display/ly.nix

    ./networking/network.nix
    ./networking/firewall.nix

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

    ./packages/pkgs-unfree.nix

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
  rtl88xxau-aircrack.enable = lib.mkDefault true;

  pipewire.enable = lib.mkDefault true;
  printing.enable = lib.mkDefault true;
  pam.enable = lib.mkDefault true;
  fstrim.enable = lib.mkDefault true;
  dnscrypt.enable = lib.mkDefault true;
  gvfs.enable = lib.mkDefault true;
  tumbler.enable = lib.mkDefault true;
  udev.enable = lib.mkDefault true;

  network.enable = lib.mkDefault true;
  firewall.enable = lib.mkDefault true;

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

  pkgs-unfree.enable = lib.mkDefault true;

  git.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  gaming.enable = lib.mkDefault true;
  wireshark.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  dconf.enable = lib.mkDefault true;
  emacsDaemon.enable = lib.mkDefault true;
  tlp.enable = lib.mkDefault true;
  ly.enable = lib.mkDefault true;

  system.stateVersion = "23.11";
}
