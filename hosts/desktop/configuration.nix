{ lib, ... }:

{
  networking.hostName = lib.mkForce "desktop";
  imports = [ ./hardware-configuration.nix ];
  thinkfan.enable = false;
  brillo.enable = false;
  tlp.enable = false;
  intelHwdec.enable = false;
}
