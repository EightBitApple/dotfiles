{ config, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  rtl88xxau-aircrack.enable = false;
  steam.enable = false;
  mount-drive.enable = false;
}
