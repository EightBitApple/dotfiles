{ config, lib, ... }:

{
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
    enableIPv6 = false;
  };
}
