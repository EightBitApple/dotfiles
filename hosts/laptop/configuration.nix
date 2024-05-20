{ config, pkgs, inputs, lib, ... }:

{
  networking.hostName = lib.mkForce "laptop";
  imports = [ ./hardware-configuration.nix ];
  rtl88xxau-aircrack.enable = false;
  steam.enable = false;
  mount-drive.enable = false;
}
