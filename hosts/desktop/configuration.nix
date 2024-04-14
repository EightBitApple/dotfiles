{ config, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  rtl88xxau-aircrack.enable = true;
  steam.enable = true;
  mount-drive.enable = true;
}
