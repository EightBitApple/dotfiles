{ lib, ... }:

{
  networking.hostName = lib.mkForce "desktop";
  imports = [ ./hardware-configuration.nix ];
  brillo.enable = false;
  tlp.enable = false;
  intelHwdec.enable = false;
  thinkfan.enable = false;
}
