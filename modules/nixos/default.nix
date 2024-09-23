{ lib, ... }:

{
  imports = [
    ./boot/bootloader.nix
    ./console/keymap.nix
    ./hardware/bluetooth.nix
    ./hardware/brillo.nix
    ./hardware/intel-hwdec.nix
    ./hardware/microcode-updates.nix
    ./kernel/hid/apple-hid.nix
    ./kernel/memory/zram.nix
    ./kernel/packages/rtl88xxau-aircrack.nix
    ./networking/network.nix
    ./nix/auto-upgrade.nix
    ./nix/experimental-features.nix
    ./nix/garbage-collection.nix
    ./packages/pkgs-unfree.nix
    ./programs/dconf.nix
    ./programs/gaming.nix
    ./programs/git.nix
    ./programs/hyprland.nix
    ./programs/plasma-six.nix
    ./programs/thunar.nix
    ./programs/wireshark.nix
    ./programs/zsh.nix
    ./services/device/fstrim.nix
    ./services/device/logind.nix
    ./services/device/printing.nix
    ./services/device/tlp.nix
    ./services/device/udev.nix
    ./services/display/ly.nix
    ./services/filesystem/gvfs.nix
    ./services/filesystem/tumbler.nix
    ./services/networking/dnscrypt.nix
    ./services/networking/ssh-agent.nix
    ./services/security/pam.nix
    ./services/sound/pipewire.nix
    ./system/locale.nix
    ./system/mount-drive.nix
    ./system/virtualisation.nix
    ./users/accounts.nix
    ./users/groups.nix
  ];

  accounts.enable = lib.mkDefault true;
  apple-hid.enable = lib.mkDefault true;
  autoUpgrade.enable = lib.mkDefault true;
  bluetooth.enable = lib.mkDefault true;
  bootloader.enable = lib.mkDefault true;
  brillo.enable = lib.mkDefault true;
  dconf.enable = lib.mkDefault true;
  dnscrypt.enable = lib.mkDefault true;
  experimental-features.enable = lib.mkDefault true;
  fstrim.enable = lib.mkDefault true;
  gaming.enable = lib.mkDefault true;
  garbageCollection.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;
  groups.enable = lib.mkDefault true;
  gvfs.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  intelHwdec.enable = lib.mkDefault true;
  keymap.enable = lib.mkDefault true;
  locale.enable = lib.mkDefault true;
  logind.enable = lib.mkDefault true;
  ly.enable = lib.mkDefault true;
  microcode-updates.enable = lib.mkDefault true;
  mount-drive.enable = lib.mkDefault true;
  network.enable = lib.mkDefault true;
  pam.enable = lib.mkDefault true;
  pipewire.enable = lib.mkDefault true;
  pkgs-unfree.enable = lib.mkDefault true;
  plasma6.enable = lib.mkDefault true;
  printing.enable = lib.mkDefault true;
  rtl88xxau-aircrack.enable = lib.mkDefault true;
  sshAgent.enable = lib.mkDefault true;
  thunar.enable = lib.mkDefault true;
  tlp.enable = lib.mkDefault true;
  tumbler.enable = lib.mkDefault true;
  udev.enable = lib.mkDefault true;
  virtualisation.enable = lib.mkDefault true;
  wireshark.enable = lib.mkDefault true;
  zram.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;

  system.stateVersion = "24.05";
}
