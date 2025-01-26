{
  config,
  lib,
  pkgs,
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
  users.users."${userSettings.username}" = {
    hashedPasswordFile = config.sops.secrets."passwords/pi-home".path;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMAitZRkQhGULZ4579RVdc0VCQ9S2SEwQ5wHL6V9yplE ${userSettings.username}" # content of authorized_keys file
      # note: ssh-copy-id will add user@your-machine after the public key
      # but we can remove the "@your-machine" part
    ];
  };
  networking.wireless = {
    interfaces = [ "wlan0" ];
    # https://github.com/NixOS/nixpkgs/issues/342140#issuecomment-2365125619
    allowAuxiliaryImperativeNetworks = true;
  };

  systemd.services.create_ap = {
    serviceConfig.ExecStart = lib.mkForce "${pkgs.linux-wifi-hotspot}/bin/create_ap --config ${config.sops.templates."create_ap.conf".path}";
  };

  system.autoUpgrade.allowReboot = true;
}
