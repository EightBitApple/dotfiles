{ config, lib, ... }:

{

  options.firewall.enable = lib.mkEnableOption ''
    Configure firewall rules.
  '';
  config = lib.mkIf config.firewall.enable {
    networking.firewall = {
      enable = true;

      allowedTCPPorts = [
        22000
        21027
      ]; # syncthing

      allowedUDPPorts = [
        22000
        21027
      ]; # syncthing
    };
  };
}
