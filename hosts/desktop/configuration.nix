{ config, pkgs, inputs, ... }:

{
  imports = [ ./hardware-configuration.nix ];
  thinkfan.enable = false;
  brillo.enable = false;
}
