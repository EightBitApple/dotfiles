{ lib, userSettings, ... }:

{
  networking.hostName = lib.mkForce "desktop";
  imports = [ ./hardware-configuration.nix ];
  brillo.enable = false;
  tlp.enable = false;
  intelHwdec.enable = false;
  plasma6.enable = false;
  printing.enable = false;
}
