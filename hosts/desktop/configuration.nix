{ lib, userSettings, ... }:

{
  networking.hostName = lib.mkForce "desktop";
  imports = [ ./hardware-configuration.nix ];
  brillo.enable = false;
  tlp.enable = false;
  intelHwdec.enable = false;

  system.autoUpgrade = {
    flags = [ "--flake /home/${userSettings.username}/.dotfiles#desktop" ];
  };
}
