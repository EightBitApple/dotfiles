{
  config,
  lib,
  userSettings,
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

  # https://wiki.nixos.org/wiki/SSH_public_key_authentication
  users.users."${userSettings.username}".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMAitZRkQhGULZ4579RVdc0VCQ9S2SEwQ5wHL6V9yplE ${userSettings.username}" # content of authorized_keys file
    # note: ssh-copy-id will add user@your-machine after the public key
    # but we can remove the "@your-machine" part
  ];

  wireless = {
    interfaces = [ "wlan0" ];
    networks."${config.sops.wpa.network1.SSID.path}".psk = "${config.sops.wpa.network1.psk}";
  };

  services.create_ap.settings = {
    GATEWAY = "192.168.5.1";
    INTERNET_IFACE = "end0";
    SSID = "${config.sops.wpa.network2.SSID.path}";
    PASSPHRASE = "${config.sops.wpa.network2.SSID.path}";
    WIFI_IFACE = "wlp1s0u1u4";
  };

  system.autoUpgrade.allowReboot = true;
}
