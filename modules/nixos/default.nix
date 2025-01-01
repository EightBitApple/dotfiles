{ lib, ... }:

{
  imports = [
    ./hardware/bluetooth.nix
    ./hardware/brillo.nix
    ./hardware/intel-hwdec.nix
    ./hardware/microcode-updates.nix
    ./kernel/drivers/rtl88xxau-aircrack.nix
    ./kernel/hid/apple-hid.nix
    ./kernel/memory/zram.nix
    ./nix/auto-optimise.nix
    ./nix/auto-upgrade.nix
    ./nix/experimental-features.nix
    ./nix/nix-helpers.nix
    ./nix/pkgs-unfree.nix
    ./programs/dconf.nix
    ./programs/gaming.nix
    ./programs/git.nix
    ./programs/hyprland.nix
    ./programs/theming.nix
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
    ./services/networking/network-manager.nix
    ./services/networking/ssh-agent.nix
    ./services/security/firejail.nix
    ./services/security/gnupg.nix
    ./services/security/physlock.nix
    ./services/sound/pipewire.nix
    ./system/bootloader.nix
    ./system/keymap.nix
    ./system/locale.nix
    ./system/mount-drive.nix
    ./system/virtualisation.nix
    ./users/accounts.nix
    ./users/groups.nix
  ];

  system.stateVersion = "24.05";
}
