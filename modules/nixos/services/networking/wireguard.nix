{ pkgs, ... }:

{
  networking = {
    firewall.allowedUDPPorts = [ 51820 ];
  };

  environment.systemPackages = [ pkgs.wireguard-tools ];
}
